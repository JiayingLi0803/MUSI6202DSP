function y = myDither(x, w, noise_type) 

dither = myNoiseGen(length(x), w, noise_type);
signal_dither = x + dither;
y = myQuantize(signal_dither, w);

end