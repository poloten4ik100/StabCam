clc,clear,close all;
hold on;
t=1;
g=3;
Time = 350;
load('data/sin.mat');
data_1 = data_angle
sdvig = length(data_1) / 3;
data_2 = circshift(data_1, [0,sdvig])
hold on;
%plot([0 350],[90 90],'--','color','m','LineWidth',2);
plot([0:1:20],data_1,'b','LineWidth',2);
plot([0:1:20],data_2,'g','LineWidth',2);
%plot(0:count*0.01:3.5-count*0.01,(1)*data_2+90,'ro','LineWidth',1);
%plot(0:count*0.01:3.5-count*0.01,(1)*data_2+90,'r-','LineWidth',1);
grid on;
drawnow;
%axis([0 22 0 256]);
axis([0 22 -1 257]);
title('����');
xlabel('����, c.');
ylabel('����, ����.'); 
%legend('\vartheta ���������','\vartheta ������. (K�. = 0.9, ��. = 0.15, �� = 0.28)','\vartheta � ������', 4);  