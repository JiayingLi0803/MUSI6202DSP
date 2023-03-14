function y = quantizeMidTread(x, bitDepth)

delta = 1/(2^(bitDepth-1));
min_value = -1; % set the clipping range
max_value = 1-delta; % clipping range: [-1, 1-delta]

if x>=max_value
    y = max_value;
elseif x<=min_value
    y = min_value;
else
    y = round(x/delta)*delta;
end

end