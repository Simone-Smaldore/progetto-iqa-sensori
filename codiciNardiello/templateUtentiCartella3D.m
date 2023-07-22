%converte tutti i jpg di una data cartella suddivisi per utente, salvando i
%risultati in una nuova cartella suddivisi per istante
clear
clc
folderSaveName = 'template6';

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
    files = dir(fullfile([pathNameSubDirectory '\']));
    utenteCorrente = subFolders(k).name;
    for i=3:length(files)
        path=[directory '\' subFolders(k).name '\' files(i).name];
        [filesJpg, sizeFilesJpg] = elencaFileJpg(path);
        num_istante=num2str(files(i).name(end));
        if ~exist([saveDir '/' folderSaveName '/' utenteCorrente],'dir')
            mkdir([saveDir '/' folderSaveName '/' utenteCorrente]);
        end
        mkdir([saveDir '\' folderSaveName '/' utenteCorrente], [utenteCorrente '.' num_istante]);
        for y = 1:sizeFilesJpg
            fullPathName=[path '\' filesJpg(y).name];
            [fileDat, outputImage]=templateSRAD(fullPathName);         
            datResized = imresize(fileDat,[201 301],'bicubic');
            dlmwrite([saveDir '\' folderSaveName '/' utenteCorrente '\'  utenteCorrente '.' num_istante '\' 'TEMPLATE', num2str( y+3 ), '.dat'],datResized);
            imwrite(outputImage,[saveDir '\' folderSaveName '/' utenteCorrente '\'  utenteCorrente '.' num_istante '\' 'TEMPLATE', num2str( y+3 ), '.jpg']);
        end
        step=step+1;
        waitbar(step/numFiles);
    end
end

toc
close(wbar);
