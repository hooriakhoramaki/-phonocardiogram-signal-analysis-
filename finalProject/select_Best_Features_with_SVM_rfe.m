function [S1_ranked_feature,Top_feature_s1,S2_ranked_feature,Top_feature_s2,systol_ranked_feature,Top_feature_systol,diastol_ranked_feature,Top_feature_diastol] =  select_Best_Features_with_SVM_rfe(Input_normal_S1,Input_normal_S2,Input_normal_systol,Input_normal_diastol,Input_Anormal_S1,Input_Anormal_S2,Input_Anormal_systol,Input_Anormal_diastol,num_label_normal_s1,num_label_normal_s2,num_label_normal_systol)

%label_S1 = [ones(num_label_normal_s1,1); -ones(num_label_Anormal_s1,1)];
label_S1 = [Input_normal_S1(:,end) ; Input_Anormal_S1(:,end)];
s1_input=[Input_normal_S1;Input_Anormal_S1];

%label_S2 = [ones(num_label_normal_s2,1); -ones(num_label_Anormal_s2,1)];
label_S2 =[Input_normal_S2(:,end);Input_Anormal_S2(:,end)];
s2_input=[Input_normal_S2;Input_Anormal_S2];

%label_systol = [ones(num_label_normal_systol,1); -ones(num_label_Anormal_systol,1)];
label_systol=[Input_normal_systol(:,end);Input_Anormal_systol(:,end)];
systol_input=[Input_normal_systol;Input_Anormal_systol];

% label_diastol = [ones(num_label_normal_diastol,1); -ones(num_label_Anormal_diastol,1)];
label_diastol=[Input_normal_diastol(:,end);Input_Anormal_diastol(:,end)];
diastol_input=[Input_normal_diastol;Input_Anormal_diastol];

[S1_ranked_feature]= rankedfeatures_S1(s1_input , label_S1);
[S2_ranked_feature]= rankedfeatures_S2(s2_input , label_S2);
[systol_ranked_feature]= rankedfeatures_systol(systol_input , label_systol);
[diastol_ranked_feature]= rankedfeatures_diastol(diastol_input , label_diastol);


%%%%%%%%   REMOVE LOWER RANK FEATURES 


Top_feature_s1 = S1_ranked_feature(:, S1_ranked_feature(end, :) >= 8 | S1_ranked_feature(end, :) ==1);
Top_feature_s2 = S2_ranked_feature(:, S2_ranked_feature(end, :) >= 8 |S2_ranked_feature(end, :) == 1);
Top_feature_systol = systol_ranked_feature(:, systol_ranked_feature(end, :) >= 8 | systol_ranked_feature(end, :) == 1);
Top_feature_diastol = diastol_ranked_feature(:, diastol_ranked_feature(end, :) >= 8 |diastol_ranked_feature(end, :) ==1);



end