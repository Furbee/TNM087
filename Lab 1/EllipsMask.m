function MImage = EllipsMask(FImage)
%EllipsMask Generate a mask for one eye and the complete face
%   Change pixel color for one eye and extract the face
%
%% Who has done it
%
% Author: Oscar Nord LiU-ID: oscno829
% Co-author: You can work in groups of max 2, this is the LiU-ID/name of
% the other member of the group
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
% Version: 1
% Date: today
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

%% create the output image (RGB!) which is a copy of the original image
% Use einstein.jpg as your FImage

[sr,sc] = size(FImage);
MImage = FImage;

%% Generate the coordinates of the grid points
 [C R] = meshgrid((1:sc),(1:sr));
% Remember the matlab convention regarding rows, columns, x and y coordinates. Feel free to use 
% [Y,X] = meshgrid((1:sx),(1:sy)) or whatever notation instead if you feel more comfortable with that notation

%% Pick three points that define the elliptical mask of the face
% Read more about ellipses at https://en.wikipedia.org/wiki/Ellipse
% Your solution must at least be able to solve the problem for the case 
% where the axes of the ellipse are parallel to the coordinate axes
%

disp('Select three (3) points in order of: origin -> y-axis -> x-axis')
%Display image and pick three points 
% Ellipse data, axis1 and axis2 are ellipse semi-axis and must be orthogonal
fh1 = imshow(MImage);

% Select points (3) in order of: origin -> y-axis -> x-axis
fpts = ginput(3);

% fpts in form of (x,y)
% Ellipse center point 
origin = fix(fpts(1,:));

%y-axis
yaxis = fix(fpts(2,:)); 

%x-axis
xaxis = fix(fpts(3,:));

%% Generate the elliptical mask and 
% set all points in MImage outside the mask to black 
% Radius of ellipse [y-axis, x-axis]^2
radius_sq = [xaxis(1), yaxis(2)].^ 2;  

%Create ellipse mask with input given by the user
fmask =  (radius_sq(2)*(R - origin(2)).^ 2 + radius_sq(1)*(C - origin(1)).^ 2 <= prod(radius_sq)); % this is the mask use C and R to generate it

% Create mask on image
MImage = bsxfun(@times, MImage, uint8(fmask));% here you modify the image using fmask

% Show image with mask
imshow(MImage)

%% Pick two points defining one eye, generate the eyemask, paint it red
disp('Select two (2) points in order of: radius on x-axis -> center')
fh1 = imshow(MImage);
epts = ginput(2);

%Center 
origin = fix(epts(2,:));

%axis
axis = fix(epts(1,:));

% Radius of ellipse [x-axis, y-axis]
radius = [axis(1), axis(2)]; 
%Create circular mask with input given by the user
emask = (radius(2) * (R - origin(2)).^ 2 + radius(1) * (C - origin(1)) .^ 2 >= prod(radius));% circular eye mask again, use C and R

%Set emask to an rgb image with pure red color
emask = cat(3, emask, emask, emask);
emask(:,:,1) = 1;

%Apply mask on image
MImage = bsxfun(@times, MImage, uint8(emask));% replace eye points with red pixels

%% Display result if you want
%
imshow(MImage);

end