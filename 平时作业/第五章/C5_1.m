%% 5.1 画直线
clc;
clear;
%构建机械臂
L(1)=Revolute('d',138,'a',0,'alpha',-pi/2);
L(2)=Revolute('d',0,'a',135,'alpha',0);
L(3)=Revolute('d',0,'a',147,'alpha',0);
%添加限制
L(1).qlim = [-pi/2,pi/2];
L(2).qlim = [0,85*pi/180];
L(3).qlim = [-pi/2,10*pi/180];
%建立机器人
rob=SerialLink(L,'name','rob');
%给出点的变换
T1=transl(200,120,40);
T2=transl(220,-150,220);
T=ctraj(T1,T2,30); %设置速度，第三个参数越小速度越快
S=transl(T); 
%画出运动轨迹
plot3(S(:,1),S(:,2),S(:,3));
grid on;
%逆运动学求解
q=rob.ikine(T,'mask',[1 1 1 0 0 0]);
rob.plot(q)