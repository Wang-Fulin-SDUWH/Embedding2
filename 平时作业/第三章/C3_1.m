%% ¿Î±¾Ï°Ìâ3.1--3.5
%% 3.1:
B=[[0,0,1,2]
    [1,0,0,7]
    [0,1,0,5]
    [0,0,0,1]];
dx=0.1;dy=0.1;dz=0.3;
dtx=0;dty=0;dtz=0.15;
Delta=transl(dx,dy,dz)*trotx(dtx)*troty(dty)*trotz(dtz)-eye(4);
dB=Delta*B;
B_new=B+dB;

%% 3.2:
% dx=0.6,dy=0.5,dz=-0.5
% dtx=0,dty=0.1,dtz=0.1

%% 3.3:
dx=1;dy=0;dz=0.5;
dtx=0;dty=0.1;dtz=0;
Delta=transl(dx,dy,dz)*trotx(dtx)*troty(dty)*trotz(dtz)-eye(4);

delta=[0,0.1,0];
d=[1,0,0.5];
n=[0,1,0];
o=[0,0,1];
a=[1,0,0];
p=[10,5,0];
new=cross(delta,p)+d;
dtx_new=dot(delta,n);
dty_new=dot(delta,o);
dtz_new=dot(delta,a);
dx_new=dot(n,new);
dy_new=dot(o,new);
dz_new=dot(a,new);
Delta_new=[[0,-dtz_new,dty_new,dx_new]
    [dtz_new,0,-dtx_new,dy_new]
    [-dty_new,dtx_new,0,dz_new]
    [0,0,0,0]];

%% 3.4
T1=[[1,0,0,5]
    [0,0,-1,3]
    [0,1,0,6]
    [0,0,0,1]];
T2=[[1,0,0.1,4.8]
    [0.1,0,-1,3.5]
    [0,1,0,6.2]
    [0,0,0,1]];
Q=T2*inv(T1);

Delta=(T2-T1)*inv(T1);

dx=Delta(1,4);
dy=Delta(2,4);
dz=Delta(3,4);
dtx=Delta(3,2);
dty=Delta(1,3);
dtz=Delta(2,1);


%% 3.5
T=[[0,1,0,10]
    [1,0,0,5]
    [0,0,-1,0]
    [0,0,0,1]];
J=[[8,0,0,0,0,0]
    [-3,0,1,0,0,0]
    [0,10,0,0,0,0]
    [0,1,0,0,1,0]
    [0,0,0,1,0,0]
    [-1,0,0,0,0,1]
    ];
D_theta=[0,0.1,-0.1,0.2,0.2,0]';

D_new=J*D_theta;
dx=D_new(1);
dy=D_new(2);
dz=D_new(3);
dtx=D_new(4);
dty=D_new(5);
dtz=D_new(6);
Delta=transl(dx,dy,dz)*trotx(dtx)*troty(dty)*trotz(dtz)-eye(4);
T_new=T+Delta*T;


