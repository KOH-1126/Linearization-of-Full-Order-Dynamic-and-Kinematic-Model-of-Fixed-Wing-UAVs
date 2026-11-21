% 状态变量们单独写一组
syms u v w p q r roll pitch yaw xg yg zg ...
    dT de dr da ...
    real

syms alpha0_s beta0_s Ma0_s de0_s dr0_s da0_s alt0_s real

% 需要做替换的常数单独写一组, _s表示符号变量，防止和数值变量的名称冲突
syms c1_s c2_s c3_s c4_s c5_s c6_s c7_s c8_s c9_s c10_s c11_s c12_s c13_s c14_s c15_s c16_s c17_s c18_s c19_s c20_s c21_s c22_s c23_s c24_s c25_s c26_s c27_s Sigma_s g_s ...
    force_p1_s force_p2_s torque_p1_s torque_p2_s ...
    Mass_s S_s cbar_s b_s ...
    real
syms CP_s [1 3] real
syms CG_s [1 3] real

syms CD_base0_s CY_base0_s CL_base0_s Cl_base0_s Cm_base0_s Cn_base0_s ...
    CD_de0_s CY_de0_s CL_de0_s Cl_de0_s Cm_de0_s Cn_de0_s ...
    CD_dr0_s CY_dr0_s CL_dr0_s Cl_dr0_s Cm_dr0_s Cn_dr0_s ...
    CD_da0_s CY_da0_s CL_da0_s Cl_da0_s Cm_da0_s Cn_da0_s ...
    Cmq0_s CLAlphadot0_s CmAlphadot0_s Clp0_s CYp0_s Cnp0_s Cnr0_s Clr0_s real

syms CD_base_alpha CD_base_Ma CD_base_beta ...
     CY_base_alpha CY_base_Ma CY_base_beta ...
     CL_base_alpha CL_base_Ma CL_base_beta ...
     Cl_base_alpha Cl_base_Ma Cl_base_beta ...
     Cm_base_alpha Cm_base_Ma Cm_base_beta ...
     Cn_base_alpha Cn_base_Ma Cn_base_beta real


syms CD_de_alpha CD_de_Ma CD_de_de ...
    CY_de_alpha CY_de_Ma CY_de_de ...
    CL_de_alpha CL_de_Ma CL_de_de ...
    Cl_de_alpha Cl_de_Ma Cl_de_de ...
    Cm_de_alpha Cm_de_Ma Cm_de_de ...
    Cn_de_alpha Cn_de_Ma Cn_de_de ...
    CD_dr_alpha CD_dr_Ma CD_dr_dr ...
    CY_dr_alpha CY_dr_Ma CY_dr_dr ...   
    CL_dr_alpha CL_dr_Ma CL_dr_dr ...
    Cl_dr_alpha Cl_dr_Ma Cl_dr_dr ...
    Cm_dr_alpha Cm_dr_Ma Cm_dr_dr ...
    Cn_dr_alpha Cn_dr_Ma Cn_dr_dr ...
    CD_da_alpha CD_da_Ma CD_da_da ...
    CY_da_alpha CY_da_Ma CY_da_da ...
    CL_da_alpha CL_da_Ma CL_da_da ...
    Cl_da_alpha Cl_da_Ma Cl_da_da ...
    Cm_da_alpha Cm_da_Ma Cm_da_da ...
    Cn_da_alpha Cn_da_Ma Cn_da_da real

syms Cmq_alpha Cmq_Ma Cmq_alt ...
    CLAlphadot_alpha CLAlphadot_Ma CLAlphadot_alt ...
    CmAlphadot_alpha CmAlphadot_Ma CmAlphadot_alt ...
    Clp_alpha Clp_Ma Clp_alt ...
    CYp_alpha CYp_Ma CYp_alt ...
    Cnp_alpha Cnp_Ma Cnp_alt ...
    Cnr_alpha Cnr_Ma Cnr_alt ...
    Clr_alpha Clr_Ma Clr_alt real

