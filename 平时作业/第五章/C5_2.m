%% Ⱥ�ļ������µڶ���ϰ��??��Բ
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
%����Բ��
tile = (0:0.5:100)'; 
xyz = [175 0 5];
radius = 50;
theta = ( tile/tile(end) )*2*pi;
points = (xyz + radius*[cos(theta) sin(theta) zeros(size(theta))])';  
plot3(points(1,:),points(2,:),points(3,:),'r');
%������������ʾ
axis equal
set(gca,'ZLim',[-200,200])
T = transl(points');
%���˶�ѧ���
q = rob.ikine(T,'mask',[1 1 1 0 0 0]);
hold on;
rob.plot(q,'tilesize',300);