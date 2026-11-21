
%% 原始数据，单位为kg·mm2
Lxx = 1916471281.579;
Lxy = 8661163.812;
Lxz = -4094508.715;
Lyx = 8661163.812;
Lyy = 2019642374.244;
Lyz = -1288244.721;
Lzx = -4094508.715;
Lzy = -1288244.721;
Lzz = 3650681001.477;

%% 坐标转换、单位转换
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
I = [Ixx Ixy Ixz;
    Iyx Iyy Iyz;
    Izx Izy Izz];
Mass = 600;




