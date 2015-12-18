%% Histogram equalization after truncation of outliers
% Reiner Lenz
% 2013
%

%% init
clear all
close all

%% Parameters

qnumber = 0.95 % quantile
hbins = 256; % number of histogram bins

%% Read hdr-image and convert to gray image

ima = hdrread('../Images/kansai.hdr');
grayim = double(rgb2gray(ima));

%% Convert and show result
ngray = min(double(grayim),quantile(grayim(:),qnumber));
ngray=ngray/max(ngray(:));
f1 = figure
imshow(ngray,[])
f2 = figure;
imshow(histeq(ngray,hbins),[])
