function [Input_normal_S1,Input_normal_S2,Input_normal_systol,Input_normal_diastol,Input_Anormal_S1,Input_Anormal_S2,Input_Anormal_systol,Input_Anormal_diastol]=AllFeaturesinMatrix(cluster_feature_normal_time,cluster_feature_normal_frequence,cluster_feature_normal_Time_frequence, cluster_feature_Anormal_time,cluster_feature_Anormal_frequence,cluster_feature_Anormal_Time_frequence)



% num_label_normal_s1=length(cluster_feature_normal_time{1});
% num_label_normal_s2=length(cluster_feature_normal_time{2});
% num_label_normal_systol=length(cluster_feature_normal_time{3});
% num_label_normal_diastol=length(cluster_feature_normal_time{4});
% 
% num_label_Anormal_s1=length(cluster_feature_Anormal_time{1});
% num_label_Anormal_s2=length(cluster_feature_Anormal_time{2});
% num_label_Anormal_systol=length(cluster_feature_Anormal_time{3});
% num_label_Anormal_diastol=length(cluster_feature_Anormal_time{4});

disp(['size cell2mat s1 :',num2str(size(cluster_feature_normal_time{1}))]);
disp(['size cell2mat s1 :',num2str(size(cell2mat(cluster_feature_normal_frequence{1})))]);
disp(['size cell2mat s1 :',num2str(size(cell2mat(cluster_feature_normal_Time_frequence{1})))]);



Input_normal_S1=[cluster_feature_normal_time{1},  cell2mat(cluster_feature_normal_frequence{1}), cell2mat( cluster_feature_normal_Time_frequence{1}) ];
Input_normal_S2 =[cluster_feature_normal_time{2},  cell2mat(cluster_feature_normal_frequence{2}), cell2mat( cluster_feature_normal_Time_frequence{2}) ];
Input_normal_systol=[cluster_feature_normal_time{3},  cell2mat(cluster_feature_normal_frequence{3}), cell2mat( cluster_feature_normal_Time_frequence{3}) ];
Input_normal_diastol =[cluster_feature_normal_time{4},  cell2mat(cluster_feature_normal_frequence{4}), cell2mat( cluster_feature_normal_Time_frequence{4}) ];

Input_Anormal_S1=[cluster_feature_Anormal_time{1}, cell2mat(cluster_feature_Anormal_frequence{1}) ,  cell2mat(cluster_feature_Anormal_Time_frequence{1})];
Input_Anormal_S2 = [cluster_feature_Anormal_time{2}, cell2mat(cluster_feature_Anormal_frequence{2}) ,  cell2mat(cluster_feature_Anormal_Time_frequence{2})];
Input_Anormal_systol =[cluster_feature_Anormal_time{3}, cell2mat(cluster_feature_Anormal_frequence{3}) ,  cell2mat(cluster_feature_Anormal_Time_frequence{3})];
Input_Anormal_diastol =[cluster_feature_Anormal_time{4}, cell2mat(cluster_feature_Anormal_frequence{4}) ,  cell2mat(cluster_feature_Anormal_Time_frequence{4})];

Input_normal_S1(: ,end+1)=1;
Input_normal_S2(:, end+1)=1;
Input_normal_systol(: ,end+1)=1;
Input_normal_diastol(: ,end+1)=1;

Input_Anormal_S1(: ,end+1)=-1;
Input_Anormal_S2(: ,end+1)=-1;
Input_Anormal_systol(: ,end+1)=-1;
Input_Anormal_diastol(: ,end+1)=-1;




end