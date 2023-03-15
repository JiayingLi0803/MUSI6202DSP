function yQuant = nonLinearQuantAudio(y, bitDepth, method)

yQuant = zeros(length(y), 1); % initialize yQuant

if method=="A-law" % A-law
    for i=1:length(y) % apply quantization to each point in the input signal
        yQuant(i) = Alaw(y(i), bitDepth); % quantization
    end
else % mu law
    for i=1:length(y) % apply quantization to each point in the input signal
        yQuant(i) = mulaw(y(i), bitDepth); % quantization
    end
end

end
