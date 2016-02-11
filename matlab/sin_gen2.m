clc,clear,close all;
n=0:0.003030303:1;
size(n)
A = 127;
PWM_DUTY=127;
y=A+PWM_DUTY *sin(2*pi*n);
y1=round(y);
fprintf('%i, ', y1)
figure(1);
plot(n,y,'b','LineWidth',2);
