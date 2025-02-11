

function [signal,fs] = readData(data_folder,file_list,i)

 % خواندن فایل WAV
    wav_file = fullfile(data_folder, file_list(i).name);
    [signal, fs] = audioread(wav_file); 
   

end