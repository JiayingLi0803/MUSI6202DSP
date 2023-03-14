% Question 2 Sinusoidal Combination for Complex Waveform Generation
function [t, x] = generateSquare(amplitude, sample_rate_hz, frequency_hz, length_sec, phase_radian)

dt = 1/sample_rate_hz; % Calculated Samples per Second
t = (0:dt:length_sec)'; % Column Vector of Period Length Based on length_sec
t(end,:) = []; % Trimmed Column Vector to Appropriate Length
sqrWave = zeros(length(t),1); % Initializing Square Wave with Zeros
for i = 1:2:19 % 10 Sinusoidals at Odd Multiples
[t2,x2] = generateSinusoidal((amplitude), sample_rate_hz, (frequency_hz*i), length_sec, phase_radian); % Calling Sine Function
sqrWave = sqrWave + ((4/pi)*x2/i); % Sums Odd Integer Multiples to Square Wave
end
x = sqrWave; % Assigned Square Wave as return value x

end

