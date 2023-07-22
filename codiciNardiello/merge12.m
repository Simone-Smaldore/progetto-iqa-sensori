function [im13]=merge12(im1, im2)

im11 = imread(im1); %lettura dell'immagine a profondità di 0.05 mm
im12 = imread(im2); %lettura dell'immagine a profondità di 0.1 mm

im11 = imresize(im11, [542 814], 'bicubic');
im12 = imresize(im12, [542 814], 'bicubic');

%FILTRO PRESO DA CREATE_PALM_COLOR TOGLIENDO DOPPIA IMMAGINE MA
%LASCIANDO IL FILTRO
w1 = fspecial('average', [9,9]);   %9 migliore
im11 = imfilter(im11,w1);
im12 = imfilter(im12,w1);

dimensione = size(im11); 
dimensionerighe = dimensione(1);
dimensionecolonne= dimensione(2);

matriceFinale=zeros(dimensionerighe,dimensionecolonne);

im11 = double(im11);
im12 = double(im12);

for i=1:dimensionerighe    
    for j=1:dimensionecolonne
        if(im11(i,j)-im12(i,j)<0)
           matriceFinale(i,j)=im12(i,j);
        else
           matriceFinale(i,j)=im11(i,j);
        end
    end
end
matriceFinale2=uint8(matriceFinale);
im13=matriceFinale2;