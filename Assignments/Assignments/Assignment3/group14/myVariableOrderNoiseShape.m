function y = myVariableOrderNoiseShape(x, n, w, noise_type, system_variant)
if nargin < 5 % default value B
    system_variant = "B";
end

y = zeros(length(x), 1); % initialize yQuant

q = zeros(length(x)+n, 1); % right shift q(i)

if system_variant == "B"
    d = myNoiseGen(length(x)+n, w, noise_type);
    for i=1:length(x)
        y(i) = x(i);
        for j=0:n
            y(i) = y(i) + (-1)^j * nchoosek(n,j) * ( d(i+n-j) + q(i+n-j) );
        end
    end
elseif system_variant == "A"
    d = myNoiseGen(length(x), w, noise_type);
    for i = 1:length(x)
        y(i) = x(i);
        for j = 0:n
            y(i) = y(i) + (-1)^j * nchoosek(n,j) * q(i+n-j) + d(i);
        end
    end
end

end