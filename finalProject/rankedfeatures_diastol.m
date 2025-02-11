function[diastol_ranked_feature]= rankedfeatures_diastol(diastol_input , label_diastol)
num_feautures = size(diastol_input,2);
feature_indicate =1:num_feautures;
ranked_feauture_diastol =zeros(1,num_feautures);
rank =num_feautures;


while ~isempty(feature_indicate)
       model = fitcsvm(diastol_input(:,feature_indicate),label_diastol,'KernelFunction','linear','Standardize',true);
       
       weights_diastol = model.Beta;
       features_importance = weights_diastol.^2;
       [~ , minIdx] = min(features_importance);
       ranked_feauture_diastol(feature_indicate(minIdx)) = rank;
       rank =rank -1;
       feature_indicate(minIdx) = [];
end
diastol_input(end+1 ,:)=ranked_feauture_diastol;
diastol_ranked_feature = diastol_input;
end
