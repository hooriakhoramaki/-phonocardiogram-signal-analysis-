function [results,normal_Anormal_list] = splitNormal_AnormalSound( results , i,normal_Anormal_list )



folderPath='F:\academia\term1\BSP\classification-of-heart-sound-recordings-the-physionet-computing-in-cardiology-challenge-2016-1.0.0\training-a';
fileName='REFERENCE.csv';
filePath = fullfile(folderPath,fileName);
list_XlX_Normal_Anormal=readtable(filePath);

 columnDignosticPation =  list_XlX_Normal_Anormal{i,2};

   if columnDignosticPation == 1
        normal_Anormal_list(i).normal=results(i).file_name.name;
        normal_Anormal_list(i).Anormal=NaN;

        if isfield(results(i), 'health')

           results(i).health = [results(i).health; 1];
          else
           results(i).health = 1;
        end
 
  elseif columnDignosticPation == -1
            normal_Anormal_list(i).Anormal=results(i).file_name.name;
            normal_Anormal_list(i).normal=NaN;

        if isfield(results(i), 'health')
             results(i).health = [results(i).health; -1];
             else
               results(i).health = -1;
        end
   end

end


