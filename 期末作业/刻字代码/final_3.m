clear;
clc;
%大作业第三问
%根据说明文档中的参数建立DH表，最后一个d未知，赋值150以确保展示效果
L(1)=Revolute('d',151.9,'a',0,'alpha',-pi/2);
L(2)=Revolute('d',86.85,'a',243.65,'alpha',0);
L(3)=Revolute('d',-92.85,'a',213,'alpha',0);
L(4)=Revolute('d',83.4,'a',0,'alpha',pi/2);
L(5)=Revolute('d',83.4,'a',0,'alpha',-pi/2);
L(6)=Revolute('d',500,'a',0,'alpha',0);%为方便展示效果（尽可能不触碰球面），把d设得比实际大
myUR3=SerialLink(L,'name','myUR3');
%myUR3.plot([0 -pi/2 0 pi/2 0 0])
%给每个关节加限制
L(1).qlim = [-2*pi,2*pi];
L(2).qlim = [-2*pi,2*pi];
L(3).qlim = [-2*pi,2*pi];
L(4).qlim = [-2*pi,2*pi];
L(5).qlim = [-2*pi,2*pi];
view(3)
hold on;

% 球的参数
R = 800;
x0=450;
y0=-1250;
z0=300;

pb=15; % phi方向上山大二字的偏执

% 画出球面
[x y z] = sphere();
surf(R * x + x0, R * y + y0, R * z + z0);
colormap([0 0.4 1])
axis equal

%球体参数数组Ball
Ball=[x0 y0 z0 R];

% 二次函数拟合撇捺曲线，求得参数。
a1 = -0.074405; 
b1 = 11.423 ;
c1 = -250.36;
a2 = 0.047619; 
b2 = -6.9762;      
c2 = 443.14;

%整个生成图案的过程中，theta为经度角，phi为纬度角

% 山字第一笔，是垂直线，使用函数draw_vertical
phi = 60:1:90;
phi=phi+pb;
phi = phi*pi/180;
theta = 90*pi/180;
vector_s1 = draw_vertical(theta,phi,Ball);
plot3(vector_s1(1,:),vector_s1(2,:),vector_s1(3,:),'r');
T1 = transl(vector_s1');

% 山字第二笔，是斜线，使用函数draw_normal
phi = 78:1:90;
phi=phi+pb;
phi = phi*pi/180;
theta = 77:0.1:78.2;
theta = theta*pi/180;
vector_s2 = draw_normal(theta,phi,Ball);
plot3(vector_s2(1,:),vector_s2(2,:),vector_s2(3,:),'r');
T2 = transl(vector_s2');

% 山字第三笔，水平线，使用函数draw_horizon
phi = (90+pb)*pi/180;
theta = 77:1:103;
theta=theta*pi/180;
vector_s3 = draw_horizon(theta,phi,Ball);
plot3(vector_s3(1,:),vector_s3(2,:),vector_s3(3,:),'r');
T3 = transl(vector_s3');

% 山字第四笔，斜线，使用函数draw_normal
phi = 78:1:90;
phi=phi+pb;
phi = phi*pi/180;
theta = 103:-0.1:101.8;
theta = theta*pi/180;
vector_s4 = draw_normal(theta,phi,Ball);
plot3(vector_s4(1,:),vector_s4(2,:),vector_s4(3,:),'r');
T4 = transl(vector_s4');

% 大字第一笔，水平线，使用函数draw_horizon
phi = (76+pb+2)*pi/180;
theta =125:1:151;
theta=theta*pi/180;
vector_s5 = draw_horizon(theta,phi,Ball);
plot3(vector_s5(1,:),vector_s5(2,:),vector_s5(3,:),'r');
T5 = transl(vector_s5');

% 大字第二笔，垂直线，使用函数draw_vertical
phi = 60:1:76;
phi=phi+pb+2;
phi=phi*pi/180;
theta = 138/180*pi;
vector_s6 = draw_vertical(theta,phi,Ball);
plot3(vector_s6(1,:),vector_s6(2,:),vector_s6(3,:),'r');
T6 = transl(vector_s6');

% 大字第三笔，撇，使用函数draw_normal
phi_deg = 78:1:90;
theta_deg = a1.*phi_deg.*phi_deg+b1*phi_deg+c1;
phi_deg=phi_deg+pb;
phi = phi_deg*pi/180;
theta = (theta_deg-50)/180*pi;
vector_s7 = draw_normal(theta,phi,Ball);
plot3(vector_s7(1,:),vector_s7(2,:),vector_s7(3,:),'r');
T7 = transl(vector_s7');

% 大字第四笔，捺，使用函数draw_normal
phi_deg = 78:1:90;
theta_deg = a2.*phi_deg.*phi_deg+b2*phi_deg+c2;
phi_deg=phi_deg+pb;
phi = phi_deg*pi/180;
theta = (theta_deg-50)/180*pi;
vector_s8 = draw_normal(theta,phi,Ball);
plot3(vector_s8(1,:),vector_s8(2,:),vector_s8(3,:),'r');
T8 = transl(vector_s8');

% 逆运动学求解
route1 = myUR3.ikine(T1,'mask',[1 1 1 0 0 0]);
route2 = myUR3.ikine(T2,'mask',[1 1 1 0 0 0]);
route3 = myUR3.ikine(T3,'mask',[1 1 1 0 0 0]);
route4 = myUR3.ikine(T4,'mask',[1 1 1 0 0 0]);
route5 = myUR3.ikine(T5,'mask',[1 1 1 0 0 0]);
route6 = myUR3.ikine(T6,'mask',[1 1 1 0 0 0]);
route7 = myUR3.ikine(T7,'mask',[1 1 1 0 0 0]);
route8 = myUR3.ikine(T8,'mask',[1 1 1 0 0 0]);

% 机械臂走一遍运动学求解得到的路径
pause(5);
myUR3.plot(route1);
myUR3.plot(route2);
myUR3.plot(route3);
myUR3.plot(route4);
myUR3.plot(route5);
myUR3.plot(route6);
myUR3.plot(route7);
myUR3.plot(route8);

% 机械臂回到刚开始的位置
q0 = deg2rad([0 -pi/2 0 pi/2 0 0]);
myUR3.plot(q0);