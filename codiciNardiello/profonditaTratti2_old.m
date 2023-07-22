function [ matriceOutput ] = profonditaTratti2( matrice, matFile )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    matriceProfondita =  zeros(size(matrice,2),size(matrice,3));
    
    for (i=1:size(matrice,1))    
        
        matriceProfondita = matriceProfondita + squeeze(matrice(i,:,:));
        
    end
    
    matriceOutput = matriceProfondita;
          
    save(strcat(pwd,'\TemplateSRADW\',matFile,'\',matFile,'.dat'),'matriceOutput'); 

    istante = str2num(matFile(end));

    if(istante==0)

        save(strcat(pwd,'\Template3D14\istante000\',matFile,'.dat'),'matriceOutput');
    end

    if(istante==1)

        save(strcat(pwd,'\Template3D14\istante001\',matFile,'.dat'),'matriceOutput');

    end

    if(istante==2)

        save(strcat(pwd,'\Template3D14\istante002\',matFile,'.dat'),'matriceOutput');

    end
     if(istante==3)

        save(strcat(pwd,'\Template3D14\istante003\',matFile,'.dat'),'matriceOutput');
     end
         if(istante==4)

        save(strcat(pwd,'\Template3D14\istante004\',matFile,'.dat'),'matriceOutput');
         end
     if(istante==5)

        save(strcat(pwd,'\Template3D14\istante005\',matFile,'.dat'),'matriceOutput');
     end
      if(istante==6)

        save(strcat(pwd,'\Template3D14\istante006\',matFile,'.dat'),'matriceOutput');
      end
       if(istante==7)

        save(strcat(pwd,'\Template3D14\istante007\',matFile,'.dat'),'matriceOutput');
       end
          if(istante==8)

        save(strcat(pwd,'\Template3D14\istante008\',matFile,'.dat'),'matriceOutput');
          end
          if(istante==9)

        save(strcat(pwd,'\Template3D14\istante009\',matFile,'.dat'),'matriceOutput');
          end
       
    %figure
    %imshow(matriceOutput)
        
end

