function MImage = EllipsMask(FImage)
%EllipsMask Generate a mask for one eye and the complete face
%   Change pixel color for one eye and extract the face
%
%% Who has done it
%
% Author: Same LiU-ID/name as in the Lisam submission
% Co-author: You can work in groups of max 2, this is the LiU-ID/name of
% the other member of the group
% Oscar Nord oscno829
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
impath = '/Users/Oscar/Documents/TNM087/Images/einstein.jpg';
FImage = imread(impath);
[sr,sc] = size(FImage);
MImage = 

%% Generate the coordinates of the grid points
 [C R] = meshgrid((1:sc),(1:sr));
% Remember the matlab convention regarding rows, columns, x and y coordinates. Feel free to use 
% [Y,X] = meshgrid((1:sx),(1:sy)) or whatever notation instead if you feel more comfortable with that notation



%% Pick three points that define the elliptical mask of the face
% Read more about ellipses at https://en.wikipedia.org/wiki/Ellipse
% Your solution must at least be able to solve the problem for the case 
% where the axes of the ellipse are parallel to the coordinate axes
%

%Display image and pick three points 
% Ellipse data, axis1 and axis2 are ellipse semi-axis and must be orthogonal
fh1 = imshow(FImage);
fpts = ginput(3);

%Minor axes
axis1 = fpts(3,:)/2;

%Center 
center = fpts(2,:)/2;

%Major axes
axis2 = fpts(1,:)/2;



P = [axis1 axis2];
H = P*P';


% TODO fix size of R and C
DX = R(:)-center(1);
DY = C(:)-center(2);
D = [DX DY] * sqrtm(inv(H));

Z = sum(D.^2,2);
Z = reshape(Z, size(R));
c = contourc(Z,1+[0 0]);

xe = round(c(1,2:end));
ye = round(c(2,2:end));

Z = zeros(size(Z));

% you should manage overflowed coordinates here
Z(sub2ind(size(Z),ye,xe)) = 1;

% Check
figure
imagesc(Z)
%imshow(FImage)
hold on
colormap(gray)
plot(center(1),center(2),'wo');
plot(center(1)+[0 axis1(1)], center(2)+[0 axis1(2)], 'w')
plot(center(1)+[0 axis2(1)], center(2)+[0 axis2(2)], 'w')
figure
mesh(Z)



%% Generate the elliptical mask and 
% set all points in MImage outside the mask to black 
...
fmask =  % this is the mask use C and R to generate it
MImage = % here you modify the image using fmask

%% Pick two points defining one eye, generate the eyemask, paint it red

epts = ginput(2);
emask = % circular eye mask again, use C and R
MImage = % replace eye points with red pixels


%% Display result if you want
%
imshow(MImage);

end


%%

% https://www.mathworks.com/matlabcentral/newsreader/view_thread/327316

%P = [axis1 axis2];
%H = P*P';
% DX = R(:)-center(1);
% DY = C(:)-center(2);
% D = [DX DY]*sqrtm(inv(H));
% Z = sum(D.^2,2);
% Z = reshape(Z, size(R));
% c = contourc(Z,1+[0 0]);
% xe = round(c(1,2:end));
% ye = round(c(2,2:end));
% Z = zeros(size(Z));
% % you should manage overflowed coordinates here
% Z(sub2ind(size(Z),ye,xe)) = 1;
% 
% % Check
% figure
% imagesc(Z)
% hold on
% plot(center(1),center(2),'wo');
% plot(center(1)+[0 axis1(1)], center(2)+[0 axis1(2)], 'w')
% plot(center(1)+[0 axis2(1)], center(2)+[0 axis2(2)], 'w')
%axis equal
