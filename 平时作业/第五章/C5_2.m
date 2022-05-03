%% 群文件第五章第二道习题??画圆
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
%构建圆形
tile = (0:0.5:100)'; 
xyz = [175 0 5];
radius = 50;
theta = ( tile/tile(end) )*2*pi;
points = (xyz + radius*[cos(theta) sin(theta) zeros(size(theta))])';  
plot3(points(1,:),points(2,:),points(3,:),'r');
%设置坐标轴显示
axis equal
set(gca,'ZLim',[-200,200])
T = transl(points');
%逆运动学求解
q = rob.ikine(T,'mask',[1 1 1 0 0 0]);
hold on;
rob.plot(q,'tilesize',300);