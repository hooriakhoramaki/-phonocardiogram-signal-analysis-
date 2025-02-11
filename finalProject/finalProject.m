clc;
clear;
close all;

[data_folder , num_files , file_list ] = importData();


target_fs = 1000; 
target_duration = 5;
results = struct('file_name', {}, 'features', {},'health',{}); 
%signals_spectral_enegy_flux=struct('num_signal',[],'specteral_energy_flux',{});
normal_Anormal_list = struct('normal',{},'Anormal',{});
%%% preprocess

for i = 1:num_files


   [ signal , fs ]               =   readData(data_folder,file_list,i);

    signal_resampled              =   resampelingSignal (signal , target_fs , fs);

    signal_standardized           =   standardizedDurationSignal(target_duration,target_fs,signal_resampled);

   [ signal_minmax , signal_zscore ]  =   normalizedAmplitude(signal_standardized);
   
   [signal_filtered_butterWorth,signal_filtered_ellip,signal_filtered_Savitzky_Golay,signal_filtered_wiener]  = signalFiltering(signal_minmax);

   %%% another way
 % [detection_function,signals_spectral_enegy_flux] = Spectrum_energy_flux(signal_filtered_butterWorth ,fs,signals_spectral_enegy_flux,i);
 % 
 %  optimized_positions = geneticAlgoritm(detection_function, fs);


   
    signal_denoised_wavelet =signalDenoising(signal_filtered_butterWorth);

    [results,normal_Anormal_list] = signalSegmentation(results, signal_denoised_wavelet, file_list, i,normal_Anormal_list);
 
    [pks, locs] = findpeaks(signal_filtered_butterWorth, 'MinPeakHeight', 0.1, 'MinPeakDistance', 0.3*fs);
   [pks2, locs2] = findpeaks(signal_denoised_wavelet, 'MinPeakHeight', 0.1, 'MinPeakDistance', 0.3*fs);
    



end


%%%% heart sound segmentation

[cluster_feature,numClusters , idx,all_features_splited,cluster_feature_normal,cluster_feature_Anormal] = k_meansClustring(results,num_files, normal_Anormal_list);



%%% heart sound feature extraction  (time and frequence)

[ cluster_features_time ,cluster_feature_normal_time,cluster_feature_Anormal_time] = timesDomainFeatureExtraction(cluster_feature,numClusters,cluster_feature_normal,cluster_feature_Anormal);

[cluster_features_frequence ,cluster_feature_normal_frequence,cluster_feature_Anormal_frequence]=frequencyDomainFeatureExtraction(cluster_feature,numClusters,cluster_feature_normal,cluster_feature_Anormal);

[cluster_features_Time_frequence ,cluster_feature_normal_Time_frequence,cluster_feature_Anormal_Time_frequence] = Time_FrequencyDomainFeatureExtraction(cluster_feature,numClusters,cluster_feature_normal,cluster_feature_Anormal);


%%%%%%%%%%%%%%%%%%%%%%% select best features with svm 

 [Input_normal_S1,Input_normal_S2,Input_normal_systol,Input_normal_diastol,Input_Anormal_S1,Input_Anormal_S2,Input_Anormal_systol,Input_Anormal_diastol]=AllFeaturesinMatrix(cluster_feature_normal_time,cluster_feature_normal_frequence,cluster_feature_normal_Time_frequence, cluster_feature_Anormal_time,cluster_feature_Anormal_frequence,cluster_feature_Anormal_Time_frequence);

%[best_featuresinCluster_S1,best_featuresinCluster_S2,best_featuresinCluster_systol,best_featuresinCluster_diastol] =  selectBestfeatureWithSvm(Input_normal_S1,Input_normal_S2,Input_normal_systol,Input_normal_diastol,Input_Anormal_S1,Input_Anormal_S2,Input_Anormal_systol,Input_Anormal_diastol,num_label_normal_s1,num_label_normal_s2,num_label_normal_systol,num_label_normal_diastol,num_label_Anormal_s1,num_label_Anormal_s2,num_label_Anormal_systol,num_label_Anormal_diastol);

 [S1_ranked_feature,Top_feature_s1,S2_ranked_feature,Top_feature_s2,systol_ranked_feature,Top_feature_systol,diastol_ranked_feature,Top_feature_diastol] =  select_Best_Features_with_SVM_rfe(Input_normal_S1,Input_normal_S2,Input_normal_systol,Input_normal_diastol,Input_Anormal_S1,Input_Anormal_S2,Input_Anormal_systol,Input_Anormal_diastol);
%%%%%%%%%%%%%%%%%%%%%%%%%%%% reduce Dimensions


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% nerual network for diagnostic
 
% SimpleNuraulnetwork(Top_feature_s1,Top_feature_s2,Top_feature_systol,Top_feature_diastol);

%NuraulNetworkForStateRecognition( Top_feature_s1,Top_feature_s2,Top_feature_systol,Top_feature_diastol);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% plot signals
% 
t_filtered = (0:length(signal_filtered_butterWorth)-1)/target_fs;  % زمان برای سیگنال فیلتر‌شده
t_denoised = (0:length(signal_denoised_wavelet)-1)/target_fs;  

figure;
plot(t_filtered, signal_filtered_butterWorth);  % رسم سیگنال فیلتر‌شده
hold on;
plot(t_filtered(locs), pks, 'ro');  % علامت‌گذاری پیک‌ها
xlabel('Time (s)');
ylabel('Amplitude');
title('PCG Signal with Detected Peaks (Butterworth Filtered)');
legend('Filtered Signal', 'Peaks');
grid on;

figure;
plot(t_denoised, signal_denoised_wavelet);  % رسم سیگنال دنویز شده
hold on;
plot(t_denoised(locs2), pks2, 'ro');  % علامت‌گذاری پیک‌ها
xlabel('Time (s)');
ylabel('Amplitude');
title('PCG Signal with Detected Peaks (Wavelet Denoised)');
legend('Denoised Signal', 'Peaks');
grid on;
 showingSignals(signal, signal_resampled,signal_minmax,signal_zscore,signal_filtered_butterWorth,signal_filtered_ellip,signal_filtered_Savitzky_Golay,signal_filtered_wiener,signal_denoised_wavelet);
