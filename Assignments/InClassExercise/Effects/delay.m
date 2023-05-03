%%%%%%%%%%% delay effect %%%%%%%%%%%


% In this example, we applied a delay effect to a piano audio signal. 
% The effect creates an echo by playing the original sound again after a 
% specified time delay.


[originalSignal, fs] = audioread('piano.wav');

delayTime = 0.5; % in seconds
feedback = 0.5;

delayLength = round(delayTime * fs);
delayBuffer = zeros(delayLength, 1);
outputSignal = zeros(size(originalSignal));

for n = 1:length(originalSignal)
    % Read the current input sample
    inputSample = originalSignal(n);
    
    % Read the delayed sample from the buffer
    delayedSample = delayBuffer(mod(n, delayLength) + 1);
    
    % Mix the input and delayed samples and write to the output signal
    outputSignal(n) = inputSample + feedback * delayedSample;
    
    % Write the current input sample to the delay buffer
    delayBuffer(mod(n, delayLength) + 1) = inputSample + feedback * delayedSample;
end

sound(originalSignal, fs);
% Pause for the duration of the original signal plus 1 second
pause(length(originalSignal) / fs + 1); 
sound(outputSignal, fs);
% audiowrite('piano_delay.wav', outputSignal, fs);
