%Questa funzione genera, a partire dai render .jpg, due nuovi database, uno per HandGeometry e uno per palmprint.
%Il DB riguardante HG contiene 6 file.dat per ogni acquisizione, questi file sono i template generati a partire dal render.
%Il DB del palmprint invece contiene i .jpg del solo palmo estratti dall'intera mano 

%Prende in INPUT il database che contiene i render 2D, ovvero le immagini dell'intera mano.
%--------------------------------------------------------------------------
directory = uigetdir(pwd,'Seleziona la directory contenente i render 2D:');


%dirDat = uigetdir(pwd,'Seleziona la directory contenente file Mat: ');

elencaSottocartelle;
error = 0;

 %profonditaNaming = [0.2 1 2];
 profonditaNaming = [100 150 200 250 300 350 400 450 500 550 600 650 700 750 800];
 
 %FileName=strcat( 'template_', num2str(profonditaNaming(i) ),'.jpg' );
 

for kk=0:sizeSubFolders-1
    directory2 = [directory '\' subFolders(kk+1).name]
    [m, n] = size(dir(directory2));
    
    for g =1 :  m-2
        FileNameDat=strcat( directory,'\', subFolders(kk+1).name, '\', num2str(g),'\',subFolders(kk+1).name,'_',num2str(g))
        %DataFolder=['DATABASE_TEMPLATE' '\',subFolders(kk+1).name, '\', num2str(g)];
       % mkdir(DataFolder);
       
        for gg = 2 : 16
            error = 0;
           % DataFolder=['DATABASE_TEMPLATE' '\',num2str(profonditaNaming(gg)),'mm','\',subFolders(kk+1).name, '.', num2str(g)];
            %mkdir(DataFolder);
              
            FilejpgName=strcat( 'Immagine_', num2str((gg) ),'.jpg')
            pathNameImmagine=[directory '\' subFolders(kk+1).name '\' num2str(g) '\' FilejpgName ]
            %filenameData = strcat(pathNameSubDirectory,'\',subFolders(kk+1).name,'_',num2str(g));
             
            aa = imread(pathNameImmagine);
         try
            
            
                Binarizzazione;
                PartenzaDistanza;
                MininiMassimi;
%                 HandGeometry;
               
                GeometriaMano;
                  catch
                 %  messaggio = strcat('Problema nella generazione del template',DataFolder,'\',subFolders(kk+1).name,'.',num2str(g));
             messaggio = strcat('Problema nella generazione del template');   
             warning(messaggio);
                error = 1;
            end
                %-------------------------------
%                 crop ROI PALMO
               
                databaseRenderPalmo = ['DATABASE_RENDER_PALMOX', '\',num2str(profonditaNaming(gg-1)),'mm','\',subFolders(kk+1).name, '.', num2str(g)];
                mkdir(databaseRenderPalmo)
                
                %-------------------------------
        
               DataFolder=['DATABASE_TEMPLATE_HandGeometryP', '\',num2str(profonditaNaming(gg-1)),'mm','\',subFolders(kk+1).name, '.', num2str(g)]
               mkdir(DataFolder)
             
            if(error == 0)
                %hand geometry
                fileName = strcat(DataFolder,'\',subFolders(kk+1).name,'.',num2str(g),'_1','.dat');
                fileName2 = strcat(DataFolder,'\',subFolders(kk+1).name,'.',num2str(g),'_1','.jpg');
                save(fileName,'vettoreUtente'); 
                
                
                %palmprint Q = A( round(r(2)) + (1:r(4)) , round(r(1)) + (1:r(3)) );
%               Palm = aa(round(YMedioIndice):YprimoMignolo,XprimoPollice:round(XMedioMignolo)); % poi vediamo se � possibile una alternativa 
%               Palm = aa(round(YsecondoPuntoRoiPalmo):YprimoPuntoRoiPalmo, XterzoPuntoRoiPalmo:round(XprimoPuntoRoiPalmo)); % poi vediamo se � possibile una alternativa 
%               Palm = aa( round(YprimoPuntoRoiPalmo:YterzoPuntoRoiPalmo) + (YsecondoPuntoRoiPalmo:YquartoPuntoRoiPalmo) , round(XsecondoPuntoRoiPalmo:XprimoPuntoRoiPalmo) + (XterzoPuntoRoiPalmo:XquartoPuntoRoiPalmo));   
                             
                x=[round(YprimoPuntoRoiPalmo) round(YsecondoPuntoRoiPalmo) round(YquartoPuntoRoiPalmo) round(YterzoPuntoRoiPalmo) (YprimoPuntoRoiPalmo)];
                y=[round(XprimoPuntoRoiPalmo) round(XsecondoPuntoRoiPalmo) round(XquartoPuntoRoiPalmo) round(XterzoPuntoRoiPalmo) (XprimoPuntoRoiPalmo)];
                A = roipoly(aa,y,x);
%                 figure, imshow(A);
                
                palmProva=zeros(414,500);
                for i=1:414
                    for j=1:500
                        if(A(i,j)==1)
                            palmProva(i,j)=aa(i,j);
                        end
                    end
                end
                
                angolo=radtodeg((YprimoPuntoRoiPalmo-YterzoPuntoRoiPalmo)/(XprimoPuntoRoiPalmo-XterzoPuntoRoiPalmo));
                palmoRuotato=imrotate(palmProva,angolo);
             figure,imshow(palmoRuotato);
                
                L=logical(palmoRuotato);
                box=regionprops(L,'Area', 'BoundingBox');
                immagine = imcrop(palmoRuotato,[box.BoundingBox(1) box.BoundingBox(2) box.BoundingBox(3) box.BoundingBox(4) ]);
                immagineRoiPalmo=uint8(immagine(2:134,2:134));
                pixelPerInch=get(0,'ScreenPixelsPerInch');
                dimesioneInch=size(immagineRoiPalmo,1)/pixelPerInch;               dimensioneCm=dimesioneInch*2.54;
                 figure,imshow(immagineRoiPalmo)
                FileName = strcat('render_',num2str(profonditaNaming(gg-1)),'.jpg');
                Name = fullfile(databaseRenderPalmo, FileName);
                imwrite(immagineRoiPalmo, Name, 'jpg');
                 ROIpalm = imresize(Palm,[542 814],'bicubic');
                 FileNameMat = strcat('ROIpalm',num2str(profonditaNaming(gg)));
                 save (FileNameMat, 'immagine')
               
                
            end
           clearvars -except DataFolder gg g kk profonditaNaming vettoreUtente directory subFolders FileNameDat 
            
          
        end
      
       
end   
   
 end

