clc,clear,close all;
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end;
s=serial('COM3');
set(s,'BaudRate',9600,'DataBits',8,'StopBits',1,'Timeout',1500,'InputBufferSize',130,'OutputBufferSize',2,'Terminator','CR');
fopen(s);

figure(1);
hold on;
t=0;
a1_tmp = 0;
a3_tmp = 0;
a5_tmp = 0;
while(1)
   out=fgets(s)
%    if (out=='')
%        exit;
%    end;
   [a1, a2] = strtok(out,'|');
   [a3, a4] = strtok(a2,'|');
   a5 = strtok(a4,'|');
   a1=str2num(a1);
   a3=str2num(a3);
   a5=str2num(a5);
   class(a1);
   class(a3);
   class(a5);
   %subplot(111);
   t=t+1;
   plot([t-1 t], [a1_tmp a1],'b',[t-1 t], [a3_tmp a3],'r',[t-1 t], [a5_tmp a5],'g');
   %plot(t, a1,'b');
   grid on;
   title('√–¿‘» ');
   %%hold on;
   drawnow;
   %axis([t-50 t -256 256]);
  % axis([0 100 -2 350]);
  axis([0 22 -1 257]);
   a1_tmp = a1;
   a3_tmp = a3;
   a5_tmp = a5;
end;
fclose(s);
delete(s);
clear s;