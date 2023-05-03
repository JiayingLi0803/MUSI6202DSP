function [dhat,e,w,whist] = nlms(x,d,mu,N)

dhat  = zeros(length(d),1);
e     = zeros(length(d), 1);
whist = zeros(N,length(d));
w = zeros(N, 1);

x = [zeros(N-1,1);x(:)];

% now implement the adaptive filter
for n = N:length(x)
    xx = x(n:-1:n-(N-1));
    % produce filtered output sample
    dhat(n-(N-1)) = w' * xx;
    % update the filter coefficients
    e(n-(N-1)) = d(n-(N-1)) - dhat(n-(N-1));
    w = w+2*mu*xx*e(n-(N-1))/(xx'*xx);
    whist(:,n-(N-1)) = w;
end

end