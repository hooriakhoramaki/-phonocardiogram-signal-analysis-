function[systol_ranked_feature]= rankedfeatures_systol(systol_input , label_systol)
num_feautures = size(systol_input,2);
feature_indicate =1:num_feautures;
ranked_feauture_systol =zeros(1,num_feautures);
rank =num_feautures;


while ~isempty(feature_indicate)
       model = fitcsvm(systol_input(:,feature_indicate),label_systol,'KernelFunction','linear','Standardize',true);
       
       weights_systol = model.Beta;
       features_importance = weights_systol.^2;
       [~ , minIdx] = min(features_importance);
       ranked_feauture_systol(feature_indicate(minIdx)) = rank;
       rank =rank -1;
       feature_indicate(minIdx) = [];
end

systol_input(end+1 ,:)=ranked_feauture_systol;
systol_ranked_feature = systol_input;

end
