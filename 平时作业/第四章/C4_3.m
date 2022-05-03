%% 群文件第四章第三道习题
clear
clc
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
%设置力矩
L(1).I=[0 0 0.5 0 0 0];
L(2).I=[0 0 0.2 0 0 0];
L(3).I=[0 0 0.1 0 0 0];
three_link=SerialLink(L,'name','threelink');
three_link.gravity=[0 9.8 0];
three_link=three_link.nofriction();

%u=[20 5 1]
q0=[-pi/3 pi/2 pi/6];
qd0=[0 0 0];
% 求解正动力学
[t,q,qd] = three_link.fdyn(4,@taugenerator,q0,qd0);
l=length (qd (:));
q1=[];
q2=[];
q3=[];
qd1=[];
qd2=[];
qd3=[];
for i=1:l/3
    q1=[q1 q(i)];
    qd1=[qd1 qd(i)];
end
for i=l/3+1:2*(l/3)
    q2=[q2 q(i)];
    qd2=[qd2 qd(i)];
end
for i=2*(l/3)+1:l
    q3=[q3 q(i)];
    qd3=[qd3 qd(i)];
end
%画角度曲线
figure(1)
plot(t,q1,'r');
hold on 
plot(t,q2,'b');
hold on
plot(t,q3,'g');
legend('q1','q2','q3')
%画角速度曲线
figure(2)
plot(t,qd1,'r');
hold on 
plot(t,qd2,'b');
hold on
plot(t,qd3,'g');
legend('qd1','qd2','qd3')

