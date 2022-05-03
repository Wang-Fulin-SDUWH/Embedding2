%% 群文件第四章第二道习题
a1=4;
a2=3;
a3=2;
m1=20;
m2=15;
m3=10;
%构建连杆
L(1)=Revolute('d',0,'a',a1,'alpha',0);
L(2)=Revolute('d',0,'a',a2,'alpha',0);
L(3)=Revolute('d',0,'a',a3,'alpha',0);
%设置质量
L(1).m=m1;
L(2).m=m2;
L(3).m=m3;
%设置质心坐标
L(1).r=[-2 0 0];
L(2).r=[-1.5 0 0];
L(3).r=[-1 0 0];
%设置惯性张量
L(1).I=[0 0 0 0 0 0];
L(2).I=[0 0 0 0 0 0];
L(3).I=[0 0 0 0 0 0];
%标准D-H法
L(1).mdh=0;
L(2).mdh=0;
L(3).mdh=0;
three_link=SerialLink(L,'name','threelink');
q=[pi/18 pi/9 pi/6];
qd=[1 2 3];
qdd=[0.5 1 1.5];
%rne求解逆动力学
TT=three_link.rne(q,qd,qdd,[0 9.8 0])