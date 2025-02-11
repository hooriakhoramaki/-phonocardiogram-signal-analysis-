function[S1_ranked_feature]= rankedfeatures_S1(s1_input , label_S1)

num_feautures = size(s1_input,2);
feature_indicate =1:num_feautures;
ranked_feauture_s1 =zeros(1,num_feautures);
rank =num_feautures;


while ~isempty(feature_indicate)
       model = fitcsvm(s1_input(:,feature_indicate),label_S1,'KernelFunction','linear','Standardize',true);
       
       weights_s1 = model.Beta;
       features_importance = weights_s1.^2;
       [~ , minIdx] = min(features_importance);
       ranked_feauture_s1(feature_indicate(minIdx)) = rank;
       

       rank =rank -1;
       feature_indicate(minIdx) = [];
end

s1_input(end+1 ,:)=ranked_feauture_s1;
S1_ranked_feature = s1_input;

end
