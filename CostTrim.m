%% 代价函数
function J = TrimCost(X,U)
    u=X(1); v=X(2); w=X(3);
    p=X(4); q=X(5); r=X(6);
    roll=X(7); pitch=X(8); yaw=X(9);
    xg=X(10); yg=X(11); zg=X(12);
    dT=U(1); de=U(2); dr=U(3); da=U(4);
    force_p1=evalin('base','force_p1');force_p2=evalin('base','force_p2');
    torque_p1=evalin('base','torque_p1');torque_p2=evalin('base','torque_p2');
    aeroData=evalin('base','aeroData');
    c1=evalin('base','c1');c2=evalin('base','c2');c3=evalin('base','c3');
    c4=evalin('base','c4');c5=evalin('base','c5');c6=evalin('base','c6');
    c7=evalin('base','c7');c8=evalin('base','c8');c9=evalin('base','c9');
    c10=evalin('base','c10');c11=evalin('base','c11');c12=evalin('base','c12');
    c13=evalin('base','c13');c14=evalin('base','c14');c15=evalin('base','c15');
    c16=evalin('base','c16');c17=evalin('base','c17');c18=evalin('base','c18');
    c19=evalin('base','c19');c20=evalin('base','c20');c21=evalin('base','c21');
    c22=evalin('base','c22');c23=evalin('base','c23');c24=evalin('base','c24');
    c25=evalin('base','c25');c26=evalin('base','c26');c27=evalin('base','c27');
    S=evalin('base','S');b=evalin('base','b');cbar=evalin('base','cbar');
    Mass=evalin('base','Mass');CG=evalin('base','CG');CP=evalin('base','CP');
    g = 9.80665;

    % 值约束
    J1 = p^2 + q^2 + r^2;
    J2 = (sqrt(u^2+w^2)-40)^2 + v^2;
    J3 = yg^2 + (zg+500)^2;

    % 导航约束
    CEB=[                cos(pitch)*cos(yaw),     cos(pitch)*sin(yaw),               -sin(pitch);
        sin(pitch)*cos(yaw)*sin(roll)-sin(yaw)*cos(roll),sin(pitch)*sin(yaw)*sin(roll)+cos(yaw)*cos(roll),cos(pitch)*sin(roll);
        sin(pitch)*cos(yaw)*cos(roll)+sin(yaw)*sin(roll),sin(pitch)*sin(yaw)*cos(roll)-cos(yaw)*sin(roll),cos(pitch)*cos(roll)];
    Xg_dot = CEB'*[u;v;w];
    J4 = Xg_dot(2)^2 + Xg_dot(3)^2;

    % 运动约束
    A = [1,   sin(roll)*tan(pitch), cos(roll)*tan(pitch);
        0,   cos(roll),        -sin(roll);
        0,   sin(roll)/cos(pitch), cos(roll)/cos(pitch)];
    attitude_dot = A * [p; q; r];
    J5 = attitude_dot(1)^2 + attitude_dot(2)^2 + attitude_dot(3)^2;


    alpha = atan2d(w, u); beta  = atan2d(v, sqrt(u^2 + w^2));
    T = 288.15 + 0.0065*zg;
    a=sqrt(1.4*287.04*T);
    P = 101325*(1 + 0.0065*zg/288.15)^5.2561;
    rho=P/(287.04*T);
    Ma = sqrt(u^2 + v^2 + w^2) / a;
    force = abs(force_p1*dT + force_p2)*sign(dT); torque = abs(torque_p1*dT + torque_p2)*sign(dT);

    % 放在 alpha, beta, Ma 计算完后
    if ~isreal([Ma, alpha, beta]) || any(isnan([Ma, alpha, beta])) || any(isinf([Ma, alpha, beta]))
        J = 1e10;
        return
    end

