clearvars;
close all;
%% 
syms Mx My Mz p_dot q_dot r_dot p q r ...
    Ixx Iyy Izz Ixy Ixz Iyz Iyx Izx Izy

%% 方程组
eq1 = Mx == Ixx*p_dot + Ixy*q_dot + Ixz*r_dot ...
       - r*(Iyx*p + Iyy*q + Iyz*r) ...
       + q*(Izx*p + Izy*q + Izz*r);

eq2 = My == Iyx*p_dot + Iyy*q_dot + Iyz*r_dot ...
       + r*(Ixx*p + Ixy*q + Ixz*r) ...
       - p*(Izx*p + Izy*q + Izz*r);

eq3 = Mz == Izx*p_dot + Izy*q_dot + Izz*r_dot ...
       - q*(Ixx*p + Ixy*q + Ixz*r) ...
       + p*(Iyx*p + Iyy*q + Iyz*r);

sol = solve([eq1, eq2, eq3], [p_dot, q_dot, r_dot]);

items = [Mx, My, Mz, p^2, q^2, r^2, p*q, q*r, p*r];

p_dot_collected = collect(sol.p_dot, items);
q_dot_collected = collect(sol.q_dot, items);
r_dot_collected = collect(sol.r_dot, items);

