clc,clear,close all;
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end;
s=serial('COM4');
set(s,'BaudRate',250000,'DataBits',8,'StopBits',1,'Timeout',1500,'InputBufferSize',130,'OutputBufferSize',2,'Terminator','CR');
fopen(s);

figure(1);
hold on;
t=0;
gyrox =0;
gyroy =0;
gyroz =0;
gyrox_tmp = 0;
gyroy_tmp = 0;
gyroz_tmp = 0;
Time = 100;
while(t<=Time)
out=fgets(s)
[a1, a2] = strtok(out,'|');
[a3, a4] = strtok(a2,'|');
a5 = strtok(a4,'|');
a1=str2num(a1);
a3=str2num(a3);
a5=str2num(a5);
%    gyrox = gyrox + ((a1*0.07)*0.01);
%    gyroy = gyroy + ((a3*0.07)*0.01);
%    gyroz = gyroz + ((a5*0.07)*0.01);
gyrox = (a1*0.07)+0.2592;
gyroy = (a3*0.07)+0.8275;
gyroz = (a5*0.07)-1.1976;
plot([t-1 t], [gyrox_tmp gyrox],'b',[t-1 t], [gyroy_tmp gyroy],'r',[t-1 t], [gyroz_tmp gyroz],'g');
grid on;
title('ÃÐÀÔÈÊ');
drawnow;
axis([0 200 -2 2]);
if t==0
sk_x = gyrox; 
sk_y = gyroy; 
sk_z = gyroz;
else
sk_x = [sk_x gyrox];
sk_y = [sk_y gyroy];  
sk_z = [sk_z gyroz];  
end;

if t==Time
sred_x = mean(sk_x)
sred_y = mean(sk_y)
sred_z = mean(sk_z)
end;
t=t+1;
gyrox_tmp = gyrox;
gyroy_tmp = gyroy;
gyroz_tmp = gyroz;
end;
fclose(s);
delete(s);
clear s;