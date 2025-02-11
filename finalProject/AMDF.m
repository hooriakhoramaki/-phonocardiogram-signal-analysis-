function amdf_value = AMDF(signal)

    % محاسبه تابع AMDF برای یک سیگنال
    N = length(signal);  % طول سیگنال
    tau_max = N - 1;  % حداکثر تأخیر (تا انتهای سیگنال)

    amdf_value = zeros(tau_max, 1);  % برای ذخیره مقادیر AMDF در تأخیرهای مختلف

    for tau = 1:tau_max
        amdf_value(tau) = sum(abs(signal(1:N - tau) - signal(tau+1:N))) / (N - tau);
    end

    % میانگین مقادیر AMDF برای استخراج یک ویژگی تک‌عددی
    amdf_value = mean(amdf_value);  % یا می‌توانید از تابع min یا max استفاده کنید
end