function [m, mabs, stdev, time] = compareConv(x, h)
% m: 2x1 vector of the mean difference of the outputs of 
%    both methods compared to conv()
% mabs: 2x1 vector of the mean absolute difference of the 
%       outputs of both methods compared to conv()
% stdev: 2x1 standard deviation of the difference of the 
%        outputs of both methods compared to conv() 
% time: 3x1 vector containing the running time of each 
%       method. Useful methods for measuring time: tic, toc.
time = [0; 0; 0];
tic;y_time = myTimeConv(x, h);time(1) = toc;
tic;y_freq = myTimeConv(x, h);time(2) = toc;
tic;y_conv = conv(x, h);time(3) = toc; % built in conv() function

d_time = y_time-y_conv; % difference between y_time and y_conv
d_freq = y_freq-y_conv; % difference between y_freq and y_conv

m = [sum(d_time)/length(y_conv); sum(d_freq)/length(y_conv)];
mabs = [sum(abs(d_time))/length(y_conv); sum(abs(d_freq))/length(y_conv)];
stdev = [sqrt(sum((d_time-m(1)).^2)); sqrt(sum((d_freq-m(2)).^2))];

end

