function y = myTimeConv(x,h)

if length(x)<length(h) % make sure that xx is always longer than hh
    xx = h;
    hh = x;
else
    xx = x;
    hh = h;
end

y = zeros(length(xx) + length(hh)-1, 1); % create an empty column vector

for i=1:length(hh) % convolution
    y(i:i+length(xx)-1) = y(i:i+length(xx)-1) + xx.*hh(i);
end


end