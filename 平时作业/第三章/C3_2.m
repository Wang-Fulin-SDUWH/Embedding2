%% Ⱥ�ļ�������ϰ��
clear;
clc;
%ָ��DH������theta�ĳ�ʼֵ
theta1=(10/180)*pi;
theta2=(20/180)*pi;
theta3=(30/180)*pi;
a1=4;
a2=3;
a3=2;
%��DH����������е��
L(1)=Revolute('d',0,'a',a1,'alpha',0);
L(2)=Revolute('d',0,'a',a2,'alpha',0);
L(3)=Revolute('d',0,'a',a3,'alpha',0);
three_link=SerialLink(L,'name','threelink');
%��֪��΢�������������dx��dy��dz
dt=0.1;
vx=0.2;
vy=-0.3;
wz=-0.2;
dx=vx*dt;
dy=vy*dt;
deltaz=wz*dt;
%��ʼ����������theta1--theta3���ֵ
dth1=0;
dth2=0;
dth3=0;
%��Ž��ٶ�ֵ������
Omega1=[];
Omega2=[];
Omega3=[];
%��ŽǶ�ֵ������
Theta1=[];
Theta2=[];
Theta3=[];
%�������λ�õ�����
X=[];
Y=[];
Theta_z=[];
% ���˶�ѧ����ʼλ�˾���T
T=three_link.fkine([theta1,theta2,theta3]);     
% ʱ����0.1Ϊ��λ����0-5s
for t = 0:dt:5.0
    % ����λ�˾���T 
    % ע�⣬�����T������ͨ�ľ������ͣ��ǻ����˹��������е���ת���������Ҫ��T.n,o,a,t��ȡ�þ����ÿһ�С�
    T=three_link.fkine([theta1,theta2,theta3]);   
    % ȡpx��py
    px=T.t(1);
    py=T.t(2);
    X=[X px];
    Y=[Y py];
    % �����ſɱȾ���
    J=three_link.jacob0([theta1,theta2,theta3]);   
    % ���ſɱȾ���Ϊ0����ȥ��
    J([3,4,5],:)=[];  
    % �����ſɱȾ�����ؽڵ�΢��
    d=inv(J)*[dx;dy;deltaz];  
    % ��Ӧ����theta1--theta3�Ĳ��ֵ
    dth1=d(1);
    dth2=d(2);
    dth3=d(3);
    % ��ؽڵĽ��ٶ�
    omega1=(dth1/dt)/pi*180;                  
    omega2=(dth2/dt)/pi*180;
    omega3=(dth3/dt)/pi*180;
    Omega1=[Omega1 omega1];                     % ���뵽������
    Omega2=[Omega2 omega2];
    Omega3=[Omega3 omega3];
    
    theta1=theta1+dth1;          % �����µĹؽڽ�
    theta2=theta2+dth2;
    theta3=theta3+dth3;
    theta_z=theta1+theta2+theta3;
    Theta1=[Theta1 theta1/pi*180];
    Theta2=[Theta2 theta2/pi*180];
    Theta3=[Theta3 theta3/pi*180];
    Theta_z=[Theta_z theta_z/pi*180];
end
t=[0:0.1:5];
% �����Ƕ���ʱ��ı仯����
figure;
plot(t,Theta1,'r');
hold on;
plot(t,Theta2,'b');
hold on;
plot(t,Theta3,'g');
legend('theta1','theta2','theta3');
xlabel("Time");
ylabel("Theta");
title("�Ƕ�����");
% �������ٶ���ʱ��ı仯����
figure;
plot(t,Omega1,'r');
hold on;
plot(t,Omega2,'b');
hold on;
plot(t,Omega3,'g');
legend('omega1','omega2','omega3');
xlabel("Time");
ylabel("Omega");
title("���ٶ�����");
% ����X,Y,theta_z��ʱ��ı仯����
figure;
plot(t,X,'r');
hold on;
plot(t,Y,'b');
hold on;
% ����Ϊ�˵õ��ʹ���ͼƬһ����Ч������Theta_z���з���
Theta_z=Theta_z*pi/20;
plot(t,Theta_z,'g');
legend('X','Y','ThetaZ');
xlabel("Time");
ylabel("Bias");
title("ƫ��λ�á��Ƕ�����");
%����T����ѭ�������һ��T
T