%�ڶ���ϰ�⣬��ʮ����
%% ��һ��
p = [1,2,3]';
R1 = rotx(30,'deg');
R2 = roty(60,'deg');
p2 = R2*R1*p;
p2

%% �ڶ���
%����ǰ
B=eye(4);
R1=trotx(90,'deg');
R2=transl(5,3,6);
R3=trotz(90,'deg');
B1=R3*R2*R1*B;
p=[5 3 4 1]';
B1
B1p=B1*p;
B1p
figure(1);
trplot(B1);
%������
B2=R2*R3*R1*B;
B2
B2p=B2*p;
B2p
figure(2);
trplot(B2);

%% ������
T1=[0.527,-0.574,0.628,2;
0.369,0.819,0.439,5;
-0.766,0,0.643,3;
0,0,0,1];
inv(T1)

T2=[0.92,0,0.39,5;
0,1,0,6;
-0.39,0,0.92,2;
0,0,0,1];
inv(T2)

%% �����⣺
% ��o����ת-�£����� a ��ƽ��-�� 

%% �����⣺
%(1)
T=[1,0,0,3.1375;
0,1,0,2.195;
0,0,1,3.214;
0,0,0,1];
gamma=atan2(T(2,4),T(1,4))*180/pi
beta=atan2(T(2,4),(T(3,4)*sind(gamma)))*180/pi
r=T(3,4)/cosd(beta)
%(2)
T(1,1)=cosd(beta)*cosd(gamma);
T(1,2)=-sind(gamma);
T(1,3)=sind(beta)*cosd(gamma);
T(2,1)=cosd(beta)*sind(gamma);
T(2,2)=cosd(gamma);
T(2,3)=sind(beta)*sind(gamma);
T(3,1)=-sind(beta);
T(3,3)=cosd(beta);
T

%% �����⣺
T=[0.527,-0.574,0.628,4;
0.369,0.819,0.439,6;
-0.766,0,0.643,9;
0,0,0,1];
phi_a1=atan2(T(2,1),T(1,1))*180/pi
phi_a2=atan2(-T(2,1),-T(1,1))*180/pi
phi_o1=atan2(-T(3,1),(T(1,1)*cosd(phi_a1)+T(2,1)*sind(phi_a1))) *180/pi
phi_o2=atan2(-T(3,1),(T(1,1)*cosd(phi_a2)+T(2,1)*sind(phi_a2))) *180/pi
phi_n1=atan2((-T(2,3)*cosd(phi_a1)+T(1,3)*sind(phi_a1)),(T(2,2)*cosd(phi_a1)-T(1,2)*sind(phi_a1))) *180/pi
phi_n2=atan2(-(-T(2,3)*cosd(phi_a2)+T(1,3)*sind(phi_a2)),-(T(2,2)*cosd(phi_a1)-T(1,2)*sind(phi_a2))) *180/pi
px=T(1,4);py=T(2,4);pz=T(3,4);

%% �����⣺
T=[0.527,-0.574,0.628,4;
0.369,0.819,0.439,6;
-0.766,0,0.643,9;
0,0,0,1];
phi_1=atan2(T(2,3),T(1,3))*180/pi
phi_2=atan2(-T(2,3),-T(1,3))*180/pi
zeta_1=atan2((-T(1,1)*sind(phi_1)+T(2,1)*cosd(phi_1)),(-T(1,2)*sind(phi_1)+T(2,2)*cosd(phi_1))) *180/pi
zeta_2=atan2((-T(1,1)*sind(phi_2)+T(2,1)*cosd(phi_2)),(-T(1,2)*sind(phi_2)+T(2,2)*cosd(phi_2))) *180/pi
theta_1=atan2((T(1,3)*cosd(phi_1)+T(2,3)*sind(phi_1)),(T(3,3))) *180/pi
theta_2=atan2((T(1,3)*cosd(phi_2)+T(2,3)*sind(phi_2)),(T(3,3))) *180/pi

px=T(1,4),py=T(2,4),pz=T(3,4)


%% �ڰ��⣺
%(1)
T=trotx(45,'deg')*trotz(60,'deg')*transl(0,0,3)*transl(0,6,0)*trotx(60,'deg')
%(2)
phi_1=atan2(T(2,3),T(1,3))*180/pi
phi_2=atan2(-T(2,3),-T(1,3)) *180/pi
zeta_1=atan2((-T(1,1)*sind(phi_1)+T(2,1)*cosd(phi_1)),(-T(1,2)*sind(phi_1)+T(2,2)*cosd(phi_1))) *180/pi
zeta_2=atan2((-T(1,1)*sind(phi_2)+T(2,1)*cosd(phi_2)),(-T(1,2)*sind(phi_2)+T(2,2)*cosd(phi_2))) *180/pi
theta_1=atan2((T(1,3)*cosd(phi_1)+T(2,3)*sind(phi_1)),(T(3,3))) *180/pi
theta_2=atan2((T(1,3)*cosd(phi_2)+T(2,3)*sind(phi_2)),(T(3,3))) *180/pi

%% �ھ��⣺
%(1)
T=trotx(45,'deg')*trotz(60,'deg')*transl(5,0,0)*troty(60,'deg')*transl(0,0,3)
%(2)
phi_a1=atan2(T(2,1),T(1,1))*180/pi
phi_a2=atan2(-T(2,1),-T(1,1)) *180/pi
phi_o1=atan2(-T(3,1),(T(1,1)*cosd(phi_a1)+T(2,1)*sind(phi_a1))) *180/pi
phi_o2=atan2(-T(3,1),(T(1,1)*cosd(phi_a2)+T(2,1)*sind(phi_a2))) *180/pi
phi_n1=atan2((-T(2,3)*cosd(phi_a1)+T(1,3)*sind(phi_a1)),(T(2,2)*cosd(phi_a1)-T(1,2)*sind(phi_a1))) *180/pi
phi_n2=atan2((-T(2,3)*cosd(phi_a2)+T(1,3)*sind(phi_a2)),(T(2,2)*cosd(phi_a2)-T(1,2)*sind(phi_a2))) *180/pi
px=T(1,4),py=T(2,4),pz=T(3,4)

%% ��ʮ�⣺
%(1)
UTR=[0,-1,0,2;
1,0,0,-1;
0,0,1,0;
0,0,0,1];
UTobj=[1,0,0,1;
0,0,-1,4;
0,1,0,0;
0,0,0,1];
RTH=inv(UTR)*UTobj
%(2)
%�𣺲����ԣ���Ϊ�ڶ��е����е�Ԫ��Ϊ0��
%(3)
T=RTH;
phi_1=atan2(T(2,3),T(1,3))*180/pi
phi_2=atan2(-T(2,3),-T(1,3))*180/pi
zeta_1=atan2((-T(1,1)*sind(phi_1)+T(2,1)*cosd(phi_1)),(-T(1,2)*sind(phi_1)+T(2,2)*cosd(phi_1))) *180/pi
zeta_2=atan2((-T(1,1)*sind(phi_2)+T(2,1)*cosd(phi_2)),(-T(1,2)*sind(phi_2)+T(2,2)*cosd(phi_2))) *180/pi
theta_1=atan2((T(1,3)*cosd(phi_1)+T(2,3)*sind(phi_1)),(T(3,3))) *180/pi
theta_2=atan2((T(1,3)*cosd(phi_2)+T(2,3)*sind(phi_2)),(T(3,3))) *180/pi
px=5
py=1
pz=0
