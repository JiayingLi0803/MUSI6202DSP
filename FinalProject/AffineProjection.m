function [dhat,e, w, whist] = AffineProjection(x, d, N, p, mu, delta)
% FUNCTION     : Affine Projection Filter
% 
% Usage [dhat,e, w, whist] = AffineProjection(x, d, N, p, mu, delta)
% 
%       x      : input data to the adaptive filter 
%       d      : desired output 
%       N      : estimate length of weight
%       p      : order of matrix A 
%       mu     : step size
%       delta  : regularization factor 
% 
%       dhat   : predicted output 
%       e      : e(n) - error signal 
%       w      : final weight vector 
%       whist  : weight vector history
%
% regularized affine projection filter:
% w(n+1) = w(n) + mu*A'[n]*(A[n]*A'[n] + delta*I)^(-1)*e[n]
% affine projection filter:
% w(n+1) = w(n) + mu*A'[n]*(A[n]*A'[n])^(-1)*e[n]

if nargin<6
    delta = 0;
end 

whist = zeros(N, length(x));
dhat = zeros(length(x), 1);
e = zeros(p, length(x));

x = [zeros(p+N-1,1);x(:)];
d = [zeros(p+N-1,1);d(:)];
w = zeros(N, 1);

for k=p+N:length(x)
    % create A
    A = zeros(p, N);
    for n=k:-1:k-p+1
        flag = 1;
        xx = x(n:-1:n-N+1);
        A(flag, :) = xx';
        flag = flag + 1;
    end
    % create d
    dd = d(k:-1:k-p+1);
    ddhat = A * w;
    ee = dd - ddhat;
    dhat(k-p-N+1:k-N) = ddhat;
    e(:,k-p-N+1) = ee;
    % weight update
    w = w + mu * A' * inv(A * A' + delta * eye(p)) * ee;
    whist(:, k-p-N+1) = w;
end 
dhat = dhat(p:end);
end