% 导航方程组
CEB=[                cos(pitch)*cos(yaw),     cos(pitch)*sin(yaw),               -sin(pitch);
        sin(pitch)*cos(yaw)*sin(roll)-sin(yaw)*cos(roll),sin(pitch)*sin(yaw)*sin(roll)+cos(yaw)*cos(roll),cos(pitch)*sin(roll);
        sin(pitch)*cos(yaw)*cos(roll)+sin(yaw)*sin(roll),sin(pitch)*sin(yaw)*cos(roll)-cos(yaw)*sin(roll),cos(pitch)*cos(roll)];
Xg_dot = CEB'*[u;v;w];
xg_dot = Xg_dot(1);
yg_dot = Xg_dot(2);
zg_dot = Xg_dot(3);

% 运动方程组
A = [1,   sin(roll)*tan(pitch), cos(roll)*tan(pitch);
        0,   cos(roll),        -sin(roll);
        0,   sin(roll)/cos(pitch), cos(roll)/cos(pitch)];
attitude_dot = A * [p; q; r];
roll_dot = attitude_dot(1);
pitch_dot = attitude_dot(2);
yaw_dot = attitude_dot(3);

% 麻烦的函数们
alpha = atand(w/u);
beta  = atand(v/sqrt(u^2 + w^2));
T = 288.15 + 0.0065*zg;
a = sqrt(1.4*287.04*T);
P = 101325*(1 + 0.0065*zg/288.15)^5.2561;
rho = P/(287.04*T);
Ma = sqrt(u^2 + v^2 + w^2) / a;
% 这里为了方便符号库求导方便，不使用 abs() 和 sign()
force = force_p1_s*dT + force_p2_s;
torque = torque_p1_s*dT + torque_p2_s;
V = sqrt(u^2 + v^2 + w^2);

CD_base = CD_base0_s + CD_base_alpha*(alpha-alpha0_s) + CD_base_beta*(beta-beta0_s) + CD_base_Ma*(Ma-Ma0_s);
CD_de = CD_de0_s + CD_de_alpha*(alpha-alpha0_s) + CD_de_Ma*(Ma-Ma0_s) + CD_de_de*(de-de0_s);
CD_dr = CD_dr0_s + CD_dr_alpha*(alpha-alpha0_s) + CD_dr_Ma*(Ma-Ma0_s) + CD_dr_dr*(dr-dr0_s);
CD_da = CD_da0_s + CD_da_alpha*(alpha-alpha0_s) + CD_da_Ma*(Ma-Ma0_s) + CD_da_da*(da-da0_s);
CY_base = CY_base0_s + CY_base_alpha*(alpha-alpha0_s) + CY_base_beta*(beta-beta0_s) + CY_base_Ma*(Ma-Ma0_s);
CY_de = CY_de0_s + CY_de_alpha*(alpha-alpha0_s) + CY_de_Ma*(Ma-Ma0_s) + CY_de_de*(de-de0_s);
CY_dr = CY_dr0_s + CY_dr_alpha*(alpha-alpha0_s) + CY_dr_Ma*(Ma-Ma0_s) + CY_dr_dr*(dr-dr0_s);
CY_da = CY_da0_s + CY_da_alpha*(alpha-alpha0_s) + CY_da_Ma*(Ma-Ma0_s) + CY_da_da*(da-da0_s);
CL_base = CL_base0_s + CL_base_alpha*(alpha-alpha0_s) + CL_base_beta*(beta-beta0_s) + CL_base_Ma*(Ma-Ma0_s);
CL_de = CL_de0_s + CL_de_alpha*(alpha-alpha0_s) + CL_de_Ma*(Ma-Ma0_s) + CL_de_de*(de-de0_s);
CL_dr = CL_dr0_s + CL_dr_alpha*(alpha-alpha0_s) + CL_dr_Ma*(Ma-Ma0_s) + CL_dr_dr*(dr-dr0_s);
CL_da = CL_da0_s + CL_da_alpha*(alpha-alpha0_s) + CL_da_Ma*(Ma-Ma0_s) + CL_da_da*(da-da0_s);
Cl_base = Cl_base0_s + Cl_base_alpha*(alpha-alpha0_s) + Cl_base_beta*(beta-beta0_s) + Cl_base_Ma*(Ma-Ma0_s);
Cl_de = Cl_de0_s + Cl_de_alpha*(alpha-alpha0_s) + Cl_de_Ma*(Ma-Ma0_s) + Cl_de_de*(de-de0_s);
Cl_dr = Cl_dr0_s + Cl_dr_alpha*(alpha-alpha0_s) + Cl_dr_Ma*(Ma-Ma0_s) + Cl_dr_dr*(dr-dr0_s);
Cl_da = Cl_da0_s + Cl_da_alpha*(alpha-alpha0_s) + Cl_da_Ma*(Ma-Ma0_s) + Cl_da_da*(da-da0_s);
Cm_base = Cm_base0_s + Cm_base_alpha*(alpha-alpha0_s) + Cm_base_beta*(beta-beta0_s) + Cm_base_Ma*(Ma-Ma0_s);
Cm_de = Cm_de0_s + Cm_de_alpha*(alpha-alpha0_s) + Cm_de_Ma*(Ma-Ma0_s) + Cm_de_de*(de-de0_s);
Cm_dr = Cm_dr0_s + Cm_dr_alpha*(alpha-alpha0_s) + Cm_dr_Ma*(Ma-Ma0_s) + Cm_dr_dr*(dr-dr0_s);
Cm_da = Cm_da0_s + Cm_da_alpha*(alpha-alpha0_s) + Cm_da_Ma*(Ma-Ma0_s) + Cm_da_da*(da-da0_s);
Cn_base = Cn_base0_s + Cn_base_alpha*(alpha-alpha0_s) + Cn_base_beta*(beta-beta0_s) + Cn_base_Ma*(Ma-Ma0_s);
Cn_de = Cn_de0_s + Cn_de_alpha*(alpha-alpha0_s) + Cn_de_Ma*(Ma-Ma0_s) + Cn_de_de*(de-de0_s);
Cn_dr = Cn_dr0_s + Cn_dr_alpha*(alpha-alpha0_s) + Cn_dr_Ma*(Ma-Ma0_s) + Cn_dr_dr*(dr-dr0_s);
Cn_da = Cn_da0_s + Cn_da_alpha*(alpha-alpha0_s) + Cn_da_Ma*(Ma-Ma0_s) + Cn_da_da*(da-da0_s);

