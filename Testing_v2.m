close all; clc;

%This includes section data plotting, by zoning the tags the distance data
%becomes nearly redundant. We now only care if the tag is in the correct
%section as we are no longer estimating distance.

TestData = xlsread('TestingManual.xlsx', 'Test3');
testNum = 2; 

zone = [1, 2, 3, 4];
zoneDist = [0, 37.5, 72.5, 107.5, 142.5];

%% Plotting by zone
figure();
plot(TestData(1,3),TestData(1,4),'.','MarkerSize',50); hold on;
plot(TestData(2,3),TestData(2,4),'.','MarkerSize',50);
plot(TestData(3,3),TestData(3,4),'.','MarkerSize',50);
plot(TestData(4,3),TestData(4,4),'.','MarkerSize',50);

yline(TestData(1,4),'--','Zone 1','LineWidth',2);
yline(TestData(2,4),'--','Zone 2','LineWidth',2);
yline(TestData(3,4),'--','Zone 3','LineWidth',2);
yline(TestData(4,4),'--','Zone 4','LineWidth',2);

legendinfo = {'Reference Tag 1', 'Reference Tag 2','Reference Tag 3', 'Reference Tag 4', 'Zone 1', 'Zone 2', 'Zone 3', 'Zone 4'};

%titleinfo = ['Manual Testing - Zone, Test no. = ', num2str(testNum)];
titleinfo = 'Zone data, Distance vs. RSSI';
for i = 1:length(zone)
    idx = find(TestData(:,6) == zone(i));
    idx(1) = []; %do not incldue reference tag data
    plot(TestData(idx,3),TestData(idx,4),'.','MarkerSize',25);
    legendinfo{i+8} = ['Zone ', num2str(i)];
    legend(legendinfo);
end
axis([min(TestData(:,3))-10, max(TestData(:,3))+10, min(TestData(:,4))-10, max(TestData(:,4))+10])
xlabel('Distance [cm]');
ylabel('RSSI [dB]');
title(titleinfo);