% 再限制范围防止插值越界
    Ma    = max(min(Ma,    max(aeroData.Vec_Ma)),    min(aeroData.Vec_Ma));
    alpha = max(min(alpha, max(aeroData.Vec_alpha)), min(aeroData.Vec_alpha));
    beta  = max(min(beta,  max(aeroData.Vec_beta)),  min(aeroData.Vec_beta));


    CD_base = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma, alpha, beta,'linear');
    CY_base = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma, alpha, beta,'linear');
    CL_base = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma, alpha, beta,'linear');
    Cl_base = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma, alpha, beta,'linear');
    Cm_base = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma, alpha, beta,'linear');
    Cn_base = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma, alpha, beta,'linear');

    CD_de = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma, alpha, de,'linear');
    CY_de = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma, alpha, de,'linear');
    CL_de = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma, alpha, de,'linear');
    Cl_de = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma, alpha, de,'linear');
    Cm_de = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma, alpha, de,'linear');
    Cn_de = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma, alpha, de,'linear');

    CD_dr = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma, alpha, dr,'linear');
    CY_dr = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma, alpha, dr,'linear');
    CL_dr = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma, alpha, dr,'linear');
    Cl_dr = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma, alpha, dr,'linear');
    Cm_dr = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma, alpha, dr,'linear');
    Cn_dr = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma, alpha, dr,'linear');

    CD_da = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma, alpha, da,'linear');
    CY_da = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma, alpha, da,'linear');
    CL_da = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma, alpha, da,'linear');
    Cl_da = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma, alpha, da,'linear');
    Cm_da = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma, alpha, da,'linear');
    Cn_da = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma, alpha, da,'linear');

    V2 = u^2 + v^2 + w^2;

    D=0.5*rho*V2*S*(CD_base + CD_de + CD_dr + CD_da);
    Y=0.5*rho*V2*S*(CY_base + CY_de + CY_dr + CY_da);
    L=0.5*rho*V2*S*(CL_base + CL_de + CL_dr + CL_da);
    l=0.5*rho*V2*S*b*(Cl_base + Cl_de + Cl_dr + Cl_da);
    m=0.5*rho*V2*S*cbar*(Cm_base + Cm_de + Cm_dr + Cm_da);
    n=0.5*rho*V2*S*b*(Cn_base + Cn_de + Cn_dr + Cn_da);
    Faw=[-D; Y; -L]; MaH=[l; m; n];

    Cbw=[cosd(alpha)*cosd(beta) -cosd(alpha)*sind(beta) -sind(alpha);
         sind(beta)             cosd(beta)              0;
         sind(alpha)*cosd(beta) -sind(alpha)*sind(beta) cosd(alpha)];
    Fa = Cbw*Faw;

    rOH = CP-CG;    rOH=rOH';
    M_a = MaH + cross(rOH, Fa);
    F = Fa + [force; 0; 0]; M = M_a + [torque; 0; 0];

    % 力约束
    Fx = F(1); Fy = F(2); Fz = F(3);
    J6 = (Fx/Mass + v*r - w*q - g*sin(pitch))^2 + ...
        (Fy/Mass + w*p - u*r + g*sin(roll)*cos(pitch))^2 + ...
        (Fz/Mass + u*q - v*p + g*cos(roll)*cos(pitch))^2;
        
    % 力矩约束
    Mx = M(1); My = M(2); Mz = M(3);
    J7 = (c1*Mx + c2*My + c3*Mz + c4*p^2 + c5*q^2 + c6*r^2 +c7*p*q + c8*q*r + c9*p*r)^2 + ...
        (c10*Mx + c11*My + c12*Mz + c13*p^2 + c14*q^2 + c15*r^2 +c16*p*q + c17*q*r + c18*p*r)^2 + ...
        (c19*Mx + c20*My + c21*Mz + c22*p^2 + c23*q^2 + c24*r^2 +c25*p*q + c26*q*r + c27*p*r)^2;

    J = J1 + J2 + J3 + J4 + J5 + J6 + J7;
end

function J = FullTrimCost(Z)
    X = Z(1:12);
    U = Z(13:16);
    J = TrimCost(X, U);
end

%% 主函数
Z0 = [
    39.959;         0;      1.8114;
    0;              0;      0;
    -1.7997e-04;    0.0453; -8.1498e-06;
    2.8543e-14;     0;      -500; 
    0.2489;         9.2462; -0.017996;  -0.056254
];

lb = [-Inf*ones(12,1); -1; -15; -15; -15];   % 控制输入有边界
ub = [ Inf*ones(12,1);  1;  15;  15;  15];

options = optimoptions('fmincon', ...
    'Display', 'iter', ...
    'Algorithm', 'sqp', ...
    'MaxIterations', 400);

[Z_opt, J_opt] = fmincon(@FullTrimCost, Z0, [], [], [], [], lb, ub, [], options);

X_opt = Z_opt(1:12);
U_opt = Z_opt(13:16);
X_opt'
U_opt'
