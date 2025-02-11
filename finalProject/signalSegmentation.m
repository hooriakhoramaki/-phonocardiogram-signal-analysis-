function [results,normal_Anormal_list] =  signalSegmentation(results,signal_denoised_wavelet ,file_list,i,normal_Anormal_list)



signal_for_segmentation = signal_denoised_wavelet;



window_size = 100; 
num_windows = floor(length(signal_for_segmentation) / window_size);


features = [];
for w = 1:num_windows
    start_idx = (w-1)*window_size + 1;
    end_idx = w*window_size;
    window = signal_for_segmentation(start_idx:end_idx);


    energy = sum(window.^2);
    mean_val = mean(window);
    std_val = std(window);

  
    features = [features; energy, mean_val, std_val];
end


    results(i).file_name = file_list(i);
    

    if isfield(results(i), 'features')
        results(i).features = [results(i).features; features];
    else
        results(i).features = features;
    end
    [results,normal_Anormal_list] = splitNormal_AnormalSound( results, i ,normal_Anormal_list) ;
end