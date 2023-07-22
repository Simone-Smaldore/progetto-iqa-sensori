%converte tutti i jpg di una data cartella suddivisi per utente, salvando i
%risultati in una nuova cartella suddivisi per istante
clear
clc
folderSaveName = 'TemplateSRADW1';

elencaSottocartelle;

%waitbar
[files,folders,size] = rdir(directory);
numFiles = length(files);
wbar=waitbar(0,'Generazione file .dat e .jpg in corso');
step=0;

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
    for i=3:sizeFilesJpg
        num_istante=num2str(filesJpg(i).name(end-5 : end-4));
        if ~exist([saveDir '/' folderSaveName '/' utenteCorrente],'dir')
            mkdir([saveDir '/' folderSaveName '/' utenteCorrente]);
        end
        fullPathName=[pathNameSubDirectory '\' filesJpg(i).name];
        [fileDat, outputImage]=templateSRAD(fullPathName);         
        datResized = imresize(fileDat,[201 301],'bicubic');
        dlmwrite([saveDir '\' folderSaveName '/' utenteCorrente '\'  'TEMPLATE', num2str( i+1 ), '.dat'],datResized);
        imwrite(outputImage,[saveDir '\' folderSaveName '/' utenteCorrente '\' 'TEMPLATE', num2str( i+1 ), '.jpg']);
        step=step+1;
        waitbar(step/numFiles);
    end
end

toc
close(wbar);