function [best_featuresinCluster_S1,best_featuresinCluster_S2,best_featuresinCluster_systol,best_featuresinCluster_diastol] =  selectBestfeatureWithSvm(Input_normal_S1,Input_normal_S2,Input_normal_systol,Input_normal_diastol,Input_Anormal_S1,Input_Anormal_S2,Input_Anormal_systol,Input_Anormal_diastol,num_label_normal_s1,num_label_normal_s2,num_label_normal_systol,num_label_normal_diastol,num_label_Anormal_s1,num_label_Anormal_s2,num_label_Anormal_systol,num_label_Anormal_diastol)

label_S1 = [ones(num_label_normal_s1,1); -ones(num_label_Anormal_s1,1)];
s1_input=[Input_normal_S1;Input_Anormal_S1];

label_S2 = [ones(num_label_normal_s2,1); -ones(num_label_Anormal_s2,1)];
s2_input=[Input_normal_S2;Input_Anormal_S2];

label_systol = [ones(num_label_normal_systol,1); -ones(num_label_Anormal_systol,1)];
systol_input=[Input_normal_systol;Input_Anormal_systol];

label_diastol = [ones(num_label_normal_diastol,1); -ones(num_label_Anormal_diastol,1)];
diastol_input=[Input_normal_diastol;Input_Anormal_diastol];


best_featuresinCluster_S1  = fitcsvm(s1_input,label_S1);
best_featuresinCluster_S2  =   fitcsvm(s2_input,label_S2);
best_featuresinCluster_systol =  fitcsvm(systol_input,label_systol);
best_featuresinCluster_diastol =  fitcsvm(diastol_input,label_diastol);



end
