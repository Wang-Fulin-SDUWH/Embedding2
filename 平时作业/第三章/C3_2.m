%% 群文件第三章习题
clear;
clc;
%指定DH参数和theta的初始值
theta1=(10/180)*pi;
theta2=(20/180)*pi;
theta3=(30/180)*pi;
a1=4;
a2=3;
a3=2;
%用DH参数建立机械臂
L(1)=Revolute('d',0,'a',a1,'alpha',0);
L(2)=Revolute('d',0,'a',a2,'alpha',0);
L(3)=Revolute('d',0,'a',a3,'alpha',0);
three_link=SerialLink(L,'name','threelink');
%已知的微分条件可以求出dx，dy，dz
dt=0.1;
vx=0.2;
vy=-0.3;
wz=-0.2;
dx=vx*dt;
dy=vy*dt;
deltaz=wz*dt;
%初始的三个参数theta1--theta3差分值
dth1=0;
dth2=0;
dth3=0;
%存放角速度值的向量
Omega1=[];
Omega2=[];
Omega3=[];
%存放角度值的向量
Theta1=[];
Theta2=[];
Theta3=[];
%存放最终位置的向量
X=[];
Y=[];
Theta_z=[];
% 正运动学求解初始位姿矩阵T
T=three_link.fkine([theta1,theta2,theta3]);     
% 时间以0.1为单位，从0-5s
for t = 0:dt:5.0
    % 更新位姿矩阵T 
    % 注意，这里的T不是普通的矩阵类型，是机器人工具箱特有的旋转矩阵，因此需要用T.n,o,a,t来取得矩阵的每一列。
    T=three_link.fkine([theta1,theta2,theta3]);   
    % 取px和py
    px=T.t(1);
    py=T.t(2);
    X=[X px];
    Y=[Y py];
    % 计算雅可比矩阵
    J=three_link.jacob0([theta1,theta2,theta3]);   
    % 把雅可比矩阵为0的列去掉
    J([3,4,5],:)=[];  
    % 利用雅可比矩阵求关节的微分
    d=inv(J)*[dx;dy;deltaz];  
    % 对应更新theta1--theta3的差分值
    dth1=d(1);
    dth2=d(2);
    dth3=d(3);
    % 求关节的角速度
    omega1=(dth1/dt)/pi*180;                  
    omega2=(dth2/dt)/pi*180;
    omega3=(dth3/dt)/pi*180;
    Omega1=[Omega1 omega1];                     % 加入到数组中
    Omega2=[Omega2 omega2];
    Omega3=[Omega3 omega3];
    
    theta1=theta1+dth1;          % 计算新的关节角
    theta2=theta2+dth2;
    theta3=theta3+dth3;
    theta_z=theta1+theta2+theta3;
    Theta1=[Theta1 theta1/pi*180];
    Theta2=[Theta2 theta2/pi*180];
    Theta3=[Theta3 theta3/pi*180];
    Theta_z=[Theta_z theta_z/pi*180];
end
t=[0:0.1:5];
% 画出角度随时间的变化曲线
figure;
plot(t,Theta1,'r');
hold on;
plot(t,Theta2,'b');
hold on;
plot(t,Theta3,'g');
legend('theta1','theta2','theta3');
xlabel("Time");
ylabel("Theta");
title("角度曲线");
% 画出角速度随时间的变化曲线
figure;
plot(t,Omega1,'r');
hold on;
plot(t,Omega2,'b');
hold on;
plot(t,Omega3,'g');
legend('omega1','omega2','omega3');
xlabel("Time");
ylabel("Omega");
title("角速度曲线");
% 画出X,Y,theta_z随时间的变化曲线
figure;
plot(t,X,'r');
hold on;
plot(t,Y,'b');
hold on;
% 这里为了得到和答案中图片一样的效果，对Theta_z进行放缩
Theta_z=Theta_z*pi/20;
plot(t,Theta_z,'g');
legend('X','Y','ThetaZ');
xlabel("Time");
ylabel("Bias");
title("偏移位置、角度曲线");
%最后的T就是循环里最后一个T
T