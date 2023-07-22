clear
clc
folderSaveName = 'TemplateGeneratiW1';

elencaSottocartelle;

%stringa percorso salvataggio nella cartella superiore a directory attuale
parts = strsplit(directory, '\');
DirPart = parts{end-1};
saveDir = strjoin(parts(1:end-1),'\'); 

%controlla se esiste la cartella con il nome, altrimenti la crea
if ~exist(folderSaveName, 'dir') 
    mkdir(saveDir, folderSaveName); 
end


tic
for k=1:sizeSubFolders
    pathNameSubDirectory=[directory '\' subFolders(k).name];
    [filesJpg, sizeFilesJpg] = elencaFileJpg(pathNameSubDirectory);
    utenteCorrente = subFolders(k).name;
    
        
        if ~exist([saveDir '/' folderSaveName '/' utenteCorrente],'dir')
            mkdir([saveDir '/' folderSaveName '/' utenteCorrente]);
        end
        fullPathName1=[pathNameSubDirectory '\' filesJpg(1).name];
        fullPathName2=[pathNameSubDirectory '\' filesJpg(2).name];
            [im13]=merge12(fullPathName1, fullPathName2);
            
        imwrite(im13,[saveDir '\' folderSaveName '/' utenteCorrente '\' 'immagine', num2str( 3.5 ), '.jpg']);
       
        
   
end

toc

