%% Problem 1
% 9 seconds, sample rate 48 kHz, stereo type

% Import
[y, Fs] = audioread('Project.m4a'); % Fs = 48000
y_mono = y(:, 1); % take one of the two channel

N = length(y_mono);
t = (0:N-1)/Fs;
normalized_y_mono = normalize(y_mono, "range", [-1, 1]);
% play audio
% sound(y_mono, 48000)

% Plot
% figure;
% plot(t, normalized_y_mono);
% xlabel('Time(s)');
% ylabel('Amplitude (Normalized)');
% title('Problem 1: Time Domain Signal of My Sound');
% xlim([0, t(end)]);
% grid on;

Fs;

%% Problem 2 
% factors = [2, 4, 8]; % define some sampling factors
% 
% figure;
% subplot(length(factors) + 1, 1, 1)
% plot(t, y_mono);
% title('Original 48 kHz result');
% xlim([0.9, 0.92]);
% xlabel('Time(s)'); ylabel('Amplitude');
% 
% for k = 1:length(factors)
%     r = factors(k);
%     y_ds = decimate(y_mono, r); % change sample rate
%     t_ds = (0:length(y_ds)-1)/(Fs/r);
%     subplot(length(factors) + 1, 1, k+1)
%     plot(t_ds, y_ds);
%     title(sprintf('Down Sample 1/%d, Sample rate = %.0f Hz', r, Fs/r));
%     xlim([0.9, 0.92]);
%     xlabel('Time(s)'); ylabel('Amplitude');
% end


%% Problem 3
% bits = [16, 8, 4]; % define test quantized bit number
% 
% figure;
% for k = 1:length(bits)
%     b = bits(k)
%     % quantize to b bits
%     y_q = round(y_mono * (2^(b-1)-1))/(2^(b-1)-1);
%     subplot(length(bits), 1, k)
%     plot(t, y_q);
%     title(sprintf('%d-bit Quantization Waveform', b));
%     xlabel('Time(s)'); ylabel('Amplitude');
% end

%% Problem 4
Y = fft(y_mono);
N_f = length(Y);
f = (0:N_f-1)*(Fs/N_f);
mag = abs(Y)/N_f; % amplitude normalization
idx_all = 1:N_f;
idx_ny = 1:floor(N_f/2); % Nyquist (Fs/2)
% 
% figure;
% subplot(2,1,1)
% plot(f(idx_all),mag(idx_all));
% xlabel('Frequency (Hz)');
% ylabel('Amplitude');
% title('Problem 4: Frequency Domain (FFT 0 ~ 48000 Hz) ');
% xlim([0, Fs])
% grid on;
% subplot(2,1,2)
% plot(f(idx_ny), mag(idx_ny));
% xlabel('Frequency (Hz)');
% ylabel('Amplitude');
% title('Problem 4: Frequency Domain (FFT 0 ~ 24000 Hz)');
% xlim([0, Fs/2])
% grid on;

%% Problem 5
% % zero padding in time domain
% y_zp = [y_mono ; zeros(N,1)];
% 
% Y_zp = fft(y_zp);
% N_2 = length(Y_zp);
% f_zp = (0:N_2-1)*(Fs/N_2);
% mag_zp = abs(Y_zp)/N;
% 
% figure;
% subplot(4,1,1)
% plot(f(1:floor(N_f/2)), mag(1:floor(N_f/2)));
% title('Original Frequncy Domain Result');
% xlabel('Frequency (Hz)'); ylabel('Amplitude');
% subplot(4,1,2)
% plot(f_zp(1:floor(N_2/2)), mag_zp(1:floor(N_2/2)));
% title('Zero Padding Frequncy Domain Result (2N)');
% xlabel('Frequency (Hz)'); ylabel('Amplitude');
% subplot(4,1,3)
% plot(f(1:floor(N_f/2)), mag(1:floor(N_f/2)));
% title('Original Frequncy Domain Result (175-200 Hz)');
% xlim([175,200]);xlabel('Frequency (Hz)'); ylabel('Amplitude');
% subplot(4,1,4)
% plot(f_zp(1:floor(N_2/2)), mag_zp(1:floor(N_2/2)));
% title('Zero Padding Frequncy Domain Result (2N) (175-200 Hz)');
% xlim([175,200]);xlabel('Frequency (Hz)'); ylabel('Amplitude');

%% Problem 6
% % Short Time Fourier Transform 
% % Compare 2 window and 2 overlap ratio
% win_len = 1024; % 1024 samples
% n_fft = 1024; % FFT points numebr
% windows = {@hamming, @hann}; % hamming, hann window
% overlaps = [0.5, 0.75]; % 50%, 75%
% 
% figure;
% plotIdx = 1;
% for wi = 1:length(windows)
%     wfunc = windows{wi};       
%     wname = func2str(wfunc); 
%     win = wfunc(win_len);   
% 
%     for oi = 1:length(overlaps)
%         R = overlaps(oi);
%         n_overlap = floor(win_len * R);
% 
%         subplot(length(windows), length(overlaps), plotIdx);
%         spectrogram( ...
%             y_mono, ...           % time domain signal
%             win, ...         % window function
%             n_overlap, ...    % overlap sample number
%             n_fft, ...       
%             Fs, ...          % sample rate
%             'yaxis');        % frequency (kHz)
%         title(sprintf('%s window, overlap %.0f%%', wname, R*100));
%         plotIdx = plotIdx + 1;
%     end
% end
% colormap jet;   
% colorbar; 

%% Problem 7
% % Butterworth Filter，Cutoff Frequency: 6 kHz
% idx = 1:floor(N/2);
% fc = 6000;              
% order = 6;
% Wn = fc/(Fs/2); % cutoff frequency * 2 / sample frequency
% [b,a] = butter(order, Wn, 'low'); % low pass
% y_filt = filtfilt(b, a, y_mono); % filter forward and reverse
% 
% figure;
% impz(b, a, 100, Fs); % first 100 samples of the impulse response
% title('Filter Impulse Response');
% 
% figure;
% freqz(b, a, 1024, Fs);
% title('Filter Transfer Function');
% % time domain (compare the first 0.02 seconds)
% figure;
% subplot(2,1,1)
% plot(t(1:round(0.02 * Fs)), y_mono(1:round(0.02 * Fs)));
% title('Time Domain before filtering');
% xlabel('s'); ylabel('Amplitude');
% subplot(2,1,2)
% plot(t(1:round(0.02 * Fs)), y_filt(1:round(0.02 * Fs)));
% title('Time Domain after filtering');
% xlabel('s'); ylabel('Amplitude');
% % frequency domain
% Yf = fft(y_filt);
% mag_filt = abs(Yf)/N;
% figure;
% plot(f(idx), mag(idx), 'b', f(idx), mag_filt(idx), 'r');
% legend('Original','After Filtering');
% xlabel('Hz'); ylabel('Amplitude');
% title('Frequency Domain Comparison');
% xlim([0, 10000]);
% grid on;
% 
% % Play the sound afterward
% sound(y_filt, Fs);

%% Problem 8
% change the pitch of the recording

% original
% p = 5; q = 5; % resampling factors, 5/5 = 1
% y_pitch = resample(y_mono, p, q);
% sound(y_pitch, Fs);

% become high pitch
% p = 4; q = 5;  % resampling factors, 4/5 = 0.8
% y_pitch = resample(y_mono, p, q);
% sound(y_pitch, Fs);

% become low pitch
% p = 5; q = 4; % resampling factors, 5/4 = 1.25
% y_pitch = resample(y_mono, p, q);
% sound(y_pitch, Fs);
