function[cluster_features ,cluster_feature_normal,cluster_feature_Anormal] = timesDomainFeatureExtraction(cluster_feature , numClusters ,cluster_feature_normal,cluster_feature_Anormal)

p = 3; 
n = 2; 


for i = 1:numClusters


    AMDF_features = zeros(size(cluster_feature{i}, 1), 1);  
    AMDF_normal_features = zeros(size(cluster_feature_normal{i}, 1), 1);  
    AMDF_Anormal_features = zeros(size(cluster_feature_Anormal{i}, 1), 1); 

    AR_features = zeros(size(cluster_feature{i}, 1), p); 
    AR_normal_features = zeros(size(cluster_feature_normal{i}, 1), p); 
    AR_Anormal_features = zeros(size(cluster_feature_Anormal{i}, 1), p);  

    poly_features = zeros(size(cluster_feature{i}, 1), n+1); 
    poly_features_normal = zeros(size(cluster_feature_normal{i}, 1), n+1);  
    poly_features_anormal = zeros(size(cluster_feature_Anormal{i}, 1), n+1); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   AMDF   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   for j = 1:size(cluster_feature{i}, 1)
        signal = cluster_feature{i}(j, :);  
        AMDF_features(j) = AMDF(signal);
    end

    %%%%%%%%%%%%%%%%%   normal DATA   %%%%%%%%%%%%%%
    for j = 1:size(cluster_feature_normal{i}, 1)
        signal = cluster_feature_normal{i}(j, :); 
        AMDF_normal_features(j) = AMDF(signal);
    end
    %%%%%%%%%%%%%%%%    Anormal DATA     %%%%%%%%%%%%%%
   for j = 1:size(cluster_feature_Anormal{i}, 1)
        signal = cluster_feature_Anormal{i}(j, :);  
        AMDF_Anormal_features(j) = AMDF(signal);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   AUTO REGRESSION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for j = 1:size(cluster_feature{i}, 1)
        signal = cluster_feature{i}(j, :); 
        ar_coeffs = aryule(signal, p);  
        AR_features(j, :) = ar_coeffs(2:end);  
    end

   %%%%%%%%%%%%%%%%%   normal DATA   %%%%%%%%%%%%%%
    for j = 1:size(cluster_feature_normal{i}, 1)
        signal = cluster_feature_normal{i}(j, :); 
        ar_coeffs_normal = aryule(signal, p);
        AR_normal_features(j, :) = ar_coeffs_normal(2:end);
    end
    %%%%%%%%%%%%%%%%    Anormal DATA     %%%%%%%%%%%%%%
   for j = 1:size(cluster_feature_Anormal{i}, 1)
        signal = cluster_feature_Anormal{i}(j, :); 
        ar_coeffs_Anormal = aryule(signal, p);
        AR_Anormal_features(j, :) = ar_coeffs_Anormal(2:end);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% polynomial fitting %%%%%%%
    
    
    for j = 1:size(cluster_feature{i}, 1)
        signal = cluster_feature{i}(j, :); 
        poly_features(j, :) = polyfit(1:length(signal), signal, n);
    end
    
   %%%%%%%%%%%%%%%%%   normal DATA   %%%%%%%%%%%%%%

   for j = 1:size(cluster_feature_normal{i}, 1)
        signal = cluster_feature_normal{i}(j, :); 
        poly_features_normal(j, :) = polyfit(1:length(signal), signal, n);
    end

    %%%%%%%%%%%%%%%%    Anormal DATA     %%%%%%%%%%%%%%

    for j = 1:size(cluster_feature_Anormal{i}, 1)
        signal = cluster_feature_Anormal{i}(j, :);  
        poly_features_anormal(j, :) = polyfit(1:length(signal), signal, n);
    end


    % ترکیب ویژگی‌های مختلف
    cluster_features{i} = [AMDF_features, AR_features, poly_features];
    cluster_feature_normal{i} = [AMDF_normal_features, AR_normal_features, poly_features_normal];
    cluster_feature_Anormal{i} = [AMDF_Anormal_features, AR_Anormal_features, poly_features_anormal];

   
end
end