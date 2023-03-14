function [f, Xabs, Xphase, Xre, Xim] = computeSpectrum(x, sample_rate_hz)

zero_pad = 2^nextpow2(length(x)); 
x_pad = [x;zeros(zero_pad-length(x),1)]; % zero pad x
X_fourier = fft(x_pad);
X_non = X_fourier(1:floor(length(x_pad)/2)+1); % Removed Redundant Part of FFT

f = (0:floor(length(x_pad)/2))*(sample_rate_hz/zero_pad);
Xabs = abs(X_non);
Xphase = angle(X_non);
Xre = real(X_non);
Xim = imag(X_non);
end