Cmq = Cmq0_s + Cmq_alpha*(alpha-alpha0_s) + Cmq_Ma*(Ma-Ma0_s) + Cmq_alt*(-zg-alt0_s);
CLAlphadot = CLAlphadot0_s + CLAlphadot_alpha*(alpha-alpha0_s) + CLAlphadot_Ma*(Ma-Ma0_s) + CLAlphadot_alt*(-zg-alt0_s);
CmAlphadot = CmAlphadot0_s + CmAlphadot_alpha*(alpha-alpha0_s) + CmAlphadot_Ma*(Ma-Ma0_s) + CmAlphadot_alt*(-zg-alt0_s);
Clp = Clp0_s + Clp_alpha*(alpha-alpha0_s) + Clp_Ma*(Ma-Ma0_s) + Clp_alt*(-zg-alt0_s);
CYp = CYp0_s + CYp_alpha*(alpha-alpha0_s) + CYp_Ma*(Ma-Ma0_s) + CYp_alt*(-zg-alt0_s);
Cnp = Cnp0_s + Cnp_alpha*(alpha-alpha0_s) + Cnp_Ma*(Ma-Ma0_s) + Cnp_alt*(-zg-alt0_s);
Cnr = Cnr0_s + Cnr_alpha*(alpha-alpha0_s) + Cnr_Ma*(Ma-Ma0_s) + Cnr_alt*(-zg-alt0_s);
Clr = Clr0_s + Clr_alpha*(alpha-alpha0_s) + Clr_Ma*(Ma-Ma0_s) + Clr_alt*(-zg-alt0_s);

