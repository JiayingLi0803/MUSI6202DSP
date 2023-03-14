% Question 1 Sinusoidal Generation

function [t, x] = generateSinusoidal(amplitude,sample_rate_hz,frequency_hz,length_sec,phase_radian)

    dt = 1/sample_rate_hz; % Calculated Samples per Second
    t = (0:dt:length_sec)'; % Column Vector of Period Length Based on length_sec
    t(end,:) = []; % Trimmed Column Vector to Appropriate Length

    w = 2.0*pi*frequency_hz; % Calculated Frequency Phase Angle
    x = amplitude*sin(w*t+phase_radian); % Sine Wave Equation

end 