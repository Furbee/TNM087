function MImage = EllipsMask(FImage)
%EllipsMask Generate a mask for one eye and the complete face
%   Change pixel color for one eye and extract the face
%
%% Who has done it
%
% Author: vikhe927
% Co-author: oscno829
% 
%
%% Syntax of the function
%
% Input arguments:  Fimage: Image containing a face 
%
% Output argument:  Mimage: Image with elliptical mask and a red eye
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1.1
% Date: 2015-12-11
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

%% Your code starts here
%
%clear all;
clc;

%FImage = imread('/Users/VikH/Documents/TNM087/Images/einstein.jpg');
FImage = imread( FImage );


%% create the output image (RGB!) which is a copy of the original image
% Use einstein.jpg as your FImage

[sr,sc] = size( FImage );
%if ndims(FImage) < 2
%   MImage = cat(FImage,FImage,FImage);
%   
%else
    MImage = FImage;
%end


%% Generate the coordinates of the grid points
 [C R] = meshgrid((1:sc),(1:sr));
% Remember the matlab convention regarding rows, columns, x and y coordinates. Feel free to use 
% [Y,X] = meshgrid((1:sx),(1:sy)) or whatever notation instead if you feel more comfortable with that notation



%% Pick three points that define the elliptical mask of the face
% Read more about ellipses at https://en.wikipedia.org/wiki/Ellipse
% Your solution must at least be able to solve the problem for the case 
% where the axes of the ellipse are parallel to the coordinate axes
%
imshow(FImage);

disp('First choose centerpoint, then width and lastly height')
fpts = round(ginput(3));

centerPoint = fpts(1,:); %set centerpoint to the first point chosen
widthAxix = abs(fpts(2,1)-centerPoint(1,1)) ; %set length of x-axis
heightAxis = abs(fpts(3,2)-centerPoint(1,2)) ; %set length of y-axis 
% 
%% Generate the elliptical mask and 
% set all points in MImage outside the mask to black 
...
fmask = (((C-centerPoint(1))/widthAxix).^2 + ((R-centerPoint(2))/heightAxis).^2) <= 1; % this is the mask use C and R to generate it
MImage(~fmask) = 0; % in the Image where 

%% Pick two points defining one eye, generate the eyemask, paint it red

imshow(MImage);
disp('First choose centerpoint and then radius')

epts = round(ginput(2));

cCirc = epts(1,:); %set center of circle
rCirc = (abs(epts(2,1)-cCirc(1) + epts(2,2)-cCirc(2))); %set radius of circle

emask = ((C-cCirc(1))/rCirc).^2 + ((R-cCirc(2))/rCirc).^2 <= 1;% circular eye mask again, use C and R

redImage = MImage;  %create red,blue and green channels
greenImage = MImage;
blueImage = MImage;

redImage(emask) = 255; %set red-channel to max-value
greenImage(emask) = 0; %and the others to min-value
blueImage(emask) = 0;

MImage = cat(3, redImage, greenImage,blueImage); %merge channels to MImage


%% Display result if you want
%
imshow(MImage);

end

