%% Demonstration of some basic matlab commands and 
% image processing tools

startup 
cd TNM087-2015\Matlab\
impath = fullfile('C:','svn-enzo','TNM087-2015','Labs','Images');

%% Construct filename, get image information 
imname = 'scarves_camerawhite.jpg'
imfile = fullfile(impath,imname)
imfjpg = imfinfo(imfile)

%% Read and display image 
cimname = 'scarves.CR2'
cimfile = fullfile(impath,cimname);
infcr2 = imfinfo(cimfile);

oimage = imread(fullfile(impath,imname));
figure(1)
subplot(1,2,1),imshow(oimage)
gim = rgb2gray(oimage);
subplot(1,2,2),imshow(gim)
figure(10)
imshowpair(oimage,gim,'montage')
whos

%%

%% You can also read from a website:
czim = imread('http://www.completedigitalphotography.com/CDP8/Chapter16/scarves.cr2');
figure(2)
imshow(czim)

%%
close all
%% Different image types and their operations

i16im = uint16(gim);
x=i16im(:);
fim = im2double(oimage);
disp([max(gim(:)),max(x),max(fim(:));...
    max(gim(:)+gim(:)),max(x+x),max(fim(:)+fim(:))])
disp([double(max(gim(:))),double(max(x)),double(max(fim(:)));...
    double(max(gim(:)+gim(:))),double(max(x+x)),double(max(fim(:)+fim(:)))])
doubleim = double(oimage);
disp([max(fim(:)),max(oimage(:)),max(doubleim(:))])
%% displays

close all

figure(2)
imshow(i16im);
figure(3)
imshow(i16im,[])
figure(4)
imagesc(double(i16im)/double(max(i16im(:))))
figure(5)
imagesc(double(i16im)/double(max(i16im(:))))
colormap gray
axis image
axis off
axis tight

[sx,sy] = size(gim);
disp([imfjpg.Width,imfjpg.Height,sx,sy])

%%  Crop, : and end
cropim = gim(:,1000:end);
size(cropim)
figure(6)
imshow(cropim)

%% Logical images and operations

smallim = gim(1:4:end,1:4:end);
darkim = smallim>128;
truim = smallim;
truim(darkim) = 128;
figure(7)
imshowpair(smallim,truim,'montage')
figure(8)
imshowpair(smallim,truim)