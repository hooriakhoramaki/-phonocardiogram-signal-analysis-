function [signal_denoised_wavelet ] = signalDenoising(signal_filtered)

  %% دنوایزینگ سیگنال

    % 1. Denoising با Wavelet Transform (WT)
    [C, L] = wavedec(signal_filtered, 5, 'db4');
    thr = 0.5 * max(abs(C)); % تعیین آستانه
    C_denoised = wthresh(C, 's', thr); % آستانه‌گذاری نرم (Soft Thresholding)
    signal_denoised_wavelet = waverec(C_denoised, L, 'db4'); % بازسازی سیگنال

    % 2. Schmidt Spike Removal
    % window_size = 100; % اندازه پنجره
    % num_windows = floor(length(signal_standardized) / window_size);
    % for j = 1:num_windows
    %     window = signal_standardized((j-1)*window_size + 1 : j*window_size);
    %     median_val = median(window);
    %     max_val = max(abs(window));
    %     if max_val > 3 * median_val
    %         % حذف اسپایک با جایگزینی با صفر
    %         signal_standardized((j-1)*window_size + 1 : j*window_size) = 0;
    %     end
    % end
end