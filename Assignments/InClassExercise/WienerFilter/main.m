[x, fs] = audioread("clean_audio.mp3");
n = randn(length(x),1); % random noise
y = x + 0.01 * n; % add noise to the signal
snr1 = snr(x,y);
nfft = 4096;
hopSize = 2048;


xhat = wienerFilter(y, n, nfft, hopSize);
snr2 = snr(x, xhat);
