
%% 小扰动范围
range_alpha = 3;
range_beta = 3;
range_Ma = 0.02;
range_de = 3;
range_dr = 3;
range_da = 3;
range_alt = 100;
%% 定义评估系数
global EvaluateTable idx epsilon;
idx = 0;
EvaluateTable = zeros(3,32);
epsilon = 0.6;

run("Derivatives.m");
%% 评估CD_base
% disp('CD_base -- alpha Ma beta:');
CalculateInfluence(CD_base_alphar, range_alpha, CD_base0);
CalculateInfluence(CD_base_Mar, range_Ma, CD_base0);
CalculateInfluence(CD_base_betar, range_beta, CD_base0);
% fprintf("\n");

%% 评估CY_base
% disp('CY_base -- alpha Ma beta:');
CalculateInfluence(CY_base_alphar, range_alpha, CY_base0);
CalculateInfluence(CY_base_Mar, range_Ma, CY_base0);
CalculateInfluence(CY_base_betar, range_beta, CY_base0);
% fprintf("\n");

%% 评估CL_base
% disp('CL_base -- alpha Ma beta:');
CalculateInfluence(CL_base_alphar, range_alpha, CL_base0);
CalculateInfluence(CL_base_Mar, range_Ma, CL_base0);
CalculateInfluence(CL_base_betar, range_beta, CL_base0);
% fprintf("\n");

%% 评估Cl_base
% disp('Cl_base -- alpha Ma beta:');
CalculateInfluence(Cl_base_alphar, range_alpha, Cl_base0);
CalculateInfluence(Cl_base_Mar, range_Ma, Cl_base0);
CalculateInfluence(Cl_base_betar, range_beta, Cl_base0);
% fprintf("\n");

%% 评估Cm_base
% disp('Cm_base -- alpha Ma beta:');
CalculateInfluence(Cm_base_alphar, range_alpha, Cm_base0);
CalculateInfluence(Cm_base_Mar, range_Ma, Cm_base0);
CalculateInfluence(Cm_base_betar, range_beta, Cm_base0);
% fprintf("\n");

%% 评估Cn_base
% disp('Cn_base -- alpha Ma beta:');
CalculateInfluence(Cn_base_alphar, range_alpha, Cn_base0);
CalculateInfluence(Cn_base_Mar, range_Ma, Cn_base0);
CalculateInfluence(Cn_base_betar, range_beta, Cn_base0);
% fprintf("\n");

%% 评估CD_de
% disp('CD_de -- alpha Ma de')
CalculateInfluence(CD_de_alphar, range_alpha, CD_de0);
CalculateInfluence(CD_de_Mar, range_Ma, CD_de0);
CalculateInfluence(CD_de_der, range_de, CD_de0);
% fprintf("\n");

%% 评估CY_de
% disp('CY_de -- alpha Ma de')
CalculateInfluence(CY_de_alphar, range_alpha, CY_de0);
CalculateInfluence(CY_de_Mar, range_Ma, CY_de0);
CalculateInfluence(CY_de_der, range_de, CY_de0);
% fprintf("\n");

%% 评估CL_de
% disp('CL_de -- alpha Ma de')
CalculateInfluence(CL_de_alphar, range_alpha, CL_de0);
CalculateInfluence(CL_de_Mar, range_Ma, CL_de0);
CalculateInfluence(CL_de_der, range_de, CL_de0);
% fprintf("\n");

%% 评估Cl_de
% disp('Cl_de -- alpha Ma de')
CalculateInfluence(Cl_de_alphar, range_alpha, Cl_de0);
CalculateInfluence(Cl_de_Mar, range_Ma, Cl_de0);
CalculateInfluence(Cl_de_der, range_de, Cl_de0);
% fprintf("\n");

%% 评估Cm_de
% disp('Cm_de -- alpha Ma de')
CalculateInfluence(Cm_de_alphar, range_alpha, Cm_de0);
CalculateInfluence(Cm_de_Mar, range_Ma, Cm_de0);
CalculateInfluence(Cm_de_der, range_de, Cm_de0);
% fprintf("\n");

%% 评估Cn_de
% disp('Cn_de -- alpha Ma de')
CalculateInfluence(Cn_de_alphar, range_alpha, Cn_de0);
CalculateInfluence(Cn_de_Mar, range_Ma, Cn_de0);
CalculateInfluence(Cn_de_der, range_de, Cn_de0);
% fprintf("\n");

%% 评估CD_dr
% disp('CD_dr -- alpha Ma dr')
CalculateInfluence(CD_dr_alphar, range_alpha, CD_dr0);
CalculateInfluence(CD_dr_Mar, range_Ma, CD_dr0);
CalculateInfluence(CD_dr_drr, range_dr, CD_dr0);
% fprintf("\n");

%% 评估CY_dr
% disp('CY_dr -- alpha Ma dr')
CalculateInfluence(CY_dr_alphar, range_alpha, CY_dr0);
CalculateInfluence(CY_dr_Mar, range_Ma, CY_dr0);
CalculateInfluence(CY_dr_drr, range_dr, CY_dr0);
% fprintf("\n");

%% 评估CL_dr
% disp('CL_dr -- alpha Ma dr')
CalculateInfluence(CL_dr_alphar, range_alpha, CL_dr0);
CalculateInfluence(CL_dr_Mar, range_Ma, CL_dr0);
CalculateInfluence(CL_dr_drr, range_dr, CL_dr0);
% fprintf("\n");

