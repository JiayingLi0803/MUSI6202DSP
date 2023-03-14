function y = mulaw(x, bitDepth)

mu = 255;

x = sign(x)*log(1+mu*abs(x))/(log(1+mu)); % compression

y_quant = quantizeMidTread(x, bitDepth);% quantization

y = sign(y_quant)/mu*((1+mu)^abs(y_quant)-1); % expansion

end