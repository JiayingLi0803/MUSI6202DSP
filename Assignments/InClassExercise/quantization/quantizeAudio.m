function yQuant = quantizeAudio(y, bitDepth)

yQuant = zeros(length(y), 1); % initialize yQuant

for i=1:length(y) % apply quantization to each point in the input signal
    yQuant(i) = quantizeMidTread(y(i), bitDepth); % quantization
end

end