%% 评估Cl_dr
% disp('Cl_dr -- alpha Ma dr')
CalculateInfluence(Cl_dr_alphar, range_alpha, Cl_dr0);
CalculateInfluence(Cl_dr_Mar, range_Ma, Cl_dr0);
CalculateInfluence(Cl_dr_drr, range_dr, Cl_dr0);
% fprintf("\n");

%% 评估Cm_dr
% disp('Cm_dr -- alpha Ma dr')
CalculateInfluence(Cm_dr_alphar, range_alpha, Cm_dr0);
CalculateInfluence(Cm_dr_Mar, range_Ma, Cm_dr0);
CalculateInfluence(Cm_dr_drr, range_dr, Cm_dr0);
% fprintf("\n");

%% 评估Cn_dr
% disp('Cn_dr -- alpha Ma dr')
CalculateInfluence(Cn_dr_alphar, range_alpha, Cn_dr0);
CalculateInfluence(Cn_dr_Mar, range_Ma, Cn_dr0);
CalculateInfluence(Cn_dr_drr, range_dr, Cn_dr0);
% fprintf("\n");

%% 评估CD_da
% disp('CD_da -- alpha Ma da')
CalculateInfluence(CD_da_alphar, range_alpha, CD_da0);
CalculateInfluence(CD_da_Mar, range_Ma, CD_da0);
CalculateInfluence(CD_da_dar, range_da, CD_da0);
% fprintf("\n");

%% 评估CY_da
% disp('CY_da -- alpha Ma da')
CalculateInfluence(CY_da_alphar, range_alpha, CY_da0);
CalculateInfluence(CY_da_Mar, range_Ma, CY_da0);
CalculateInfluence(CY_da_dar, range_da, CY_da0);
% fprintf("\n");

%% 评估CL_da
% disp('CL_da -- alpha Ma da')
CalculateInfluence(CL_da_alphar, range_alpha, CL_da0);
CalculateInfluence(CL_da_Mar, range_Ma, CL_da0);
CalculateInfluence(CL_da_dar, range_da, CL_da0);
% fprintf("\n");

%% 评估Cl_da
% disp('Cl_da -- alpha Ma da')
CalculateInfluence(Cl_da_alphar, range_alpha, Cl_da0);
CalculateInfluence(Cl_da_Mar, range_Ma, Cl_da0);
CalculateInfluence(Cl_da_dar, range_da, Cl_da0);
% fprintf("\n");

%% 评估Cm_da
% disp('Cm_da -- alpha Ma da')
CalculateInfluence(Cm_da_alphar, range_alpha, Cm_da0);
CalculateInfluence(Cm_da_Mar, range_Ma, Cm_da0);
CalculateInfluence(Cm_da_dar, range_da, Cm_da0);
% fprintf("\n");

%% 评估Cn_da
% disp('Cn_da -- alpha Ma da')
CalculateInfluence(Cn_da_alphar, range_alpha, Cn_da0);
CalculateInfluence(Cn_da_Mar, range_Ma, Cn_da0);
CalculateInfluence(Cn_da_dar, range_da, Cn_da0);
% fprintf("\n");

%% 评估Cmq
% disp('Cmq -- alpha Ma alt')
CalculateInfluence(Cmq_alphar, range_alpha, Cmq0);
CalculateInfluence(Cmq_Mar, range_Ma, Cmq0);
CalculateInfluence(Cmq_altr, range_alt, Cmq0);
% fprintf("\n");

%% 评估CLAlphadot
% disp('CLAlphadot -- alpha Ma alt')
CalculateInfluence(CLAlphadot_alphar, range_alpha, CLAlphadot0);
CalculateInfluence(CLAlphadot_Mar, range_Ma, CLAlphadot0);
CalculateInfluence(CLAlphadot_altr, range_alt, CLAlphadot0);
% fprintf("\n");

%% 评估CmAlphadot
% disp('CmAlphadot -- alpha Ma alt')
CalculateInfluence(CmAlphadot_alphar, range_alpha, CmAlphadot0);
CalculateInfluence(CmAlphadot_Mar, range_Ma, CmAlphadot0);
CalculateInfluence(CmAlphadot_altr, range_alt, CmAlphadot0);
% fprintf("\n");

%% 评估Clp
% disp('Clp -- alpha Ma alt')
CalculateInfluence(Clp_alphar, range_alpha, Clp0);
CalculateInfluence(Clp_Mar, range_Ma, Clp0);
CalculateInfluence(Clp_altr, range_alt, Clp0);
% fprintf("\n");

%% 评估CYp
% disp('CYp -- alpha Ma alt')
CalculateInfluence(CYp_alphar, range_alpha, CYp0);
CalculateInfluence(CYp_Mar, range_Ma, CYp0);
CalculateInfluence(CYp_altr, range_alt, CYp0);
% fprintf("\n");

%% 评估Cnp
% disp('Cnp -- alpha Ma alt')
CalculateInfluence(Cnp_alphar, range_alpha, Cnp0);
CalculateInfluence(Cnp_Mar, range_Ma, Cnp0);
CalculateInfluence(Cnp_altr, range_alt, Cnp0);
% fprintf("\n");

%% 评估Cnr
% disp('Cnr -- alpha Ma alt')
CalculateInfluence(Cnr_alphar, range_alpha, Cnr0);
CalculateInfluence(Cnr_Mar, range_Ma, Cnr0);
CalculateInfluence(Cnr_altr, range_alt, Cnr0);
% fprintf("\n");

%% 评估Clr
% disp('Clr -- alpha Ma alt')
CalculateInfluence(Clr_alphar, range_alpha, Clr0);
CalculateInfluence(Clr_Mar, range_Ma, Clr0);
CalculateInfluence(Clr_altr, range_alt, Clr0);
% fprintf("\n");

