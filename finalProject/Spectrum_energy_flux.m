function [detection_function,signals_spectral_enegy_flux] = Spectrum_energy_flux(signal,fs,signals_spectral_enegy_flux,i)

 window_length = 256;
    overlap = 128;
    [S, f, t] = stft(signal, fs, 'Window', hamming(window_length), 'OverlapLength', overlap, 'FFTLength', window_length);
    Zxx = abs(S);
    freq_indices = find(f >= 25 & f <= 450);
    Zxx = Zxx(freq_indices, :);
    spectral_flux = diff(Zxx, 1, 2);
    detection_function = sum(spectral_flux, 1);
    detection_function = max(detection_function, 0);
    detection_function = smoothdata(detection_function, 'gaussian', 5);

   signals_spectral_enegy_flux.num_signal(i) = i;  % ذخیره شماره سیگنال
    signals_spectral_enegy_flux.specteral_energy_flux{i} = detection_function; % ذخیره شار طیف انرژی
    
    waterfall(f,t,abs(S(:,:,1))')
     helperGraphicsOpt(1)
end

function helperGraphicsOpt(ChannelId)
ax = gca;
ax.XDir = 'reverse';
ax.ZLim = [0 30];
ax.Title.String = ['Input Channel: ' num2str(ChannelId)];
ax.XLabel.String = 'Frequency (Hz)';
ax.YLabel.String = 'Time (seconds)';
ax.View = [30 45];
end

