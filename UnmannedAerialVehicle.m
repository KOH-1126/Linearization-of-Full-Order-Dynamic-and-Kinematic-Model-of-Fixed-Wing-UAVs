
%%
%原始数据，坐标原点为质心，后右天坐标系下，单位为kg·mm2
Lxx = 1916471281.579;
Lxy = 8661163.812;
Lxz = -4094508.715;
Lyx = 8661163.812;
Lyy = 2019642374.244;
Lyz = -1288244.721;
Lzx = -4094508.715;
Lzy = -1288244.721;
Lzz = 3650681001.477;
%坐标转换、单位转换
%坐标系原点在质心，前右下坐标系
Ixx = Lxx;Iyy = Lyy;Izz = Lzz;
Ixy = -Lxy;
Iyz = -Lyz;
Ixz = Lxz;

Ixx = Ixx*1e-6;
Iyy = Iyy*1e-6;
Izz = Izz*1e-6;
Ixy = Ixy*1e-6;
Iyz = Iyz*1e-6;
Ixz = Ixz*1e-6;
Iyx = Ixy;
Izy = Iyz;
Izx = Ixz;
%%
%总体参数
I = [Ixx Ixy Ixz;
    Iyx Iyy Iyz;
    Izx Izy Izz];
Mass = 600;
b=10;
cbar=1.32;
S=13.2;

CG = [0 0 0];
CP = [3693.677 10.138 28.311]*1e-3;
g = 9.80665;
%%
%初始条件
% X0=[20 0 0 0 0 0 0 0 0 0 0 -300];
%%
%控制参数
force_p1=2347;
force_p2=-32.38;

torque_p1=325.9;
torque_p2=-5.774;

%% 力矩方程组系数
Sigma = - Izz*Ixy^2 + 2*Ixy*Ixz*Iyz - Iyy*Ixz^2 - Ixx*Iyz^2 + Ixx*Iyy*Izz;

c1 = Iyy*Izz - Iyz^2;
c2 = Ixz*Iyz - Ixy*Izz;
c3 = Ixy*Iyz - Ixz*Iyy;
c4 = Ixz^2*Iyz - Ixy^2*Iyz + Ixy*Ixz*Iyy - Ixy*Ixz*Izz;
c5 = Ixy^2*Iyz - Ixz*Iyy*Ixy + Iyz^3 - Iyy*Izz*Iyz;
c6 = - Ixz^2*Iyz + Ixy*Izz*Ixz - Iyz^3 + Iyy*Izz*Iyz;
c7 = Ixz*Iyy^2 + 2*Ixz*Iyz^2 + Ixx*Ixy*Iyz - Ixx*Ixz*Iyy - Ixy*Iyy*Iyz - Ixy*Iyz*Izz - Ixz*Iyy*Izz;
c8 = Ixy^2*Izz - Ixz^2*Iyy + Iyy^2*Izz - Iyy*Iyz^2 - Iyy*Izz^2 + Iyz^2*Izz;
c9 = Ixx*Ixy*Izz - Ixy*Izz^2 - Ixx*Ixz*Iyz - 2*Ixy*Iyz^2 + Ixz*Iyy*Iyz + Ixy*Iyy*Izz + Ixz*Iyz*Izz;

c10 = Ixz*Iyz - Ixy*Izz;
c11 = Ixx*Izz - Ixz^2;
c12 = Ixy*Ixz - Ixx*Iyz;
c13 = - Ixy^2*Ixz + Ixx*Iyz*Ixy - Ixz^3 + Ixx*Izz*Ixz;
c14 = Ixy^2*Ixz - Ixz*Iyz^2 - Ixx*Ixy*Iyz + Ixy*Iyz*Izz;
c15 = Ixz^3 + Ixz*Iyz^2 - Ixx*Izz*Ixz - Ixy*Izz*Iyz;
c16 = Ixx*Ixy*Ixz - 2*Ixz^2*Iyz - Ixx^2*Iyz - Ixy*Ixz*Iyy + Ixx*Iyy*Iyz + Ixy*Ixz*Izz + Ixx*Iyz*Izz;
c17 = 2*Ixy*Ixz^2 + Ixy*Izz^2 - Ixx*Ixz*Iyz - Ixx*Ixy*Izz + Ixz*Iyy*Iyz - Ixy*Iyy*Izz - Ixz*Iyz*Izz;
c18 = - Ixx^2*Izz + Ixx*Ixz^2 + Ixx*Iyz^2 + Ixx*Izz^2 - Ixy^2*Izz - Ixz^2*Izz;

c19 = Ixy*Iyz - Ixz*Iyy;
c20 = Ixy*Ixz - Ixx*Iyz;
c21 = Ixx*Iyy - Ixy^2;
c22 = Ixy^3 + Ixy*Ixz^2 - Ixx*Iyy*Ixy - Ixx*Iyz*Ixz;
c23 = - Ixy^3 - Ixy*Iyz^2 + Ixx*Iyy*Ixy + Ixz*Iyy*Iyz;
c24 = Ixy*Iyz^2 - Ixy*Ixz^2 + Ixx*Ixz*Iyz - Ixz*Iyy*Iyz;
c25 = Ixx^2*Iyy - Ixx*Ixy^2 - Ixx*Iyy^2 - Ixx*Iyz^2 + Ixy^2*Iyy + Ixz^2*Iyy;
c26 = Ixx*Ixy*Iyz - Ixz*Iyy^2 - 2*Ixy^2*Ixz + Ixx*Ixz*Iyy + Ixy*Iyy*Iyz - Ixy*Iyz*Izz + Ixz*Iyy*Izz;
c27 = Ixx^2*Iyz + 2*Ixy^2*Iyz - Ixx*Ixy*Ixz - Ixy*Ixz*Iyy - Ixx*Iyy*Iyz + Ixy*Ixz*Izz - Ixx*Iyz*Izz;
