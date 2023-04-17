% Question 4(b) Computing FFT per block window

function [freq_vector, time_vector, magnitude_spectrogram] = mySpecgram(x, sample_rate_hz, block_size, hop_size, window_type)

[time_vector,x_blk] = generateBlocks(x,sample_rate_hz,block_size,hop_size);
n_blocks = length(time_vector); % Identified the Number of Sample Blocks
num_FFT_pts = block_size/2+1; % Calculated FFT points
freq_vector = zeros(num_FFT_pts,1); % Initialized Return Frequency Column Vector
magnitude_spectrogram = zeros(num_FFT_pts,n_blocks); % Initialize Magnitude Spectrogram Matrix

for i = 1:n_blocks % Function Call for Frequency Bins and Xabs Magnitude

    %%!
    if window_type == "hann" % Hanning Windowed FFT
        win = hann(block_size);
    elseif window_type == "rect" % Rectangle Windowed FFT
        win = ones(block_size, 1);
    else
        error("Wrong window type: only hann or rect");
    end
    [freq_vector, magnitude_spectrogram(:, i), ~, ~, ~] = computeSpectrum(win .* x_blk(:,i),sample_rate_hz); 
    %%!

    %[freq_vector, Xabs, Xphase, Xre, Xim] = computeSpectrum(x_blk(:,i),sample_rate_hz); 
    % Windowing
    %%! KW: window must be applied before computing spectrum
    %{
    if window_type == "hann" % Hanning Windowed FFT
        magnitude_spectrogram(:,i) = hann(length(Xabs)).*Xabs;
    elseif window_type == "rect" % Rectangle Windowed FFT
        magnitude_spectrogram(:,i) = Xabs; % Rectangle Window is Default for fft
    else
        error("Wrong window type: only hann or rect");
    end
    %}
end
%%!
im = image(time_vector, freq_vector,magnitude_spectrogram);
%%!
% im = image(magnitude_spectrogram); % Frequency Y Axis from bottom to top
ax = im.Parent;
ax.YDir = 'normal';
xlabel('Time (seconds)'); ylabel('Frequency (Hz)');
% Function should also plot the magnitude spectrogram time(seconds) and frequency(Hz)

end