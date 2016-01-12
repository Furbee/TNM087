function sfunction = Sharpness(FStack)
%TNM087Template General Template for TNM087 Lab Tasks
%   Everybody has to use this template
%
%% Who has done it
%
% Author: vikhe927
% Co-author: oscno829
% 
%
%% Syntax of the function
%
% Input arguments: In1, In2 are the input variables defined in the
%   lab-document
% Output arguments: Out1, Out2 output variables defined in the lab-document
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 2
% Date: 12/1/2016
%
% Gives a history of your submission to Lisam.
% Version and date for this function have to be updated before each
% submission to Lisam (in case you need more than one attempt)
%
%% General rules
%
% 1) Don't change the structure of the template by removing %% lines
%
% 2) Document what you are doing using comments
%
% 3) Before submitting make the code readable by using automatic indentation
%       ctrl-a / ctrl-i
%
% 4) In case a task requires that you have to submit more than one function
%       save every function in a single file and collect all of them in a
%       zip-archive and upload that to Lisam. NO RAR, NO GZ, ONLY ZIP!
%       All non-zip archives will be rejected automatically
%
% 5) Often you must do something else between the given commands in the
%       template
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             TEST VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% clear all
% close all 
% clc
% 
% load('/Users/VikH/Documents/TNM087/Images/AutoFocus32x32Patches.mat');
% FStack = winsuint8;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             RUNTIME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Size of images and number of images
%
[sx,sy,noimages] = size(FStack);

%% Generate a grid, convert the Euclidean to polar coordinates
%
ax = linspace(-1, 1, sx);
ay = linspace(-1, 1, sy);
[X, Y] = meshgrid(ax,ay);
[~,R] = cart2pol(X,Y);

%% Number of COMPLETE rings in the Fourier domain 
% ignore the points in the corners

norings = 8; %Change this if you want

RQ = round(R*(norings-1));%this is the quantized version of R where 
% the pixel value is the index of the ring 
% (origin = 0, and the point (0,r) has index norings  
%...

maxindex = max(RQ(:));

%% Number of grid points in each ring

ptsperring = zeros(norings,1);
for ringno = 1:maxindex 
    RMask = (round(RQ) == ringno);
    ptsperring(ringno) = sum(sum(RMask));  
end

%% Sum of fft magnitude per image - per ring

absfftsums = zeros(noimages,maxindex);
padding = [16,16];

for imno = 1:noimages
    padimage = padarray(FStack(:,:,imno),padding);% Read about zero-padding
    ftplan = fft2(padimage); % 2D fft
    cftplan = abs(fftshift(ftplan)); % move origin to the center
    
    for ringno = 1:norings
        ringmask = (RQ == ringno);%this is a logical array defining the ring
        padmask = padarray(ringmask, padding);
        magnitude = sum(sum(cftplan(padmask)));
        absfftsums(imno,ringno) = magnitude / ptsperring(ringno);% average over Fourier magnitude in ring
    end
end

%% Compute weighted average over the ring sums
%

meanfreqcontent = zeros(noimages,1);

w = norings; % here you may use the ring index, radius or something you define

for imno = 1:noimages
    meanfreqcontent(imno) = mean(w'.*absfftsums(imno,:),2); % combine w and absfftsums
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             TESTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get sharpest image and display it

% SharpestPic = max(meanfreqcontent);
% A = find(meanfreqcontent == SharpestPic);
% figure
% imshow(FStack(:,:,A))

% Display mean freq of the whole stack

% figure;
% plot(meanfreqcontent)

%% Requested result
% default solution but you can invent something else if you want
sfunction = meanfreqcontent;

end

