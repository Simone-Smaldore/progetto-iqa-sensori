function [ matriceOutput ] = generaMatriceContenenteTemplate(matFile)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
         
    %path = 'codice/palmprint_tesi/template/lines_template/provaProfondita/';    
    
    path=strcat(pwd,'\template\',matFile,'\', matFile, '\');
    
    %ricommentare template1
    %template1 = importdata(strcat(path,'TEMPLATE1.dat'));
    template2 = importdata(strcat(path,'TEMPLATE4.dat'));
    template3 = importdata(strcat(path,'TEMPLATE5.dat'));
    template4= importdata(strcat(path,'TEMPLATE6.dat'));
    template5 = importdata(strcat(path,'TEMPLATE7.dat'));
    template6 = importdata(strcat(path,'TEMPLATE8.dat'));
    sizeTemplate = size(template2);
    
    matriceTemplate =  zeros(sizeTemplate(1),sizeTemplate(2),12);
    
    for (i=2:6)    
        
        index = i;
        
        index = int2str(index);
        
        name = strcat('template',index);
        
        currentTemplate = eval(name);
        
        matriceTemplate(:,:,i-1) = currentTemplate;
        
        %figure;imshow(currentTemplate);
        
    end
    
    matriceTemplate = shiftdim(matriceTemplate,2);
      
    matriceOutput = matriceTemplate;
    
end

