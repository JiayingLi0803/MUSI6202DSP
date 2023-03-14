% function y = myNoiseGen(num_samples, w, noise_type) 
% delta = 1/(2^(w-1));
% 
% 
% if noise_type == "rect"
%     y = -delta + 2 * delta * rand(num_samples, 1);
% elseif noise_type == "tri"
%     y = -2 * delta + 2 * delta * rand(num_samples, 1) + 2 * delta * rand(num_samples, 1);
% elseif noise_type == "hp"
%     y = diff(-2 * delta + 2 * delta * rand(num_samples+1, 1) + 2 * delta * rand(num_samples+1, 1));
% end
% 
% 
% end

function y = myNoiseGen(num_samples, w, noise_type)

delta = 1 ./ (2.^(w-1));
rect = delta .* (0.5 - rand(num_samples, 1));

if strcmp(noise_type, 'rect')
    y = rect;
elseif strcmp(noise_type, 'tri')
    rect2 = delta .* (0.5 - rand(num_samples, 1));
    y = rect + rect2;
elseif strcmp(noise_type, 'hp')
    y = diff([0; rect]);
else
    print('Invalid noise type. Must be rect, tri, or hp')
end

end