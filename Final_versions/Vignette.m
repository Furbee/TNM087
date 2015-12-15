function [ Profile1, Profile2 ] = Vignette( Im1, Im2, norings )
%Vignette: Compare vignetting properties of two images
%   If Im1 and Im2 show the same object imaged under different conditions
%   then Profile1 and Profile2 describe the mean gray value as a function
%   of the radius
%
%% Who has done it
%
% Author: oscno829 
% Co-author: vikhe927
%
%% Syntax of the function
%
% Input arguments:  Im1, Im2 are input images, you can assume that they are
%                       gray value images (of type uint8, uint16 or double)
%                   norings is optional and describes the number of
%                       concentric rings to use. The default is to use 50 rings
% Output arguments: Profile1 and Profile2 are vectors with the mean gray
%                       values in each ring. The final results are normed
%                       so that the maximum values in Profile1 and Profile2
%                       are equal to one
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2015-12-14
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

%% Input parameters
%
if nargin < 3
    norings = 50; %if norings is not spec set it to 50
end

%% Generate two square images cIm1 and cIm2 that have the same size
% Use the center of the images and if at least one of them is an RGB image
% either convert to gray value or exit with an error message
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          DECLARATIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sr1, sc1, nc]  = size(Im1);
[sr2, sc2, nc2] = size(Im2);

cIm1 = round( [sr1/2, sc1/2] );
cIm2 = round( [sr2/2, sc2/2] );

cropShift1 = abs( cIm1(1) - cIm1(2) );
cropShift2 = abs( cIm2(1) - cIm2(2) );

bool = 0;

varList = {'sc1','sr1','sc2','sr2', 'nc', 'nc2', 'cIm1', ... 
           'cIm2', 'cropShift1', 'cropShift2', 'bool'};
% No need to do this, but we tried it to see how it worked.
%Used to clear variables later.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          SHOW PICTURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imshow(Im1);
figure;
imshow(Im2);

%%

%Check if RGB, if true convert to RGB
if nc > 1
    Im1 = rgb2gray(Im1);
end
if nc2 > 1
    Im2 = rgb2gray(Im2);
end

%Check if square, if not crop around centerpoint
if sr1 ~= sc1
    if sr1 > sc1
        Im1 = Im1( cropShift1 : (cropShift1 + sc1-1) , :);
        
    elseif sc1 > sr1
        Im1 = Im1( : , cropShift1 : (cropShift1 + sr1-1) );
        
    end
end

if sr2 ~= sc2
    if sr2 > sc2
        Im2 = Im2( cropShift2 : (cropShift2 + sc2-1) , : );
        
    elseif sc2 > sr2
        Im2 = Im2( : , cropShift2 : (cropShift2 + sr2-1) );
        
        [sr2 sc2] = size(Im2);          %reset sr2 & sc2
        cIm2 = round( [sr2/2, sc2/2] ); %reset centerpoint
    end
end

%Check if Im1 & Im2 are same size, if not: resize one.
bool = isequal(size(Im1),size(Im2)); %if equal bool=1

if bool ~= 1
    Im2 = imresize(Im2, size(Im1));
end


%Initiate Profile1 & Profile2
Profile1 = zeros(norings,1);
Profile2 = Profile1;

%convert images to doubles
Im1 = im2double(Im1);
Im2 = im2double(Im2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          SHOW PICTURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imshow(Im1);
figure;
imshow(Im2);

%% Now you have two gray value images of the size (square) size and you
%   generate grid with the help of an axis vector ax that defines your
%   rings
%

clear(varList{:});  %Clear variables used to test and crop the picture, no need for them from here on
                    %Could've been cleared earlier but for tutors
                    %convenience they were not.


%ax = ( : )
% or read the documentation of linspace
ax = linspace(-1, 1, length(Im1));
%...

[C R] = meshgrid( ax, ax ); %Euclidean mesh
[~,Rho] = cart2pol(C, R); %Polar coordinates comment on the ~ used
%Since we're doing full laps (2pi) we don't need the angle, which is why it
%is set to ~
Rho = (Rho * (norings-1));

%% Do the actual calculations
for ringno = 1:norings
    RMask = (round(Rho) == ringno);
    nopixels = sum(sum(RMask)); % Compute the number of pixes in RMask
    
    %Profile1 summation
    pixsum = sum(Im1(RMask)); % Compute the sum over all pixel values in RMask in Im1
    Profile1(ringno) = pixsum/nopixels; % Mean gray value of pixels i RMask
    % ... and now you do it for the second images
    %Profile2 summation
    pixsum2 = sum(Im2(RMask));
    Profile2(ringno) = pixsum2/nopixels;
end

%% Finally the normalization to max value one
%
Profile1 = Profile1/max(Profile1)
Profile2 = Profile2/max(Profile2)

%% Extra question: How can you find out if Im1 is better than Im2?

end

