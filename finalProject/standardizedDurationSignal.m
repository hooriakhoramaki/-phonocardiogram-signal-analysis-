function signal_standardized = standardizedDurationSignal(target_duration,target_fs,signal_resampled)

 % استانداردسازی مدت‌زمان
    target_length = target_duration * target_fs; % تعداد نمونه‌های هدف

%برای نرمال سازی این سیگنال ها 5 ثانیه در نظر گرفته شده وهمه ذز فزکانس 1000
%هرتز
    
    current_length = length(signal_resampled);
    if current_length < target_length
       
        signal_standardized = [signal_resampled; zeros(target_length - current_length, 1)];
    else
       
        signal_standardized = signal_resampled(1:target_length);
    end
end