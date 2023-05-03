function xhat = wienerFilter(y, n, nfft, hopSize)
%%%%%%%%%%%%%%% parameters %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%    input   %%%%%%%%%%%%%%
% y:       noisy signal, column vector
% n:       noise profile, column vector
% nfft:    length of the FFT used for estimating power spectral density
% hopSize: hop length used for estimating power spectral density
%%%%%%%%%%%%%%%    output   %%%%%%%%%%%%%%
% xhat: denoised signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
window = hamming(nfft);
noverlap = length(window) - hopSize;
Syy = pwelch(y,window,noverlap, nfft,"twosided");
Snn = pwelch(n,window,noverlap, nfft,"twosided");
H = abs(real(1-(Syy./Snn)));
h = ifft(H);
xhat = fftfilt(h, y);

end