%% Demo simple distance map
%% Init

clear all
close all

nopts = 20; %length of vector

%% Create object and init dm

vector = zeros(1,nopts);
vector([(1:5),(15:17)])=nopts;
distmap = zeros(nopts,nopts);
distmap(1,:) = vector;

%% Distance map calculation
for k = 1:nopts-1
    for l = 2:nopts-1
        distmap(k+1,l) = min([distmap(k,l-1)+1,distmap(k,l),distmap(k,l+1)+1]);
    end
    distmap(k+1,1) = min([distmap(k,1),distmap(k,2)+1]);
    distmap(k+1,end) = min([distmap(k,end-1)+1,distmap(k,end)]);
end

%% Plot result

figure

plot(distmap(1:6,:)')
legend('1','2','3','4','5','6')
title('Distance Map Calculation')
hold on
plot(distmap(end,:)','kx')