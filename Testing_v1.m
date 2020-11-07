clear all; close all; clc;

%This is for plotting of results for prototype version 1,
%this does NOT have any section data, only tag number, distance and RSSI

%change these parameters--------------------------------------------------%
load 'Test1.mat';   %import testing data to plot
                    %data [TagNo.    Distance     RSSI]                    
n = 5;              %number of tags                   
nT = 5;             %number of tests
testNum = 1;        %test reference number
TxP = 15;        %transmission power [db]
%-------------------------------------------------------------------------%

%other parameters
zone = [0, 37.5, 72.5, 107.5, 142.5];


%% Distance and RSSI estimation from gathered data
%estimating distance and RSSI from direct equations
est_RSSI = -(20*log10(Test1(:,2)) + TxP);
est_Distance = 10.^((Test1(:,3) + TxP)/-20);
%how far off where the estimations
RSSIdiff = est_RSSI - Test1(:,3);
Distancediff = est_Distance - Test1(:,2);

%plotting RSSI differences
figure()
plot(1:length(Test1(:,3)), Test1(:,3),'.','MarkerSize',25); hold on;
plot(1:length(est_RSSI), est_RSSI,'.','MarkerSize',25);
for i = 1:length(est_RSSI)
    plot([i i],[Test1(i,3) est_RSSI(i)],'r')
end
axis([0, length(est_RSSI)+1, min(Test1(:,3))-5, max(Test1(:,3))+15])
title('Actual vs. Estimated (RSSI)');
xlabel('Test No.');
ylabel('RSSI [dB]');
legend('Actual','Estimated');

%plotting distance differences
figure()
plot(1:length(Test1(:,2)), Test1(:,2),'.','MarkerSize',25); hold on;
plot(1:length(est_Distance), est_Distance,'.','MarkerSize',25);
for i = 1:length(est_Distance)
    plot([i i],[Test1(i,2) est_Distance(i)],'r')
end
axis([0, length(est_Distance)+1, min(Test1(:,2))-5, max(est_Distance)+40])
title('Actual vs. Estimated (distance)');
xlabel('Test No.');
ylabel('Distance [mm]');
legend('Actual','Estimated');

%% Plotting by test
figure()
titleinfo = ['Manual Testing - Test, Test no. = ', num2str(testNum )];
for i = 1:nT
    if i == 1
        plot(Test1(i:i*n,2),Test1(i:i*n,3),'.','MarkerSize',25); hold on;
    else
        plot(Test1((i-1)*n+1:i*n,2),Test1((i-1)*n+1:i*n,3),'.','MarkerSize',25)
    end
    legendinfo{i} = ['Test no. = ', num2str(i)];
    legend(legendinfo);
end
axis([min(Test1(:,2))-10, max(Test1(:,2))+10, min(Test1(:,3))-10, max(Test1(:,3))+10])
xlabel('Distance [cm]');
ylabel('RSSI [dB]');
title(titleinfo);

%% Plotting by distance
figure();
titleinfo = ['Manual Testing - Distance, Test no. = ', num2str(testNum )];
for i = 2:length(zone)
    idx = find(Test1(:,2) > zone(i-1) & Test1(:,2) < zone(i));
    plot(Test1(idx,2),Test1(idx,3),'.','MarkerSize',25); hold on;
    legendinfo{i-1} = ['Zone ', num2str(i-1)];
    legend(legendinfo);
end
axis([min(Test1(:,2))-10, max(Test1(:,2))+10, min(Test1(:,3))-10, max(Test1(:,3))+10])
xlabel('Distance [cm]');
ylabel('RSSI [dB]');
title(titleinfo);