Cs = [CD_base CD_de CD_dr CD_da ...
    CY_base CY_de CY_dr CY_da ...
    CL_base CL_de CL_dr CL_da ...
    Cl_base Cl_de Cl_dr Cl_da ...
    Cm_base Cm_de Cm_dr Cm_da ...
    Cn_base Cn_de Cn_dr Cn_da ...
    Cmq CLAlphadot CmAlphadot Clp CYp Cnp Cnr Clr];

% 根据epsilon评估结果将一些气动导数置为0
run("Evaluate.m");
Cd_s = [
    CD_base_alpha CD_base_Ma CD_base_beta 
    CY_base_alpha CY_base_Ma CY_base_beta 
    CL_base_alpha CL_base_Ma CL_base_beta 
    Cl_base_alpha Cl_base_Ma Cl_base_beta 
    Cm_base_alpha Cm_base_Ma Cm_base_beta 
    Cn_base_alpha Cn_base_Ma Cn_base_beta
    CD_de_alpha CD_de_Ma CD_de_de 
    CY_de_alpha CY_de_Ma CY_de_de 
    CL_de_alpha CL_de_Ma CL_de_de 
    Cl_de_alpha Cl_de_Ma Cl_de_de 
    Cm_de_alpha Cm_de_Ma Cm_de_de 
    Cn_de_alpha Cn_de_Ma Cn_de_de 
    CD_dr_alpha CD_dr_Ma CD_dr_dr 
    CY_dr_alpha CY_dr_Ma CY_dr_dr  
    CL_dr_alpha CL_dr_Ma CL_dr_dr 
    Cl_dr_alpha Cl_dr_Ma Cl_dr_dr 
    Cm_dr_alpha Cm_dr_Ma Cm_dr_dr 
    Cn_dr_alpha Cn_dr_Ma Cn_dr_dr 
    CD_da_alpha CD_da_Ma CD_da_da 
    CY_da_alpha CY_da_Ma CY_da_da 
    CL_da_alpha CL_da_Ma CL_da_da 
    Cl_da_alpha Cl_da_Ma Cl_da_da 
    Cm_da_alpha Cm_da_Ma Cm_da_da 
    Cn_da_alpha Cn_da_Ma Cn_da_da
    Cmq_alpha Cmq_Ma Cmq_alt 
    CLAlphadot_alpha CLAlphadot_Ma CLAlphadot_alt 
    CmAlphadot_alpha CmAlphadot_Ma CmAlphadot_alt 
    Clp_alpha Clp_Ma Clp_alt 
    CYp_alpha CYp_Ma CYp_alt 
    Cnp_alpha Cnp_Ma Cnp_alt 
    Cnr_alpha Cnr_Ma Cnr_alt 
    Clr_alpha Clr_Ma Clr_alt 
]'; % 气动导数的符号变量
global EvaluateTable
for i = 1:numel(Cd_s)
    if EvaluateTable(i) == 0
        Cs = subs(Cs, Cd_s(i), 0);
    end
end
    

CD = Cs(1) + Cs(2) + Cs(3) + Cs(4);
CY = Cs(5) + Cs(6) + Cs(7) + Cs(8) + Cs(29)*((p*b_s) / (2*V));
CL = Cs(9) + Cs(10) + Cs(11) + Cs(12);
Cl = Cs(13) + Cs(14) + Cs(15) + Cs(16) + Cs(28)*((p*b_s) / (2*V)) + Cs(32)*((r*b_s) / (2*V));
Cm = Cs(17) + Cs(18) + Cs(19) + Cs(20) + Cs(25)*((q*cbar_s) / (2*V));
Cn = Cs(21) + Cs(22) + Cs(23) + Cs(24) + Cs(30)*((p*b_s) / (2*V)) + Cs(31)*((r*b_s) / (2*V));

D=0.5*rho*V^2*S_s*CD;
Y=0.5*rho*V^2*S_s*CY;
L=0.5*rho*V^2*S_s*CL;
l=0.5*rho*V^2*S_s*b_s*Cl;
m=0.5*rho*V^2*S_s*cbar_s*Cm;
n=0.5*rho*V^2*S_s*b_s*Cn;
Faw=[-D; Y; -L]; MaH=[l; m; n];

