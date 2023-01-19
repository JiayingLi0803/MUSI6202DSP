[x,fsx] = audioread("drum_loop.wav"); % read wav files
[y,fsy] = audioread("snare.wav");

xx = x(:,1); % take one channel of x and y
yy = y(:,1);

[rxy,lagindex] = myCrossCorr(xx,yy); % calculate cross correlation

figure("Name","Cross Correlation Impletmentation"); % plot figures
subplot(3,1,1), plot(0:1/fsx:length(xx)/fsx-1/fsx,xx);
title("drum_loop.wav Waveform")
subplot(3,1,2), plot(0:1/fsy:length(yy)/fsy-1/fsy, yy);
title("snare.wav Waveform")
subplot(3,1,3), plot(lagindex./fsx,rxy);
ylabel("Amplitude"); grid on
title("Cross Correlation")

% From the plot, we can find there are 4 peaks (maxima) for snares.
start = lagindex(length(xx)+1)/fsy; % start time of the drum loop
[val,idx] = sort(rxy, 'descend'); % sort rxy value 
firstidx = min(idx(1:4))/fsy; % find the smallest index
firstloc = firstidx - start; % location of the first snare in samples