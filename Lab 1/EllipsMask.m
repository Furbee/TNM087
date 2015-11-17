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

%Center 
center = fpts(2,:);

%Minor axes
axis1 = fpts(3,:)-center;

%Major axes
axis2 = fpts(1,:)-center;


% % Create a logical image of an ellipse with specified
% % semi-major and semi-minor axes, center, and image size.
% % First create the image.
% imageSizeX = 640;
% imageSizeY = 480;
% [columnsInImage rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% % Next create the ellipse in the image.
% centerX = 320;
% centerY = 240;
% radiusX = 250;
% radiusY = 150;
% ellipsePixels = (rowsInImage - centerY).^2 ./ radiusY^2 ...
%     + (columnsInImage - centerX).^2 ./ radiusX^2 <= 1;
% % circlePixels is a 2D "logical" array.
% % Now, display it.
% image(ellipsePixels) ;
% colormap([0 0 0; 1 1 1]);
% title('Binary image of a ellipse', 'FontSize', 20);



% P = [axis1 axis2];
% H = P*P';
% 
% 
% % TODO fix size of R and C
% DX = R(:)-center(1);
% DY = C(:)-center(2);
% D = [DX DY] * sqrtm(inv(H));
% 
% Z = sum(D.^2,2);
% Z = reshape(Z, size(R));
% c = contourc(Z,1+[0 0]);
% 
% xe = round(c(1,2:end));
% ye = round(c(2,2:end));
% 
% Z = zeros(size(Z));
% 
% % you should manage overflowed coordinates here
% Z(sub2ind(size(Z),ye,xe)) = 1;
% 
% % Check
% figure
% imagesc(FImage)
% %imshow(FImage)
% hold on
% 
% plot(center(1),center(2),'wo');
% plot(center(1)+[0 axis1(1)], center(2)+[0 axis1(2)], 'w')
% plot(center(1)+[0 axis2(1)], center(2)+[0 axis2(2)], 'w')
% figure
% mesh(Z)


% Create an ellipse shaped mask
% Ellipse center (y, x)
c = fix(center);
%# Ellipse radii squared (y-axis, x-axis)
r_sq = [abs(axis2(2)), abs(axis1(1))] .^ 2;  






%[X, Y] = meshgrid(1:size(A, 2), 1:size(A, 1));

%ellipse_mask = (r_sq(2) * (C - c(2)) .^ 2 + r_sq(1) * (R - c(1)) .^ 2 <= prod(r_sq));

%# Apply the mask to the image
%A_cropp = bsxfun(@times, A, uint8(ellipse_mask));


%imshow(A_cropp)

%% Generate the elliptical mask and 
% set all points in MImage outside the mask to black 
fmask =  (r_sq(2) * (C - c(2)) .^ 2 + r_sq(1) * (R - c(1)) .^ 2 <= prod(r_sq));% this is the mask use C and R to generate it
MImage = bsxfun(@times, FImage, uint8(fmask));% here you modify the image using fmask


imshow(MImage)
%% Pick two points defining one eye, generate the eyemask, paint it red
fh1 = imshow(FImage);

epts = ginput(2);

%Center 
center = fpts(2,:);

%axis
axis = fpts(1,:);

c = fix(center);   %# Ellipse center point (y, x)
r_sq = [axis(2), axis(1)] .^ 2;  %# Ellipse radii squared (y-axis, x-axis)

emask = (r_sq(2) * (C - c(2)) .^ 2 + r_sq(1) * (R - c(1)) .^ 2 <= prod(r_sq));% circular eye mask again, use C and R
MImage = bsxfun(@times, A, uint8(emask));% replace eye points with red pixels


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
