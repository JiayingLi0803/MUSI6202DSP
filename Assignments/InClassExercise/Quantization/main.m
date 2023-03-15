% y = audioread('piano.wav'); % read audio sample
% y200 = y(1:200); % take the first 200 points in y for normalization
t = 0:1/(6000):1;
y = sin(2*pi*60*t);
y200 = y(1:200);

% plot uniform quantization with different word length
figure('Name', 'Mid-tread Quantization')
subplot(2,2,1); plot(y200, 'b'); hold on % plot the origin signal
plot(quantizeAudio(y200, 2), 'r'); hold off % quantize with 2 bits
legend('origin', '2-bit');
title('Uniform Quantization with 2-bit');
subplot(2,2,2); plot(y200, 'b'); hold on
plot(quantizeAudio(y200, 4), 'r'); hold off % quantize with 4 bits
legend('origin', '4-bit');
title('Uniform Quantization with 4-bit'); 
subplot(2,2,3); plot(y200, 'b'); hold on
plot(quantizeAudio(y200, 6), 'r'); hold off % quantize with 8 bitw
legend('origin', '6-bit');
title('Uniform Quantization with 6-bit'); 
subplot(2,2,4); plot(y200, 'b'); hold on
plot(quantizeAudio(y200, 8), 'r'); hold off % quantize with 16 bits
legend('origin', '8-bit');
title('Uniform Quantization with 8-bit');

% plot nonuniform quantization with different word length: mu law
figure('Name', 'mu-law Quantization')
subplot(2,2,1); plot(y200, 'b'); hold on % plot the origin signal
plot(nonLinearQuantAudio(y200, 2, 'mu-law'), 'r'); hold off % quantize with 2 bits
legend('origin', '2-bit');
title('mu-law Quantization with 2-bit');
subplot(2,2,2); plot(y200, 'b'); hold on
plot(nonLinearQuantAudio(y200, 4, 'mu-law'), 'r'); hold off % quantize with 4 bits
legend('origin', '4-bit');
title('mu-law Quantization with 4-bit'); 
subplot(2,2,3); plot(y200, 'b'); hold on
plot(nonLinearQuantAudio(y200, 6, 'mu-law'), 'r'); hold off % quantize with 8 bitw
legend('origin', '6-bit');
title('mu-law Quantization with 6-bit'); 
subplot(2,2,4); plot(y200, 'b'); hold on
plot(nonLinearQuantAudio(y200, 8, 'mu-law'), 'r'); hold off % quantize with 16 bits
legend('origin', '8-bit');
title('mu-law Quantization with 8-bit');

% plot nonuniform quantization with different word length: A law
figure('Name', 'A-law Quantization')
subplot(2,2,1); plot(y200, 'b'); hold on % plot the origin signal
plot(nonLinearQuantAudio(y200, 2, 'A-law'), 'r'); hold off % quantize with 2 bits
legend('origin', '2-bit');
title('A-law Quantization with 2-bit');
subplot(2,2,2); plot(y200, 'b'); hold on
plot(nonLinearQuantAudio(y200, 4, 'A-law'), 'r'); hold off % quantize with 4 bits
legend('origin', '4-bit');
title('A-law Quantization with 4-bit'); 
subplot(2,2,3); plot(y200, 'b'); hold on
plot(nonLinearQuantAudio(y200, 6, 'A-law'), 'r'); hold off % quantize with 8 bitw
legend('origin', '6-bit');
title('A-law Quantization with 6-bit'); 
subplot(2,2,4); plot(y200, 'b'); hold on
plot(nonLinearQuantAudio(y200, 8, 'A-law'), 'r'); hold off % quantize with 16 bits
legend('origin', '8-bit');
title('A-law Quantization with 8-bit');