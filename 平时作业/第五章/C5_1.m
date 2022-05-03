%% 5.1 ��ֱ��
clc;
clear;
%������е��
L(1)=Revolute('d',138,'a',0,'alpha',-pi/2);
L(2)=Revolute('d',0,'a',135,'alpha',0);
L(3)=Revolute('d',0,'a',147,'alpha',0);
%�������
L(1).qlim = [-pi/2,pi/2];
L(2).qlim = [0,85*pi/180];
L(3).qlim = [-pi/2,10*pi/180];
%����������
rob=SerialLink(L,'name','rob');
%������ı任
T1=transl(200,120,40);
T2=transl(220,-150,220);
T=ctraj(T1,T2,30); %�����ٶȣ�����������ԽС�ٶ�Խ��
S=transl(T); 
%�����˶��켣
plot3(S(:,1),S(:,2),S(:,3));
grid on;
%���˶�ѧ���
q=rob.ikine(T,'mask',[1 1 1 0 0 0]);
rob.plot(q)