Cbw=[cosd(alpha)*cosd(beta) -cosd(alpha)*sind(beta) -sind(alpha);
         sind(beta)             cosd(beta)              0;
         sind(alpha)*cosd(beta) -sind(alpha)*sind(beta) cosd(alpha)];
Fa = Cbw*Faw;

rOH = CP_s-CG_s;    rOH=rOH';
M_a = MaH + cross(rOH, Fa);
F = Fa + [force; 0; 0]; M = M_a + [torque; 0; 0];

% 力方程组
Fx = F(1); Fy = F(2); Fz = F(3);
u_dot = Fx/Mass_s + v*r - w*q - g_s*sin(pitch);
v_dot = Fy/Mass_s + w*p - u*r + g_s*sin(roll)*cos(pitch);
w_dot = Fz/Mass_s + u*q - v*p + g_s*cos(roll)*cos(pitch);

% 力矩方程组
Mx = M(1); My = M(2); Mz = M(3);
p_dot = (c1_s*Mx + c2_s*My + c3_s*Mz + c4_s*p^2 + c5_s*q^2 + c6_s*r^2 +c7_s*p*q + c8_s*q*r + c9_s*p*r)/Sigma_s;
q_dot = (c10_s*Mx + c11_s*My + c12_s*Mz + c13_s*p^2 + c14_s*q^2 + c15_s*r^2 +c16_s*p*q + c17_s*q*r + c18_s*p*r)/Sigma_s;
r_dot = (c19_s*Mx + c20_s*My + c21_s*Mz + c22_s*p^2 + c23_s*q^2 + c24_s*r^2 +c25_s*p*q + c26_s*q*r + c27_s*p*r)/Sigma_s;

X_dot = [u_dot; v_dot; w_dot; p_dot; q_dot; r_dot; roll_dot; pitch_dot; yaw_dot; xg_dot; yg_dot; zg_dot];
X_dot1 = [u_dot; w_dot; q_dot; pitch_dot; xg_dot; zg_dot];
X_dot2 = [v_dot; p_dot; r_dot; roll_dot; yaw_dot; yg_dot];

X = [u , v , w , p , q , r , roll , pitch , yaw, xg, yg, zg];
X1 = [u, w, q, pitch, xg, zg];
X2 = [v, p, r, roll, yaw, yg];

U = [dT, de, dr, da];

%%
A1 = jacobian(X_dot1, X1);
B1 = jacobian(X_dot1, U);

A2 = jacobian(X_dot2, X2);
B2 = jacobian(X_dot2, U);

A = jacobian(X_dot, X);
B = jacobian(X_dot, U);

%% 值替换
load("op_trim3.mat");
run("UnmannedAerialVehicle.m");

%% 不解耦
X0 = [op_trim3.States(1, 1).x;op_trim3.States(2,1).x;op_trim3.States(3,1).x;op_trim3.States(4,1).x];
U0 = [op_trim3.Inputs(1, 1).u;op_trim3.Inputs(2, 1).u;op_trim3.Inputs(3, 1).u;op_trim3.Inputs(4, 1).u];
C0 = [CD_base0; CY_base0; CL_base0; Cl_base0; Cm_base0; Cn_base0; ...
    CD_de0; CY_de0; CL_de0; Cl_de0; Cm_de0; Cn_de0; ...
    CD_dr0; CY_dr0; CL_dr0; Cl_dr0; Cm_dr0; Cn_dr0; ...
    CD_da0; CY_da0; CL_da0; Cl_da0; Cm_da0; Cn_da0; ...
    Cmq0; CLAlphadot0; CmAlphadot0; Clp0; CYp0; Cnp0; Cnr0; Clr0]; % 这里是从Derivatives加载的数值

