function [ Profile1, Profile2 ] = Vignette( Im1, Im2, norings )
%Vignette: Compare vignetting properties of two images
%   If Im1 and Im2 show the same object imaged under different conditions
%   then Profile1 and Profile2 describe the mean gray value as a function
%   of the radius
%
%% Who has done it
%
% Author: Same LiU-ID/name as in the Lisam submission
% Co-author: You can work in groups of max 2, this is the LiU-ID/name of
% the other member of the group
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

%% Input parameters
%
if nargin < 3
    norings = 50; %if norings is not spec set it to 50
end
    
%% Generate two square images cIm1 and cIm2 that have the same size
% Use the center of the images and if at least one of them is an RGB image 
% either convert to gray value or exit with an error message
%
[sr1, sc1, nc]  = size(Im1);
[sr2, sc2, nc2] = size(Im2);

if sr1 ~= sc1

end

if sr2

end

if Im1 and Im2 are not of the same size

end
%     
cIm1 = 
cIm2 =

Profile1 = zeros(norings,1);
Profile2 = Profile1;

%% Now you have two gray value images of the size (square) size and you 
%   generate grid with the help of an axis vector ax that defines your
%   rings
%

ax = ( : ) 
% or read the documentation of linspace
ax = linspace 
%...

[C R] = meshgrid %Euclidean mesh
[~,Rho] = cart2pol %Polar coordinates comment on the ~ used

%% Do the actual calculations
for ringno = 1:norings
    RMask = % Generate a mask describing the ring number ringno
    nopixels = % Compute the number of pixes in RMask
    pixsum = % Compute the sum over all pixel values in RMask in Im1
    Profile1(ringno) = % ../.. Mean gray value of pixels i RMask
        % ... and now you do it for the second images
    Profile2
end

%% Finally the normalization to max value one 
%
Profile1 = 
Profile2 = 

%% Extra question: How can you find out if Im1 is better than Im2?

end

