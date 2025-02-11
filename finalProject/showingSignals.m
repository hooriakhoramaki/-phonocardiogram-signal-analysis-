function showingSignals(signal,resampleSignal,signal_minmax,signal_zscore,signal_filtered_butterWorth,signal_filtered_ellip,signal_filtered_Savitzky_Golay,signal_filtered_wiener,signal_denoised_wavelet)



% نمایش سیگنال‌ها
figure('Position', [100, 100, 800, 1200]);  % افزایش اندازه پنجره

subplot(10, 1, 1);
plot(signal);
title('سیگنال اصلی استاندارد شده');

subplot(10, 1, 2);
plot(resampleSignal);
title('resample signal');

subplot(10, 1, 3);
plot(signal_minmax);
title('signal_minmax');

subplot(10, 1, 4);
plot(signal_zscore);
title('signal_zscore');

subplot(10, 1, 5);
plot(signal_filtered_butterWorth);
title('فیلتر شده با Butterworth');

subplot(10, 1, 6);
plot(signal_filtered_ellip);
title('فیلتر شده با Elliptic');

subplot(10, 1, 7);
plot(signal_filtered_Savitzky_Golay);
title('صاف شده با Savitzky–Golay');

subplot(10, 1, 8);
plot(signal_filtered_wiener);
title('فیلتر شده با Adaptive Wiener');

subplot(10, 1, 9);
plot(signal_denoised_wavelet);
title('signal-denoised-wavelet');

% subplot(10, 1, 10);
% plot(detectionPeaks);
% title('STFT');





end
