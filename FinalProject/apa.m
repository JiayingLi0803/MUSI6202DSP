N=10; 
p = 1;
lenx = 1000;
x=randn(lenx,1);
h = rand(N,1); 
d = filter(h,1,x); 
mu = 0.1;
delta = 1e-3;

[~,e1, w1, whist1] = AffineProjection(x, d, N, p, mu, delta);
[~,e2, w2, whist2] = AffineProjection(x, d, N, p, mu);
[~,e3,w3,~] = nlms(x,d,mu,N);

% [~,e4, w4, ~] = AffineProjection(x, d, N, 2, mu, delta);
% [~,e5, w5, ~] = AffineProjection(x, d, N, 6, mu, delta);
% [~,e6, w6, ~] = AffineProjection(x, d, N, 10, mu, delta);
%% plot figures
figure(1);
subplot(3,3,[1,2,3]);stem(h);title('initial h')
subplot(3,3,4);stem(w3);title('nLMS w');
subplot(3,3,5);stem(w2);title('nonregularized w (p = 1)');
subplot(3,3,6);stem(w1);title('regularized w (p = 1: nLMS)');
subplot(3,3,7);plot(abs(e3).^2);title('nLMS e');
subplot(3,3,8);plot(abs(e2).^2);title('nonregularized e');
subplot(3,3,9);plot(abs(e1).^2);title('regularized e');

% subplot(5,3,[1,2,3]);stem(h);title('initial h')
% subplot(5,3,4);stem(w3);title('nLMS w');
% subplot(5,3,5);stem(w2);title('nonregularized w (p = 1)');
% subplot(5,3,6);stem(w1);title('regularized w (p = 1: nLMS)');
% subplot(5,3,7);plot(abs(e3).^2);title('nLMS e');
% subplot(5,3,8);plot(abs(e2).^2);title('nonregularized e');
% subplot(5,3,9);plot(abs(e1).^2);title('regularized e');
% subplot(5,3,10);stem(w4);title('regularized w (p = 2)');
% subplot(5,3,11);stem(w5);title('regularized w (p = 6)');
% subplot(5,3,12);stem(w6);title('regularized w (p = 10)');
% subplot(5,3,13);plot(abs(e4').^2);title('regularized e (p = 2)');
% subplot(5,3,14);plot(abs(e5').^2);title('regularized e (p = 6)');
% subplot(5,3,15);plot(abs(e6').^2);title('regularized e (p = 10)');

figure(2);
subplot(211);plot(whist1');title('regularized whist');
subplot(212);plot(whist2');title('nonregularized whist');
%% denoising task
[sig, fs] = audioread('bgm.wav');
x = sig(1:5*fs,1);

N=20; 
p = 3;
d = x + wgn(length(x), 1, -20);
mu = 0.1;
delta = 1e-3;

[dhat, e1, w1, whist1] = AffineProjection(x, d, N, p, mu, delta);
soundsc(dhat, fs)

snr1 = snr(x, d);
snr2 = snr(x, dhat);