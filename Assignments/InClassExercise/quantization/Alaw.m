function y = Alaw(x, bitDepth)

A = 87.7;

% compression
if abs(x)<= 1/A
    x = sign(x)*A*abs(x)/(1+log(A));
else
    x = sign(x)*(1+log(A*abs(x)))/(1+log(A));
end

% quantization
y_quant = quantizeMidTread(x, bitDepth);

% expansion

if abs(y_quant) <= 1/(1+log(A))
    y = sign(y_quant)*abs(y_quant)*(1+log(A))/A;
else
    y = sign(y_quant)*exp(abs(y_quant)*(1+log(A))-1)/A;
end

end