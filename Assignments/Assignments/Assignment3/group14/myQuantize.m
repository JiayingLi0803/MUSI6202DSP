function y = myQuantize(x,w)

y = zeros(length(x), 1); % initialize y
delta = 1/(2^(w-1));

min_value = -1; % set the clipping range
max_value = 1-delta; % clipping range: [-1, 1-delta]


for i=1:length(x) % apply quantization to each point in the input signal
    % Midtread Quantization
    if x(i) >= max_value
        y(i) = max_value;
    elseif x(i) <= min_value
        y(i) = min_value;
    else
        y(i) = round(x(i)/delta)*delta;
    end

end


end