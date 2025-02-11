function[S2_ranked_feature]= rankedfeatures_S2(s2_input , label_S2)
num_feautures = size(s2_input,2);
feature_indicate =1:num_feautures;
ranked_feauture_s2 =zeros(1,num_feautures);
rank =num_feautures;


while ~isempty(feature_indicate)
       model = fitcsvm(s2_input(:,feature_indicate),label_S2,'KernelFunction','linear','Standardize',true);
       
       weights_s2 = model.Beta;
       features_importance = weights_s2.^2;
       [~ , minIdx] = min(features_importance);
       ranked_feauture_s2(feature_indicate(minIdx)) = rank;
       rank =rank -1;
       feature_indicate(minIdx) = [];
end
s2_input(end+1 ,:)=ranked_feauture_s2;
S2_ranked_feature = s2_input;

end
