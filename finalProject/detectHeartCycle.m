function [heart_cycles, S1_positions, S2_positions] = detectHeartCycle(signal, fs)
    % سیگنال ورودی: signal
    % نرخ نمونه‌برداری: fs
    % خروجی: heart_cycles - لیست چرخه‌های قلبی (S1 تا S1 بعدی)
    %         S1_positions - موقعیت‌های S1
    %         S2_positions - موقعیت‌های S2

    % اعمال تبدیل موجک پیوسته (CWT)
    [cfs, freq] = cwt(signal, 'amor', fs);

    % انتخاب محدوده فرکانسی مهم (25Hz - 450Hz) برای شناسایی S1 و S2
    freq_range = (freq >= 25 & freq <= 450);
    cfs_energy = sum(abs(cfs(freq_range, :)), 1);

    % پیدا کردن نقاط اوج که احتمالاً S1 و S2 هستند
    [pks, locs] = findpeaks(cfs_energy, 'MinPeakDistance', fs * 0.3, 'Threshold', 0.1);

    % نمایش نقاط اوج شناسایی شده
    % figure;
    % plot(cfs_energy);
    % hold on;
    % scatter(locs, cfs_energy(locs), 'r', 'filled');
    % title('نقاط اوج شناسایی شده');
    % xlabel('زمان (نمونه‌ها)');
    % ylabel('انرژی موجک');
    % hold off;

    % جداسازی S1 و S2
    [S1_positions, S2_positions] = separate_S1_S2(locs, signal);

    % محاسبه چرخه‌های قلبی (از S1 تا S1 بعدی)
    heart_cycles = extract_heart_cycles(signal, S1_positions, fs);
end

% تابع جداکننده S1 و S2 بر اساس دامنه و موقعیت‌های زمانی
function [S1_positions, S2_positions] = separate_S1_S2(locs, signal)
    % فرض: S1 دارای دامنه بیشتر و S2 بین دو S1 قرار می‌گیرد
    S1_positions = locs(1:2:end); % انتخاب S1 (هر دو نقطه یکی)
    S2_positions = locs(2:2:end); % انتخاب S2 (بین دو S1)
end

% تابع تقسیم‌بندی چرخه‌های قلبی
function heart_cycles = extract_heart_cycles(signal, S1_positions, fs)
    heart_cycles = {};
    for i = 1:length(S1_positions)-1
        cycle = signal(S1_positions(i):S1_positions(i+1));
        heart_cycles{i} = cycle;
    end
end
