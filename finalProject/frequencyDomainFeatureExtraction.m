function [cluster_features_frequence ,cluster_feature_normal_frequence,cluster_feature_Anormal_frequence]=frequencyDomainFeatureExtraction(cluster_feature,numClusters,cluster_feature_normal,cluster_feature_Anormal)

numFeaturs = 4;



for i=1:numFeaturs

  DFT_featurs = cell(size(cluster_feature{i}, 1), 1);
  DFT_featurs_normal = cell(size(cluster_feature_normal{i}, 1), 1);
  DFT_featurs_Anormal = cell(size(cluster_feature_Anormal{i}, 1), 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ALL DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j=1 : size(cluster_feature{i},1)
        signal = cluster_feature{i}(j , : );
        N = length(signal);

        dft_Value = fft(signal);

        magnitude = abs(dft_Value(1:N)); %amplitude
        powers= magnitude.^2;
        frequency_centroid = sum((1:N) .* powers) / sum(powers);
        bandwidth = sqrt(sum(((1:N) - frequency_centroid).^2 .* powers) / sum(powers)); 

%       DFT_featurs(j, :) = [magnitudes, powers, frequency_centroid, bandwidth];
        DFT_featurs{j} = [magnitude, powers, frequency_centroid, bandwidth];

    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% normal DATA %%%%%%%%%%%%%%%%%%%%%%%%
    for j=1 : size(cluster_feature_normal{i},1)
        signal = cluster_feature_normal{i}(j , : );
        N = length(signal);

        
        dft_Value_normal = fft(signal);

         magnitude_normal = abs(dft_Value_normal(1:N)); %amplitude
         powers_normal= magnitude_normal.^2;
         frequency_centroid_normal = sum((1:N) .* powers_normal) / sum(powers_normal);
         bandwidth_normal = sqrt(sum(((1:N) - frequency_centroid_normal).^2 .* powers_normal) / sum(powers_normal)); 
         
         DFT_featurs_normal{j} =[magnitude_normal , powers_normal, frequency_centroid_normal, bandwidth_normal];


    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Anoramal DATA %%%%%%%%%%%%%%%%%%%%
    for j=1 : size(cluster_feature_Anormal{i},1)
        signal = cluster_feature_Anormal{i}(j , : );
        N = length(signal);

        dft_Value_Anormal = fft(signal);

        magnitude_Anormal = abs(dft_Value_Anormal(1:N)); %amplitude
        powers_Anormal= magnitude_Anormal.^2;
        frequency_centroid_Anormal = sum((1:N) .* powers_Anormal) / sum(powers_Anormal);
        bandwidth_Anormal = sqrt(sum(((1:N) - frequency_centroid_Anormal).^2 .* powers_Anormal) / sum(powers_Anormal)); 

        DFT_featurs_Anormal{j} = [magnitude_Anormal, powers_Anormal, frequency_centroid_Anormal, bandwidth_Anormal];

    end

cluster_features_frequence{i} = DFT_featurs;
cluster_feature_normal_frequence{i} = DFT_featurs_normal;
cluster_feature_Anormal_frequence{i} = DFT_featurs_Anormal;

end




end