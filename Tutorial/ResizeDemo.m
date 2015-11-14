%% Files, images, resize
%

% Where to find images
ImDirName = 'Images';
PathName = fullfile('C:','svn-enzo','TNM087-2015');
% fullfile('C:','svn-enzo','TNM087-2015','Images')
% folder list
gifimlist = dir(fullfile(PathName,ImDirName,'*.gif'));
% Conversion from number to string, number of elements
disp(['Number of gif-images: ',num2str(numel(gifimlist))])

%% Information about the k-th image in the list
k = 2;
imfinfo(fullfile(PathName,ImDirName,gifimlist(k).name))

%% Read it ocnvert to double and show them
I = imread(fullfile(PathName,ImDirName,gifimlist(k).name));
dI = im2double(I);
figure(1)
imshow(I)
figure(2)
imshowpair(I,dI,'montage')
%% Resize to 1/4th of original size

LN = imresize(imresize(dI,0.25,'nearest'),4,'nearest');
LB = imresize(imresize(dI,0.25,'bilinear'),4,'bilinear');
LC = imresize(imresize(dI,0.25,'bicubic'),4,'bicubic');
S = (1:256);
Im256 = cat(3,LN(S ,S),LB (S ,S),LC(S ,S));
figure(3)
imshow(Im256)
disp('pause')
% pause
set(gcf,'NumberTitle','off','Name','Images as RGB image')
%% Show as montage

Ims256 = zeros(256,256,3,3);

for bw = 1:3
    Ims256(:,:,bw,1) = LN(S,S);
    Ims256(:,:,bw,2) = LB(S,S);
    Ims256(:,:,bw,3) = LC(S,S);
end
figure(4)
montage(Ims256,'Size',[1 3])
%% Plotting the gray values along a line
% I = imread('D26.gif');
BN = imresize(I(1:64,1:64), 4,'nearest');
BB = imresize(I(1:64,1:64), 4,'bilinear');
BC = imresize(I(1:64,1:64), 4,'bicubic');
kk = cat(2,BN,BB,BC);
imshow(kk,'InitialMagnification',100)
%%
figure
plot(BN(128,:),'r.-')
hold on
plot(BC(128,:),'k.-')
plot(BB(128,:),'b.-')
legend('Nearest','Bicubic','Bilinear')
title('Interpolation zoom factor 4')
%% Scale down / Scale up
JN = imresize(imresize(I,0.25,'nearest'),4,'nearest');
JB = imresize(imresize(I,0.25,'bilinear'),4,'bilinear');
JC = imresize(imresize(I,0.25,'bicubic'),4,'bicubic');
S = (1:256);
ll = cat(2,JN(S ,S),JB (S ,S),JC(S ,S));
figure
imshow(ll)
%% Plotting the gray values along a line
figure
plot(JN(128,:),'r.-')
hold on
plot(JB(128,:),'b.-')
plot(JC(128,:),'k.-')
legend('Nearest','Bicubic','Bilinear')