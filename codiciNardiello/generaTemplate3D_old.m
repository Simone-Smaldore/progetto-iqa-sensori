clear all;

clc; 
close all;

cartella=uigetdir(pwd, 'Seleziona la cartella file.mat');
directory_name=pwd;
cartella=strcat(cartella,'\');
dirs=dir(fullfile(cartella));
mkdir('Template3D14');
mkdir('Template3D14\istante000');
mkdir('Template3D14\istante001');
mkdir('Template3D14\istante002');
mkdir('Template3D14\istante003');
mkdir('Template3D14\istante004');
mkdir('Template3D14\istante005');
mkdir('Template3D14\istante006');
mkdir('Template3D14\istante007');
mkdir('Template3D14\istante008');
mkdir('Template3D14\istante009');

k=1;
for i=3:length(dirs)
	path=strcat(cartella, dirs(i).name);
	path=strcat(path, '\');
	files=dir(fullfile(path, '*.mat'));
	Dimensione=size(files, 1);
	elementi=Dimensione;
	for contatore=1:elementi
		corrente=files(contatore).name(1:length(files(contatore).name)-4);
		mkdir(strcat('template/', corrente, '/'));
        profonditaTratti2(filtraggioInProfondita(generaMatriceContenenteTemplate(corrente),2),corrente);
	end
end	