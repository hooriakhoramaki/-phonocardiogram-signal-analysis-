function  saving(num_files,results)
% ذخیره نتایج در فایل CSV
for i = 1:num_files
    csvwrite([results{i}.file_name, '_features.csv'], results{i}.features);
end
save('segmentation_results.mat', 'results');

end