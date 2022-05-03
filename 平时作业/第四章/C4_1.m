%% ������--Ⱥ�ļ���һ��ϰ��
clear;
clc;
%������֪���������ܶ�*�����������
L1=1;
L2=0.5;
kuan=0.05;
hou=0.05;
V1=kuan*hou*L1;
m1=V1*7806;
V2=kuan*hou*L2;
m2=V2*7806;
%����DH�������theta�ĳ�ʼֵ��������е��
theta1=(10/180)*pi;
theta2=(90/180)*pi;
L(1)=Revolute('d',0,'a',L1,'alpha',0);
L(2)=Revolute('d',0,'a',L2,'alpha',0);
L(1).m=m1;
L(2).m=m2;
L(1).r=[-L1/2 0 0];
L(2).r=[-L2/2 0 0];
%���������ļ�������ڱ�ϰ��ר����˵���ĵ��У��������ģ�
L(1).I=[0.081 1.630 1.630 0 0 0];
L(2).I=[0.040 0.815 0.815 0 0 0];
two_link=SerialLink(L,'name','twolink');
%����dx,dy
dt=0.01;
vx=0;
vy=0.5;
%�ٶ�=����΢��
dx=vx*dt;
dy=vy*dt;
%��ʼ�������б��������飨����ĸΪ��д���������飩
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
%��������ֻ��������ת�ؽڣ����ֻ����������theta1��theta2��Ϊ�˺����ſɱȾ���ĺ����ж�����ȥ����
dtheta1=0;
dtheta2=0;
% ���˶�ѧ���λ�˾���T
T=two_link.fkine([theta1,theta2]);     
for t = 0:dt:1    
    % ����λ�˾���T,px,pyͬ������ϰ��ע��
    T=two_link.fkine([theta1,theta2]);                     
    px=T.t(1);
    py=T.t(2);
    X=[X px];
    Y=[Y py];
    % ����ſɱȾ���
    J=two_link.jacob0([theta1,theta2]);    
    %ֻ������������ȥ���ſɱȾ�������С�
    J([3,4,5,6],:)=[];             
    d=inv(J)*[dx;dy]; 
    %���ݹؽ�΢�������ٶ�
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
    %�����Ԫ��
    Omega1=[Omega1;omega1];                     
    Omega2=[Omega2;omega2];
    Acc1=[Acc1;acc1];
    Acc2=[Acc2;acc2];
    %���¹ؽڽ�
    theta1=theta1+dtheta1;          
    theta2=theta2+dtheta2;
    theta_z=theta1+theta2;
    Theta1=[Theta1;theta1*180/pi];
    Theta2=[Theta2;theta2*180/pi];
    Theta_z=[Theta_z;theta_z*180/pi];
end
t=[0:0.01:1];
% ����ر���ͳһ��һ������ϵ��
Theta_z=Theta_z/180*pi-0.65;
% �����Ƕ���ʱ��ı仯����
figure;
plot(t,Theta1,'r');
hold on;
plot(t,Theta2,'b');
xlabel("Time");
ylabel("Theta");
title("�Ƕ�����");
legend('Theta1','Theta2');
% �������ٶ���ʱ��ı仯����
figure;
plot(t,Omega1,'r');
hold on;
plot(t,Omega2,'b');
xlabel("Time");
ylabel("Omega");
title("���ٶ�����");
legend('Omega1','Omega2');
% �����Ǽ��ٶ���ʱ��ı仯����
figure;
plot(t,Acc1,'r');
hold on;
plot(t,Acc2,'b');
xlabel("Time");
ylabel("Acc");
title("�Ǽ��ٶ�����");
legend('Acc1','Acc2');
% ����X,Y,theta_z��ʱ��ı仯����
figure;
plot(t,X,'r');
hold on;
plot(t,Y,'b');
hold on;
plot(t,Theta_z,'g');
xlabel("Time");
ylabel("Bias");
title("ƫ��λ�á��Ƕ�����");
legend('X','Y','Theta_z');
% ����������ʱ��ı仯���ߣ�������rne�涯��ѧ���õ���
figure;
Theta1=Theta1/180*pi;
Theta2=Theta2/180*pi;
%�ǵ�����������ٶȣ���Ҳ������һ��ʼ��SerialLink��gravity���ԣ�
T_all=two_link.rne([Omega1,Omega2],[Theta1,Theta2],[Acc1,Acc2],[0 9.8 0]);
plot(t,T_all(:,1),'r');
hold on;
plot(t,-T_all(:,2),'b');
xlabel("ʱ��");
ylabel("����");
title("��������");
legend('T1','T2');