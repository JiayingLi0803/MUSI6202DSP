function xhat = denoise1(y, fs, noiseLengthSec, nfft, noverlap)
    if nargin < 3
        noiseLengthSec = 3.0;
    end

    if nargin < 4
        nfft = 4096;
    end

    if nargin < 5
        noverlap = nfft/2;
    end

    noiseLengthSampl = floor(noiseLengthSec * fs);
    y = y(:); 
    noise_profile = y(1:noiseLengthSampl);
    xhat = wienerFilter(y, noise_profile, nfft, noverlap, fs);
end