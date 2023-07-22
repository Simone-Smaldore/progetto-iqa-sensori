%%
for i=0:1
   
 %%   
 disp( strcat('acquisizione: ',num2str(i)));
    
    for j=1:7
        
try
a=imread(strcat(num2str(i),'.',num2str(j),'.png'));
im=imresize(a,[175,175], 'bicubic');

 imshow(im);
 figure;
 smart_clean('NoWhiteSpace');
catch
    messaggio = strcat('Problema nella generazione del template');  
end
    end
end