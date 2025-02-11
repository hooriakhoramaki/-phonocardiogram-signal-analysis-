function [cluster_features_Time_frequence ,cluster_feature_normal_Time_frequence,cluster_feature_Anormal_Time_frequence] = Time_FrequencyDomainFeatureExtraction(cluster_feature,numClusters,cluster_feature_normal,cluster_feature_Anormal)
 
  
 for i=1:numClusters

  time_frequency_featurs = cell(size(cluster_feature{i}, 1), 1);
  time_frequency_featurs_normal = cell(size(cluster_feature_normal{i}, 1), 1);
  time_frequency_featurs_Anormal = cell(size(cluster_feature_Anormal{i}, 1), 1);


  numSignals = size(cluster_feature{i},1);
  numSignalsnormal = size(cluster_feature_normal{i},1);
  numSignalsAnormal = size(cluster_feature_Anormal{i},1);
  
   level = 4;
   waveletName ='db4';

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ALL DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  for j=1:numSignals
      signal = cluster_feature{i}(j,:);

     

      [wt , d] = wavedec(signal, level , waveletName);
     % [wt , f]= cwt(signal,'db4');

      energy = sum((abs(wt).^2),'all');

      prob = abs(wt).^2 / energy;
      entropy = -sum(prob .* log(prob), 'all', 'omitnan');

      meanCoeff = mean(abs(wt), 'all');

      varCoeff = var(abs(wt), 0, 'all');
      
      time_frequency_featurs{j}=[energy,entropy,meanCoeff,varCoeff];
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% normal DATA %%%%%%%%%%%%%%%%%%%%%%%%
  for j=1:numSignalsnormal
      signalnormal = cluster_feature_normal{i}(j,:);
      [wtNormal , fnormal]=  wavedec(signalnormal, level , waveletName);


      energynormal = sum((abs(wtNormal).^2),'all');

      probnormal = abs(wtNormal).^2 / energynormal;
      entropynormal = -sum(probnormal .* log(probnormal), 'all', 'omitnan');

      meanCoeffnormal = mean(abs(wtNormal), 'all');

      varCoeffnormal = var(abs(wtNormal), 0, 'all');
      
      time_frequency_featurs_normal{j}=[energynormal,entropynormal,meanCoeffnormal,varCoeffnormal];
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Anormal DATA %%%%%%%%%%%%%%%%%%%%%%%%
for j=1:numSignalsAnormal
      signalAnormal = cluster_feature_Anormal{i}(j,:);
      [wtAnormal , fanormal]= wavedec(signalAnormal, level , waveletName);


      energyAnormal = sum((abs(wtAnormal).^2),'all');

      probanormal = abs(wtAnormal).^2 / energyAnormal;
      entropyanormal = -sum(probanormal .* log(probanormal), 'all', 'omitnan');

      meanCoeffAnormal = mean(abs(wtAnormal), 'all');

      varCoeffanormal = var(abs(wtAnormal), 0, 'all');
      
      time_frequency_featurs_Anormal{j}=[energyAnormal,entropyanormal,meanCoeffAnormal,varCoeffanormal];
end

cluster_features_Time_frequence {i}=time_frequency_featurs;
cluster_feature_normal_Time_frequence{i}=time_frequency_featurs_normal;
cluster_feature_Anormal_Time_frequence{i}=time_frequency_featurs_Anormal;

end
end