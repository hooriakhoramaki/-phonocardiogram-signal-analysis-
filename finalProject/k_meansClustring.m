function  [cluster_feature,numClusters, idx,all_features_splited,cluster_feature_normal,cluster_feature_Anormal] = k_meansClustring(results, num_files,normal_Anormal_list)


all_features = [];

Normal_featurs=[];
Anormal_featurs=[];



%%disp(['normal size:',num2str(num_Normal),'Anormal size:',num2str(num_Anormal)]);

for i=1 :num_files 


          if ~isnan (normal_Anormal_list(i).normal)
          Normal_featurs = [Normal_featurs; results(i).features];
  
          elseif ~isnan (normal_Anormal_list(i).Anormal)
              Anormal_featurs = [Anormal_featurs;  results(i).features];

             
         end
     

       end


all_features_splited = struct('Normal',Normal_featurs,'Anormal',Anormal_featurs);



for i = 1:num_files
    all_features = [all_features; results(i).features];  % ویژگی‌ها را اضافه می‌کنیم
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% for all data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numClusters = 4;  % تعداد خوشه‌ها
[idx, C] = kmeans(all_features, numClusters);  % خوشه‌بندی داده‌ها

cluster_feature = cell(1,numClusters);

for i=1:numClusters
    cluster_feature{i}=all_features(idx ==i,:);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% for normal Data %%%%%%%%%%%%%%%%%%%%%%%%%%%
[idxNormal , cNormal] = kmeans(Normal_featurs,numClusters);

cluster_feature_normal =cell(1,numClusters);

for i=1 :numClusters
    cluster_feature_normal{i} = Normal_featurs(idxNormal ==i ,:);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% for Anormal Data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[idxAnormal , cAnormal] = kmeans(Anormal_featurs,numClusters);

cluster_feature_Anormal =cell(1,numClusters);

for i=1 :numClusters
    cluster_feature_Anormal{i} = Anormal_featurs(idxAnormal ==i ,:);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% for all data
figure;
gscatter(all_features(:,1), all_features(:,2), idx, 'yrgb', 'xo');
hold on;
plot(C(:,1), C(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);  % نمایش مراکز خوشه‌ها
title('K-means Clustering with 4 Clusters for all data');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Centroids');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% for normal data
figure;
gscatter(Normal_featurs(:,1),Normal_featurs(:,2), idxNormal, 'yrgb', 'xo');
hold on;
plot(cNormal(:,1), cNormal(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);  % نمایش مراکز خوشه‌ها
title('K-means Clustering with 4 Clusters for Normal heart sound');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Centroids');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% for Anormal data
figure;
gscatter(Anormal_featurs(:,1), Anormal_featurs(:,2), idxAnormal, 'yrgb', 'xo');
hold on;
plot(cAnormal(:,1), cAnormal(:,2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);  % نمایش مراکز خوشه‌ها
title('K-means Clustering with 4 Clusters for anormal heart Sound');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Centroids');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end