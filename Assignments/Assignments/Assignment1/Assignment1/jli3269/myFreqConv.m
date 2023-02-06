function y = myFreqConv(x,h)

hh = [h; zeros(length(x)-1, 1)]; % zeropadding h
xx = [x; zeros(length(h)-1, 1)]; % zeropadding x

Fx = fft(xx); % FFT of xx
Fh = fft(hh); % FFT of hh
Fy = Fx .* Fh; % F(x*h) = Fx·Fh
y = ifft(Fy); % inverse transform to time domain
end