A_analysis = subs(A, [CD_base0_s, CY_base0_s, CL_base0_s, Cl_base0_s, Cm_base0_s, Cn_base0_s, ...
    CD_de0_s, CY_de0_s, CL_de0_s, Cl_de0_s, Cm_de0_s, Cn_de0_s, ...
    CD_dr0_s, CY_dr0_s, CL_dr0_s, Cl_dr0_s, Cm_dr0_s, Cn_dr0_s, ...
    CD_da0_s, CY_da0_s, CL_da0_s, Cl_da0_s, Cm_da0_s, Cn_da0_s, ...
    Cmq0_s, CLAlphadot0_s, CmAlphadot0_s, Clp0_s, CYp0_s, Cnp0_s, Cnr0_s, Clr0_s]', C0); % 替换平衡点的气动组成项

B_analysis = subs(B, [CD_base0_s, CY_base0_s, CL_base0_s, Cl_base0_s, Cm_base0_s, Cn_base0_s, ...
    CD_de0_s, CY_de0_s, CL_de0_s, Cl_de0_s, Cm_de0_s, Cn_de0_s, ...
    CD_dr0_s, CY_dr0_s, CL_dr0_s, Cl_dr0_s, Cm_dr0_s, Cn_dr0_s, ...
    CD_da0_s, CY_da0_s, CL_da0_s, Cl_da0_s, Cm_da0_s, Cn_da0_s, ...
    Cmq0_s, CLAlphadot0_s, CmAlphadot0_s, Clp0_s, CYp0_s, Cnp0_s, Cnr0_s, Clr0_s]', C0); % 替换平衡点的气动组成项

% 替换气动导数 注意，忽略的气动导数项已经在符号表达式中置0，此处不再需要对数值做处理

Cd_n = [
    CD_base_alphar CD_base_Mar CD_base_betar
    CY_base_alphar CY_base_Mar CY_base_betar
    CL_base_alphar CL_base_Mar CL_base_betar
    Cl_base_alphar Cl_base_Mar Cl_base_betar
    Cm_base_alphar Cm_base_Mar Cm_base_betar
    Cn_base_alphar Cn_base_Mar Cn_base_betar
    CD_de_alphar CD_de_Mar CD_de_der 
    CY_de_alphar CY_de_Mar CY_de_der 
    CL_de_alphar CL_de_Mar CL_de_der 
    Cl_de_alphar Cl_de_Mar Cl_de_der 
    Cm_de_alphar Cm_de_Mar Cm_de_der 
    Cn_de_alphar Cn_de_Mar Cn_de_der 
    CD_dr_alphar CD_dr_Mar CD_dr_drr 
    CY_dr_alphar CY_dr_Mar CY_dr_drr  
    CL_dr_alphar CL_dr_Mar CL_dr_drr 
    Cl_dr_alphar Cl_dr_Mar Cl_dr_drr 
    Cm_dr_alphar Cm_dr_Mar Cm_dr_drr 
    Cn_dr_alphar Cn_dr_Mar Cn_dr_drr 
    CD_da_alphar CD_da_Mar CD_da_dar 
    CY_da_alphar CY_da_Mar CY_da_dar 
    CL_da_alphar CL_da_Mar CL_da_dar 
    Cl_da_alphar Cl_da_Mar Cl_da_dar 
    Cm_da_alphar Cm_da_Mar Cm_da_dar 
    Cn_da_alphar Cn_da_Mar Cn_da_dar
    Cmq_alphar Cmq_Mar Cmq_altr 
    CLAlphadot_alphar CLAlphadot_Mar CLAlphadot_altr 
    CmAlphadot_alphar CmAlphadot_Mar CmAlphadot_altr 
    Clp_alphar Clp_Mar Clp_altr 
    CYp_alphar CYp_Mar CYp_altr 
    Cnp_alphar Cnp_Mar Cnp_altr 
    Cnr_alphar Cnr_Mar Cnr_altr 
    Clr_alphar Clr_Mar Clr_altr 
]'; % 气动导数的数值变量
% 替换气动导数中的带0量
alpha00 = atand(X0(3)/X0(1));
beta00 = atand(X0(2)/sqrt(X0(1)^2 + X0(3)^2));
Ma00 = sqrt(X0(1)^2 + X0(2)^2 + X0(3)^2) / sqrt(1.4*287.04*(288.15 + 0.0065*X0(12)));
de00 = U0(2);
dr00 = U0(3);
da00 = U0(4);
alt00 = -X0(12);
A_analysis = subs(A_analysis, [alpha0_s, beta0_s, Ma0_s, de0_s, dr0_s, da0_s, alt0_s], [alpha00, beta00, Ma00, de00, dr00, da00, alt00]);
B_analysis = subs(B_analysis, [alpha0_s, beta0_s, Ma0_s, de0_s, dr0_s, da0_s, alt0_s], [alpha00, beta00, Ma00, de00, dr00, da00, alt00]);

% 替换平衡点的气动导数
A_analysis = subs(A_analysis, Cd_s, Cd_n); 
B_analysis = subs(B_analysis, Cd_s, Cd_n); 

% 替换平衡点的状态和控制
A_analysis = subs(A_analysis, X', X0);
B_analysis = subs(B_analysis, X', X0);
A_analysis = subs(A_analysis, U', U0);
B_analysis = subs(B_analysis, U', U0);

% 替换飞行器特性常数
constant_s = [c1_s, c2_s, c3_s, c4_s, c5_s, c6_s, c7_s, c8_s, c9_s, c10_s, c11_s, c12_s, c13_s, c14_s, c15_s, c16_s, c17_s, c18_s, c19_s, c20_s, c21_s, c22_s, c23_s, c24_s, c25_s, c26_s, c27_s...
    Sigma_s, g_s, Mass_s, S_s, cbar_s, b_s, force_p1_s, force_p2_s, torque_p1_s, torque_p2_s]';

constant  = [c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27,...
    Sigma, g, Mass, S, cbar, b, force_p1, force_p2, torque_p1, torque_p2]';
A_analysis = subs(A_analysis, constant_s, constant);
B_analysis = subs(B_analysis, constant_s, constant);
A_analysis = subs(A_analysis,CP_s,CP);
B_analysis = subs(B_analysis,CP_s,CP);
A_analysis = subs(A_analysis,CG_s,CG);
B_analysis = subs(B_analysis,CG_s,CG);

% 转数值
A_analysis = double(A_analysis);
B_analysis = double(B_analysis);

%% 解耦
A1_analysis = subs(A1, [CD_base0_s, CY_base0_s, CL_base0_s, Cl_base0_s, Cm_base0_s, Cn_base0_s, ...
    CD_de0_s, CY_de0_s, CL_de0_s, Cl_de0_s, Cm_de0_s, Cn_de0_s, ...
    CD_dr0_s, CY_dr0_s, CL_dr0_s, Cl_dr0_s, Cm_dr0_s, Cn_dr0_s, ...
    CD_da0_s, CY_da0_s, CL_da0_s, Cl_da0_s, Cm_da0_s, Cn_da0_s, ...
    Cmq0_s, CLAlphadot0_s, CmAlphadot0_s, Clp0_s, CYp0_s, Cnp0_s, Cnr0_s, Clr0_s]', C0); % 替换平衡点的气动组成项

A2_analysis = subs(A2, [CD_base0_s, CY_base0_s, CL_base0_s, Cl_base0_s, Cm_base0_s, Cn_base0_s, ...
    CD_de0_s, CY_de0_s, CL_de0_s, Cl_de0_s, Cm_de0_s, Cn_de0_s, ...
    CD_dr0_s, CY_dr0_s, CL_dr0_s, Cl_dr0_s, Cm_dr0_s, Cn_dr0_s, ...
    CD_da0_s, CY_da0_s, CL_da0_s, Cl_da0_s, Cm_da0_s, Cn_da0_s, ...
    Cmq0_s, CLAlphadot0_s, CmAlphadot0_s, Clp0_s, CYp0_s, Cnp0_s, Cnr0_s, Clr0_s]', C0); % 替换平衡点的气动组成项

B1_analysis = subs(B1, [CD_base0_s, CY_base0_s, CL_base0_s, Cl_base0_s, Cm_base0_s, Cn_base0_s, ...
    CD_de0_s, CY_de0_s, CL_de0_s, Cl_de0_s, Cm_de0_s, Cn_de0_s, ...
    CD_dr0_s, CY_dr0_s, CL_dr0_s, Cl_dr0_s, Cm_dr0_s, Cn_dr0_s, ...
    CD_da0_s, CY_da0_s, CL_da0_s, Cl_da0_s, Cm_da0_s, Cn_da0_s, ...
    Cmq0_s, CLAlphadot0_s, CmAlphadot0_s, Clp0_s, CYp0_s, Cnp0_s, Cnr0_s, Clr0_s]', C0); % 替换平衡点的气动组成项

B2_analysis = subs(B2, [CD_base0_s, CY_base0_s, CL_base0_s, Cl_base0_s, Cm_base0_s, Cn_base0_s, ...
    CD_de0_s, CY_de0_s, CL_de0_s, Cl_de0_s, Cm_de0_s, Cn_de0_s, ...
    CD_dr0_s, CY_dr0_s, CL_dr0_s, Cl_dr0_s, Cm_dr0_s, Cn_dr0_s, ...
    CD_da0_s, CY_da0_s, CL_da0_s, Cl_da0_s, Cm_da0_s, Cn_da0_s, ...
    Cmq0_s, CLAlphadot0_s, CmAlphadot0_s, Clp0_s, CYp0_s, Cnp0_s, Cnr0_s, Clr0_s]', C0); % 替换平衡点的气动组成项

% 替换气动导数中的带0量
A1_analysis = subs(A1_analysis, [alpha0_s, beta0_s, Ma0_s, de0_s, dr0_s, da0_s, alt0_s], [alpha00, beta00, Ma00, de00, dr00, da00, alt00]);
B1_analysis = subs(B1_analysis, [alpha0_s, beta0_s, Ma0_s, de0_s, dr0_s, da0_s, alt0_s], [alpha00, beta00, Ma00, de00, dr00, da00, alt00]);
A2_analysis = subs(A2_analysis, [alpha0_s, beta0_s, Ma0_s, de0_s, dr0_s, da0_s, alt0_s], [alpha00, beta00, Ma00, de00, dr00, da00, alt00]);
B2_analysis = subs(B2_analysis, [alpha0_s, beta0_s, Ma0_s, de0_s, dr0_s, da0_s, alt0_s], [alpha00, beta00, Ma00, de00, dr00, da00, alt00]);

% 替换平衡点的气动导数
A1_analysis = subs(A1_analysis, Cd_s, Cd_n);
B1_analysis = subs(B1_analysis, Cd_s, Cd_n);

A2_analysis = subs(A2_analysis, Cd_s, Cd_n); 
B2_analysis = subs(B2_analysis, Cd_s, Cd_n); 

% 替换平衡点的状态和控制
A1_analysis = subs(A1_analysis, X', X0);
B1_analysis = subs(B1_analysis, X', X0);
A1_analysis = subs(A1_analysis, U', U0);
B1_analysis = subs(B1_analysis, U', U0);

A2_analysis = subs(A2_analysis, X', X0);
B2_analysis = subs(B2_analysis, X', X0);
A2_analysis = subs(A2_analysis, U', U0);
B2_analysis = subs(B2_analysis, U', U0);

% 替换飞行器特性常数
A1_analysis = subs(A1_analysis, constant_s, constant);
B1_analysis = subs(B1_analysis, constant_s, constant);
A1_analysis = subs(A1_analysis,CP_s,CP);
B1_analysis = subs(B1_analysis,CP_s,CP);
A1_analysis = subs(A1_analysis,CG_s,CG);
B1_analysis = subs(B1_analysis,CG_s,CG);

A2_analysis = subs(A2_analysis, constant_s, constant);
B2_analysis = subs(B2_analysis, constant_s, constant);
A2_analysis = subs(A2_analysis,CP_s,CP);
B2_analysis = subs(B2_analysis,CP_s,CP);
A2_analysis = subs(A2_analysis,CG_s,CG);
B2_analysis = subs(B2_analysis,CG_s,CG);

% 转数值
A1_analysis = double(A1_analysis);
B1_analysis = double(B1_analysis);

A2_analysis = double(A2_analysis);
B2_analysis = double(B2_analysis);
