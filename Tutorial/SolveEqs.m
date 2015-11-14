%% 
% Generate equation b = AX
npts = 100;
A = [1,2]
x = rand(2,npts);
b = A*x;

%% solutions with pinv and \
bs = A\b;
iA = pinv(A);
iAb = iA*b;

%% The differences between solution and ground truth
diffbs = (x-bs);
diffIab = (x-iAb);

%%
bsnorm2 = diffbs(1,:).^2+diffbs(2,:).^2;
Iabnorm2 = diffIab(1,:).^2+diffIab(2,:).^2;

%% mean and plot differences
disp([mean(bsnorm2),mean(Iabnorm2)])
figure
plot((1:npts),bsnorm2,'r.',(1:npts),Iabnorm2,'ko')
