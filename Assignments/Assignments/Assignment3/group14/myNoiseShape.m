function y = myNoiseShape(x, w, noise_type, system_variant)

if nargin < 4 % default value B
    system_variant = "B";
end

y = zeros(length(x), 1); % initialize yQuant
d = myNoiseGen(length(x), w, noise_type);
q = zeros(length(x), 1);

if system_variant == "B"
    for i = 1:length(x)
        if i == 1
            node1 = x(i) + d(i);
        else
            node1 = x(i) + d(i)-q(i-1);
        end
        quant = myQuantize(node1, w);
        y(i) = quant;
        node2 = quant - node1;
        q(i) = node2;
    end
elseif system_variant == "A"
    for i = 1:length(x)
        if i == 1
            node1 = x(i);
        else
            node1 = x(i) - q(i-1);
        end
        node2 = node1 + d(i);
        quant = myQuantize(node2, 2);
        y(i) = quant;
        q(i) = quant - node1;
    end
end
    
end