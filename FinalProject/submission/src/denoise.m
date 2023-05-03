%%%%%%%%%%%%% Time Vary Wiener Denoising %%%%%%%%%%%%%
%%%%%%%%%%%%%        Parameters          %%%%%%%%%%%%%
%   seg     wlen   hop    ratio     median   
% 131072    32768   16384   2       3.24
% Input SNR (dB)
%   min    	median 	mean   	max    	std    
% -11.90	1.54	0.43	10.92	6.71
% Output SNR (dB)
% min    	median 	mean   	max    	std    
% -11.79	3.24	2.70	11.50	4.89
% Change in SNR (dB)
% min    	median 	mean   	max    	std    
% -4.87	    1.68	2.27	11.27	3.01

function xhat = denoise(y, fs, noiseLengthSec, nfft, noverlap)
% y:                noisy signal
% fs:               sampling rate
% noiseLengthSec:   default = 3;
% nfft:             default = 4096
% noverlap:         default = nfft/2
% xhat:             output clean signal

% Set default values for optional input arguments
    if nargin < 3
        noiseLengthSec = 3.0;
    end
    if nargin < 4
        nfft = 4096;
    end
    if nargin < 5
        noverlap = nfft/2;
    end

    % Set parameters for ZCR calculation
    seg = 131072;
    wlen=32768; 
    hop=16384;   
    ratio = 2;
    
    % Initialize variables
    x_ori = y;
    l_ori = length(x_ori);
    xhat = zeros(l_ori,1);
    n=fix(l_ori/seg);

    % Process each segment
    for ind=0:n-1
        x=x_ori(1+ind*seg:ind*seg+seg); % Extract current segment
        % Calculate ZCR for each frame in the segment 
        win=hanning(wlen);                     
        X=enframe(x,win,hop)';     
        fn=size(X,2);               
        zcr1=zeros(1,fn);                
        for i=1:fn
            z=X(:,i);                    
            for j=1: (wlen- 1)       
                 if z(j)* z(j+1)< 0       
                     zcr1(i)=zcr1(i)+1;  
                 end
            end
        end
        % Find maximum ZCR and estimate noise profile
        zcr1_0=zcr1(1:2:end); 
        zcr1_1=zcr1(2:2:end);        
        l = fix(fn/(ratio*2));
        zccalc0 = zeros(1,l); 
        zccalc1 = zeros(1,l); 
        for i=1:l
            for j=1:ratio
                zccalc0(i)=zccalc0(i)+zcr1_0(ratio*(i-1)+j);
                zccalc1(i)=zccalc1(i)+zcr1_1(ratio*(i-1)+j);
            end
        end
        % Determine starting point for the noise profile
        m0 = max(zccalc0); 
        m1 = max(zccalc1);
        if m0>m1
            for k=1:l
                if zccalc0(k)==m0
                    index = k;
                end
            end
            t= wlen*ratio*(index-1)+1;
        else
            for k=1:l
                if zccalc1(k)==m1
                    index = k;
                end
            end
            t= hop+ wlen*ratio*(index-1)+1;
        end
        y = y(:); 
        % Estimate noise profile and apply Wiener filter to the segment
        noise_profile = y(t:t+wlen*ratio); 
        xhat_out = wienerFilter(x, noise_profile, nfft, noverlap, fs);
        % Store the denoised segment
        xhat(1+ind*seg:ind*seg+seg) = xhat_out; 
    end
    % Process remaining samples after the last complete segment
    remain = x_ori(1+n*seg:end);
    noiseLengthSampl = floor(noiseLengthSec * fs);
    noise_profile_ori = y(1:noiseLengthSampl);
    xhat_out = wienerFilter(remain, noise_profile_ori, nfft, noverlap, fs);
    xhat(1+n*seg:end) = xhat_out;
end