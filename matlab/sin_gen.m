clc,clear,close all;
PWM_DUTY = 127;
theta = 0;
A = 127;
t=0;
tmp=0;
output_tmp =0;
output2_tmp =0;
output3_tmp =0;
figure(1);
hold on;
data_angle = 127;
while t<23
output = A +PWM_DUTY * sin(theta);
output2 = A +PWM_DUTY * sin(theta+ 2 / 3 * pi);
output3 = A +PWM_DUTY * sin(theta+ 2 * 2 / 3 * pi);
if ((t<21) & (t>0))
data_angle = [data_angle round(output)];
end;
plot(t,127,'black',[t-1 t],[output_tmp output],'r',[t-1 t],[output2_tmp output2],'b',[t-1 t],[output3_tmp output3],'black');
axis([0 22 -1 257]);
grid on;
title('ÃÐÀÔÈÊ');
hold on;
drawnow;
% if tmp>5
 theta=theta+1;
% tmp=0;
% else
%     tmp=tmp+1;
% end;
t=t+1;
output_tmp = output;
output2_tmp = output2;
output3_tmp = output3;
pause(0.1);
end;
