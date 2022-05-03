%% 第四章--群文件第一道习题
clear;
clc;
%输入已知条件，由密度*体积计算质量
L1=1;
L2=0.5;
kuan=0.05;
hou=0.05;
V1=kuan*hou*L1;
m1=V1*7806;
V2=kuan*hou*L2;
m2=V2*7806;
%输入DH表参数和theta的初始值，构建机械臂
theta1=(10/180)*pi;
theta2=(90/180)*pi;
L(1)=Revolute('d',0,'a',L1,'alpha',0);
L(2)=Revolute('d',0,'a',L2,'alpha',0);
L(1).m=m1;
L(2).m=m2;
L(1).r=[-L1/2 0 0];
L(2).r=[-L2/2 0 0];
%惯性张量的计算过程在本习题专属的说明文档中，请您查阅！
L(1).I=[0.081 1.630 1.630 0 0 0];
L(2).I=[0.040 0.815 0.815 0 0 0];
two_link=SerialLink(L,'name','twolink');
%计算dx,dy
dt=0.01;
vx=0;
vy=0.5;
%速度=距离微分
dx=vx*dt;
dy=vy*dt;
%初始化问题中变量的数组（首字母为大写均代表数组）
Omega1=[];
Omega2=[];
Theta1=[];
Theta2=[];
Acc1=[];
Acc2=[];
X=[];
Y=[];
Theta_z=[];
T1=[];
T2=[];
%该问题中只有两个旋转关节，因此只有两个参数theta1和theta2，为此后面雅可比矩阵的后四列都可以去掉。
dtheta1=0;
dtheta2=0;
% 正运动学求出位姿矩阵T
T=two_link.fkine([theta1,theta2]);     
for t = 0:dt:1    
    % 更新位姿矩阵T,px,py同第三章习题注释
    T=two_link.fkine([theta1,theta2]);                     
    px=T.t(1);
    py=T.t(2);
    X=[X px];
    Y=[Y py];
    % 求解雅可比矩阵
    J=two_link.jacob0([theta1,theta2]);    
    %只有两个参数，去掉雅可比矩阵后四列。
    J([3,4,5,6],:)=[];             
    d=inv(J)*[dx;dy]; 
    %根据关节微分求解角速度
    dtheta1=d(1);
    dtheta2=d(2);
    omega1=(dtheta1/dt);        
    omega2=(dtheta2/dt);
    if length(Omega1)==0
        acc1=omega1/dt;
        acc2=omega2/dt;
    else
        acc1=((omega1-Omega1(end))/dt);                       
        acc2=((omega2-Omega2(end))/dt);
    end
    %添加新元素
    Omega1=[Omega1;omega1];                     
    Omega2=[Omega2;omega2];
    Acc1=[Acc1;acc1];
    Acc2=[Acc2;acc2];
    %更新关节角
    theta1=theta1+dtheta1;          
    theta2=theta2+dtheta2;
    theta_z=theta1+theta2;
    Theta1=[Theta1;theta1*180/pi];
    Theta2=[Theta2;theta2*180/pi];
    Theta_z=[Theta_z;theta_z*180/pi];
end
t=[0:0.01:1];
% 把相关变量统一到一个坐标系中
Theta_z=Theta_z/180*pi-0.65;
% 画出角度随时间的变化曲线
figure;
plot(t,Theta1,'r');
hold on;
plot(t,Theta2,'b');
xlabel("Time");
ylabel("Theta");
title("角度曲线");
legend('Theta1','Theta2');
% 画出角速度随时间的变化曲线
figure;
plot(t,Omega1,'r');
hold on;
plot(t,Omega2,'b');
xlabel("Time");
ylabel("Omega");
title("角速度曲线");
legend('Omega1','Omega2');
% 画出角加速度随时间的变化曲线
figure;
plot(t,Acc1,'r');
hold on;
plot(t,Acc2,'b');
xlabel("Time");
ylabel("Acc");
title("角加速度曲线");
legend('Acc1','Acc2');
% 画出X,Y,theta_z随时间的变化曲线
figure;
plot(t,X,'r');
hold on;
plot(t,Y,'b');
hold on;
plot(t,Theta_z,'g');
xlabel("Time");
ylabel("Bias");
title("偏移位置、角度曲线");
legend('X','Y','Theta_z');
% 画出力矩随时间的变化曲线（力矩由rne逆动力学求解得到）
figure;
Theta1=Theta1/180*pi;
Theta2=Theta2/180*pi;
%记得添加重力加速度！（也可以在一开始用SerialLink的gravity属性）
T_all=two_link.rne([Omega1,Omega2],[Theta1,Theta2],[Acc1,Acc2],[0 9.8 0]);
plot(t,T_all(:,1),'r');
hold on;
plot(t,-T_all(:,2),'b');
xlabel("时间");
ylabel("力矩");
title("力矩曲线");
legend('T1','T2');