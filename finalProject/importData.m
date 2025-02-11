function [data_folder,num_files,file_list] = importData()

data_folder = 'F:\academia\term1\BSP\classification-of-heart-sound-recordings-the-physionet-computing-in-cardiology-challenge-2016-1.0.0\training-a'; % مسیر پوشه داده‌ها
file_list = dir(fullfile(data_folder, '*.wav')); % فقط فایل‌های WAV
num_files = length(file_list);
disp(['Number of files: ', num2str(num_files)]);



end