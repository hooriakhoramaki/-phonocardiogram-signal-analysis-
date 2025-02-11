function [signal_filtered_butterWorth,signal_filtered_ellip,signal_filtered_Savitzky_Golay,signal_filtered_wiener] = signalFiltering (signal_minmax  )

  % مشخصات فیلتر Band-Pass
fs = 1000; % نرخ نمونه‌برداری سیگنال (تطبیق با داده شما)
low_cutoff = 25; % حد پایین فرکانس (هرتز)
high_cutoff = 450; % حد بالای فرکانس (هرتز)
filter_order = 4; % مرتبه فیلتر

% طراحی فیلتر Butterworth Band-Pass
[b, a] = butter(filter_order, [low_cutoff, high_cutoff] / (fs / 2), 'bandpass');
signal_filtered_butterWorth = filtfilt(b, a, signal_minmax);

% طراحی فیلتر Elliptic Band-Pass
[b_ellip, a_ellip] = ellip(filter_order, 1, 40, [low_cutoff, high_cutoff] / (fs / 2), 'bandpass');
signal_filtered_ellip = filtfilt(b_ellip, a_ellip, signal_minmax);

% اعمال فیلتر Savitzky–Golay برای صاف کردن سیگنال
frame_length = 21; % طول فریم
poly_order = 2; % مرتبه چندجمله‌ای
signal_filtered_Savitzky_Golay = sgolayfilt(signal_minmax, poly_order, frame_length);

% اعمال فیلتر Adaptive Wiener
%signal_wiener = wiener2(signal_standardized, [5 5]);
signal_filtered_wiener = wiener2(signal_minmax, [5 5]);

end