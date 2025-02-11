function [signal_minmax,signal_zscore] = normalizedAmplitude(signal_standardized)

  %نرمالسازی دامنه با min max
    signal_minmax = (signal_standardized - min(signal_standardized)) /(max(signal_standardized) - min(signal_standardized));

    % نرمالسازی دامنه باZ-score
    signal_zscore = (signal_standardized - mean(signal_standardized)/std(signal_standardized));
end