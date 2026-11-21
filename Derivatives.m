load aeroData_HGDGUO.mat;
%% Readme
% 气动系数base是 alpha Ma beta的函数
% 舵效（如升降舵）是 alpha Ma dr的函数
% 动导数是 alpha Ma alt的函数，但是alt对动导数的影响很小。
% 平衡点处alpha beta Ma alt dr dr da，以及base、舵效和动导数由全量非线性模型在配平状态下仿真，步进运行第一步获得。
% 此脚本用查表插值的方法，计算base、舵效和动导数对各自变量的偏导数，以用于解析线性化分析。
% 注意，matlab中处理网格数据时，xyz顺序输入向量得到的网格尺寸为yxz
% 计算左导数和右导数，分别用-h和h表示
%% 脚本输入
% 使用时只需要修改此部分
% 平衡点状态 [alpha beta Ma alt de dr da] alpha beta de dr da单位为°，alt单位为m
alpha0 = 2.596; beta0 = 0; Ma0 = 0.1182; alt0 = 500; de0 = 9.2462; dr0 = -0.017996; da0 = -0.056254;

h = 0.01;

%% 平衡状态下各系数
CD_base0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0,'linear');
CY_base0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0,'linear');
CL_base0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0,'linear');
Cl_base0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0,'linear');
Cm_base0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0,'linear');
Cn_base0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0,'linear');

CD_de0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0,'linear');
CY_de0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0,'linear');
CL_de0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0,'linear');
Cl_de0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0,'linear');
Cm_de0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0,'linear');
Cn_de0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0,'linear');

CD_dr0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0,'linear');
CY_dr0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0,'linear');
CL_dr0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0,'linear');
Cl_dr0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0,'linear');
Cm_dr0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0,'linear');
Cn_dr0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0,'linear');

CD_da0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0,'linear');
CY_da0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0,'linear');
CL_da0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0,'linear');
Cl_da0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0,'linear');
Cm_da0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0,'linear');
Cn_da0 = interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0,'linear');

Cmq0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');
CLAlphadot0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');
CmAlphadot0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');
Clp0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');
CYp0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');
Cnp0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');
Cnr0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');
Clr0 = interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear');

%% Base
%CD
CD_base_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0+h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
CD_base_betar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
CD_base_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0+h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);

CD_base_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0-h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
CD_base_betal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
CD_base_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0-h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CD_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);

%CY
CY_base_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0+h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
CY_base_betar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
CY_base_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0+h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);

CY_base_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0-h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
CY_base_betal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
CY_base_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0-h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CY_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);

%CL
CL_base_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0+h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
CL_base_betar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
CL_base_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0+h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);

CL_base_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0-h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
CL_base_betal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
CL_base_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0-h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.CL_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);

%Cl
Cl_base_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0+h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
Cl_base_betar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
Cl_base_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0+h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);

Cl_base_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0-h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
Cl_base_betal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
Cl_base_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0-h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cl_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);

%Cm
Cm_base_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0+h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
Cm_base_betar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
Cm_base_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0+h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);

Cm_base_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0-h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
Cm_base_betal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
Cm_base_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0-h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cm_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);

%Cn
Cn_base_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0+h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
Cn_base_betar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);
Cn_base_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0+h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(h);

Cn_base_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0-h, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
Cn_base_betal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);
Cn_base_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0-h, alpha0, beta0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_beta, aeroData.Cn_alpha_Ma_beta, Ma0, alpha0, beta0,'linear'))/(-h);


%% de
%CD
CD_de_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0+h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
CD_de_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0+h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
CD_de_der = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);

CD_de_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0-h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
CD_de_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0-h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
CD_de_del = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CD_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);

%CY
CY_de_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0+h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
CY_de_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0+h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
CY_de_der = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);

CY_de_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0-h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
CY_de_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0-h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
CY_de_del = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CY_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);

%CL
CL_de_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0+h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
CL_de_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0+h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
CL_de_der = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);

CL_de_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0-h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
CL_de_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0-h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
CL_de_del = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.CL_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);

%Cl
Cl_de_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0+h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
Cl_de_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0+h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
Cl_de_der = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);

Cl_de_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0-h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
Cl_de_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0-h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
Cl_de_del = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cl_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);

%Cm
Cm_de_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0+h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
Cm_de_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0+h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
Cm_de_der = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);

Cm_de_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0-h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
Cm_de_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0-h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
Cm_de_del = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cm_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);

%Cn
Cn_de_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0+h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
Cn_de_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0+h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);
Cn_de_der = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(h);

Cn_de_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0-h, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
Cn_de_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0-h, alpha0, de0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);
Cn_de_del = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_de, aeroData.Cn_alpha_Ma_de, Ma0, alpha0, de0,'linear'))/(-h);


%% dr
%CD
CD_dr_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0+h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
CD_dr_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0+h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
CD_dr_drr = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);

CD_dr_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0-h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
CD_dr_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0-h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
CD_dr_drl = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CD_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);

%CY
CY_dr_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0+h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
CY_dr_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0+h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
CY_dr_drr = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);

CY_dr_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0-h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
CY_dr_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0-h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
CY_dr_drl = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CY_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);

%CL
CL_dr_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0+h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
CL_dr_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0+h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
CL_dr_drr = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);

CL_dr_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0-h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
CL_dr_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0-h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
CL_dr_drl = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.CL_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);

%Cl
Cl_dr_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0+h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
Cl_dr_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0+h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
Cl_dr_drr = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);

Cl_dr_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0-h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
Cl_dr_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0-h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
Cl_dr_drl = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cl_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);

%Cm
Cm_dr_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0+h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
Cm_dr_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0+h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
Cm_dr_drr = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);

Cm_dr_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0-h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
Cm_dr_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0-h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
Cm_dr_drl = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cm_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);

%Cn
Cn_dr_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0+h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
Cn_dr_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0+h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);
Cn_dr_drr = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(h);

Cn_dr_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0-h, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
Cn_dr_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0-h, alpha0, dr0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);
Cn_dr_drl = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_dr, aeroData.Cn_alpha_Ma_dr, Ma0, alpha0, dr0,'linear'))/(-h);


%% da
%CD
CD_da_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0+h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
CD_da_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0+h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
CD_da_dar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);

CD_da_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0-h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
CD_da_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0-h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
CD_da_dal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CD_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);

%CY
CY_da_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0+h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
CY_da_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0+h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
CY_da_dar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);

CY_da_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0-h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
CY_da_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0-h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
CY_da_dal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CY_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);

%CL
CL_da_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0+h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
CL_da_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0+h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
CL_da_dar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);

CL_da_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0-h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
CL_da_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0-h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
CL_da_dal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.CL_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);

%Cl
Cl_da_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0+h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
Cl_da_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0+h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
Cl_da_dar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);

Cl_da_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0-h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
Cl_da_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0-h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
Cl_da_dal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cl_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);

%Cm
Cm_da_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0+h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
Cm_da_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0+h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
Cm_da_dar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);

Cm_da_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0-h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
Cm_da_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0-h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
Cm_da_dal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cm_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);

%Cn
Cn_da_alphar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0+h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
Cn_da_Mar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0+h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);
Cn_da_dar = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0+h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(h);

Cn_da_alphal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0-h, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
Cn_da_Mal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0-h, alpha0, da0,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
Cn_da_dal = (interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0-h,'linear')...
    - interp3(aeroData.Vec_Ma, aeroData.Vec_alpha, aeroData.Vec_da, aeroData.Cn_alpha_Ma_da, Ma0, alpha0, da0,'linear'))/(-h);
%% 动导数
%Cmq
Cmq_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Cmq_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Cmq_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

Cmq_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Cmq_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Cmq_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cmq_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

%CLAlphadot
CLAlphadot_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
CLAlphadot_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
CLAlphadot_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

CLAlphadot_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
CLAlphadot_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
CLAlphadot_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CLAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

%CmAlphadot
CmAlphadot_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
CmAlphadot_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
CmAlphadot_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

CmAlphadot_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
CmAlphadot_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
CmAlphadot_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CmAlphadot_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

%Clp
Clp_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Clp_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Clp_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

Clp_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Clp_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Clp_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

%CYp
CYp_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
CYp_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
CYp_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

CYp_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
CYp_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
CYp_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.CYp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

%Cnp
Cnp_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Cnp_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Cnp_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

Cnp_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Cnp_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Cnp_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnp_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

%Cnr
Cnr_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Cnr_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Cnr_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

Cnr_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Cnr_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Cnr_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Cnr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

%Clr
Clr_alphar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0+h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Clr_Mar = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0+h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);
Clr_altr = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0+h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(h);

Clr_alphal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0-h, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Clr_Mal = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0-h, alpha0, alt0,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);
Clr_altl = (interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0-h,'linear')...
    - interp3(aeroData.Vec_Ma2, aeroData.Vec_alpha2, aeroData.Vec_alt, aeroData.Clr_alpha_Ma_alt, Ma0, alpha0, alt0,'linear'))/(-h);

% %% base输出Excel
% data1 = {
%     '',         'CD',        '',          'CY',        '',          'CL',        '',          'Cl',        '',          'Cm',        '',          'Cn',        '';
%     '',         'CD-l',      'CD-r',      'CY-l',      'CY-r',      'CL-l',      'CL-r',      'Cl-l',      'Cl-r',      'Cm-l',      'Cm-r',      'Cn-l',      'Cn-r';
%     'alpha',    CD_base_alphal, CD_base_alphar, CY_base_alphal, CY_base_alphar, CL_base_alphal, CL_base_alphar, Cl_base_alphal, Cl_base_alphar, Cm_base_alphal, Cm_base_alphar, Cn_base_alphal, Cn_base_alphar;
%     'Ma',       CD_base_Mal,    CD_base_Mar,    CY_base_Mal,    CY_base_Mar,    CL_base_Mal,    CL_base_Mar,    Cl_base_Mal,    Cl_base_Mar,    Cm_base_Mal,    Cm_base_Mar,    Cn_base_Mal,    Cn_base_Mar;
%     'beta',     CD_base_betal,  CD_base_betar,  CY_base_betal,  CY_base_betar,  CL_base_betal,  CL_base_betar,  Cl_base_betal,  Cl_base_betar,  Cm_base_betal,  Cm_base_betar,  Cn_base_betal,  Cn_base_betar;
% };
% 
% % 写入 Excel 文件
% filename = 'base.xlsx';
% writecell(data1, filename);
% 
% % 使用 ActiveX 操作 Excel：设置列宽、科学计数法、合并单元格
% excelApp = actxserver('Excel.Application');
% excelApp.Visible = false;
% 
% workbook = excelApp.Workbooks.Open(fullfile(pwd, filename));
% sheet = workbook.Sheets.Item(1);
% sheet.Name = 'base';
% 
% % 设置统一列宽
% sheet.Columns.Item('A:M').ColumnWidth = 15;
% 
% % 设置科学计数法格式（第3到第5行）
% sheet.Range('A3:M5').NumberFormat = '0.00000E+00';
% 
% % 合并单元格（第1行每组2列）
% mergeRanges = {'B1:C1', 'D1:E1', 'F1:G1', 'H1:I1', 'J1:K1', 'L1:M1'};
% titles = {'CD', 'CY', 'CL', 'Cl', 'Cm', 'Cn'};
% 
% for i = 1:length(mergeRanges)
%     sheet.Range(mergeRanges{i}).Merge();
%     sheet.Range(mergeRanges{i}).HorizontalAlignment = -4108;  % 居中
%     sheet.Range(mergeRanges{i}).VerticalAlignment = -4108;
%     sheet.Range(mergeRanges{i}).Value = titles{i};
% end
% 
% % 保存并关闭
% workbook.Save();
% workbook.Close();
% excelApp.Quit();
% 
% disp('数据已写入 base.xlsx');
% 
% %% de输出Excel
% data2 = {
%     '',         'CD',        '',          'CY',        '',          'CL',        '',          'Cl',        '',          'Cm',        '',          'Cn',        '';
%     '',         'CD-l',      'CD-r',      'CY-l',      'CY-r',      'CL-l',      'CL-r',      'Cl-l',      'Cl-r',      'Cm-l',      'Cm-r',      'Cn-l',      'Cn-r';
%     'alpha',    CD_de_alphal, CD_de_alphar, CY_de_alphal, CY_de_alphar, CL_de_alphal, CL_de_alphar, Cl_de_alphal, Cl_de_alphar, Cm_de_alphal, Cm_de_alphar, Cn_de_alphal, Cn_de_alphar;
%     'Ma',       CD_de_Mal,    CD_de_Mar,    CY_de_Mal,    CY_de_Mar,    CL_de_Mal,    CL_de_Mar,    Cl_de_Mal,    Cl_de_Mar,    Cm_de_Mal,    Cm_de_Mar,    Cn_de_Mal,    Cn_de_Mar;
%     'de',     CD_de_del,  CD_de_der,  CY_de_del,  CY_de_der,  CL_de_del,  CL_de_der,  Cl_de_del,  Cl_de_der,  Cm_de_del,  Cm_de_der,  Cn_de_del,  Cn_de_der;
% };
% 
% % 写入 Excel 文件
% filename = 'de.xlsx';
% writecell(data2, filename);
% 
% % 使用 ActiveX 操作 Excel：设置列宽、科学计数法、合并单元格
% excelApp = actxserver('Excel.Application');
% excelApp.Visible = false;
% 
% workbook = excelApp.Workbooks.Open(fullfile(pwd, filename));
% sheet = workbook.Sheets.Item(1);
% sheet.Name = 'de';
% 
% % 设置统一列宽
% sheet.Columns.Item('A:M').ColumnWidth = 15;
% 
% % 设置科学计数法格式（第3到第5行）
% sheet.Range('A3:M5').NumberFormat = '0.00000E+00';
% 
% % 合并单元格（第1行每组2列）
% mergeRanges = {'B1:C1', 'D1:E1', 'F1:G1', 'H1:I1', 'J1:K1', 'L1:M1'};
% titles = {'CD', 'CY', 'CL', 'Cl', 'Cm', 'Cn'};
% 
% for i = 1:length(mergeRanges)
%     sheet.Range(mergeRanges{i}).Merge();
%     sheet.Range(mergeRanges{i}).HorizontalAlignment = -4108;  % 居中
%     sheet.Range(mergeRanges{i}).VerticalAlignment = -4108;
%     sheet.Range(mergeRanges{i}).Value = titles{i};
% end
% 
% % 保存并关闭
% workbook.Save();
% workbook.Close();
% excelApp.Quit();
% 
% disp('数据已写入 de.xlsx');
% 
% %% dr输出Excel
% data3 = {
%     '',         'CD',        '',          'CY',        '',          'CL',        '',          'Cl',        '',          'Cm',        '',          'Cn',        '';
%     '',         'CD-l',      'CD-r',      'CY-l',      'CY-r',      'CL-l',      'CL-r',      'Cl-l',      'Cl-r',      'Cm-l',      'Cm-r',      'Cn-l',      'Cn-r';
%     'alpha',    CD_dr_alphal, CD_dr_alphar, CY_dr_alphal, CY_dr_alphar, CL_dr_alphal, CL_dr_alphar, Cl_dr_alphal, Cl_dr_alphar, Cm_dr_alphal, Cm_dr_alphar, Cn_dr_alphal, Cn_dr_alphar;
%     'Ma',       CD_dr_Mal,    CD_dr_Mar,    CY_dr_Mal,    CY_dr_Mar,    CL_dr_Mal,    CL_dr_Mar,    Cl_dr_Mal,    Cl_dr_Mar,    Cm_dr_Mal,    Cm_dr_Mar,    Cn_dr_Mal,    Cn_dr_Mar;
%     'dr',     CD_dr_drl,  CD_dr_drr,  CY_dr_drl,  CY_dr_drr,  CL_dr_drl,  CL_dr_drr,  Cl_dr_drl,  Cl_dr_drr,  Cm_dr_drl,  Cm_dr_drr,  Cn_dr_drl,  Cn_dr_drr;
% };
% 
% % 写入 Excel 文件
% filename = 'dr.xlsx';
% writecell(data3, filename);
% 
% % 使用 ActiveX 操作 Excel：设置列宽、科学计数法、合并单元格
% excelApp = actxserver('Excel.Application');
% excelApp.Visible = false;
% 
% workbook = excelApp.Workbooks.Open(fullfile(pwd, filename));
% sheet = workbook.Sheets.Item(1);
% sheet.Name = 'dr';
% 
% % 设置统一列宽
% sheet.Columns.Item('A:M').ColumnWidth = 15;
% 
% % 设置科学计数法格式（第3到第5行）
% sheet.Range('A3:M5').NumberFormat = '0.00000E+00';
% 
% % 合并单元格（第1行每组2列）
% mergeRanges = {'B1:C1', 'D1:E1', 'F1:G1', 'H1:I1', 'J1:K1', 'L1:M1'};
% titles = {'CD', 'CY', 'CL', 'Cl', 'Cm', 'Cn'};
% 
% for i = 1:length(mergeRanges)
%     sheet.Range(mergeRanges{i}).Merge();
%     sheet.Range(mergeRanges{i}).HorizontalAlignment = -4108;  % 居中
%     sheet.Range(mergeRanges{i}).VerticalAlignment = -4108;
%     sheet.Range(mergeRanges{i}).Value = titles{i};
% end
% 
% % 保存并关闭
% workbook.Save();
% workbook.Close();
% excelApp.Quit();
% 
% disp('数据已写入 dr.xlsx');
% 
% %% da输出Excel
% data4 = {
%     '',         'CD',        '',          'CY',        '',          'CL',        '',          'Cl',        '',          'Cm',        '',          'Cn',        '';
%     '',         'CD-l',      'CD-r',      'CY-l',      'CY-r',      'CL-l',      'CL-r',      'Cl-l',      'Cl-r',      'Cm-l',      'Cm-r',      'Cn-l',      'Cn-r';
%     'alpha',    CD_da_alphal, CD_da_alphar, CY_da_alphal, CY_da_alphar, CL_da_alphal, CL_da_alphar, Cl_da_alphal, Cl_da_alphar, Cm_da_alphal, Cm_da_alphar, Cn_da_alphal, Cn_da_alphar;
%     'Ma',       CD_da_Mal,    CD_da_Mar,    CY_da_Mal,    CY_da_Mar,    CL_da_Mal,    CL_da_Mar,    Cl_da_Mal,    Cl_da_Mar,    Cm_da_Mal,    Cm_da_Mar,    Cn_da_Mal,    Cn_da_Mar;
%     'da',     CD_da_dal,  CD_da_dar,  CY_da_dal,  CY_da_dar,  CL_da_dal,  CL_da_dar,  Cl_da_dal,  Cl_da_dar,  Cm_da_dal,  Cm_da_dar,  Cn_da_dal,  Cn_da_dar;
% };
% 
% % 写入 Excel 文件
% filename = 'da.xlsx';
% writecell(data4, filename);
% 
% % 使用 ActiveX 操作 Excel：设置列宽、科学计数法、合并单元格
% excelApp = actxserver('Excel.Application');
% excelApp.Visible = false;
% 
% workbook = excelApp.Workbooks.Open(fullfile(pwd, filename));
% sheet = workbook.Sheets.Item(1);
% sheet.Name = 'da';
% 
% % 设置统一列宽
% sheet.Columns.Item('A:M').ColumnWidth = 15;
% 
% % 设置科学计数法格式（第3到第5行）
% sheet.Range('A3:M5').NumberFormat = '0.00000E+00';
% 
% % 合并单元格（第1行每组2列）
% mergeRanges = {'B1:C1', 'D1:E1', 'F1:G1', 'H1:I1', 'J1:K1', 'L1:M1'};
% titles = {'CD', 'CY', 'CL', 'Cl', 'Cm', 'Cn'};
% 
% for i = 1:length(mergeRanges)
%     sheet.Range(mergeRanges{i}).Merge();
%     sheet.Range(mergeRanges{i}).HorizontalAlignment = -4108;  % 居中
%     sheet.Range(mergeRanges{i}).VerticalAlignment = -4108;
%     sheet.Range(mergeRanges{i}).Value = titles{i};
% end
% 
% % 保存并关闭
% workbook.Save();
% workbook.Close();
% excelApp.Quit();
% 
% disp('数据已写入 da.xlsx');
% 
% %% 动导数输出Excel
% data5 = {
%     '',         'Cmq',        '',             'CLAlphadot', '',             'CmAlphadot', '',           'Clp',        '',         'CYp',        '',         'Cnp',        '',         'Cnr',        '',         'Clr',        '';
%     '',         'Cmq-l',      'Cmq-r',        'CLAlphadot-l', 'CLAlphadot-r', 'CmAlphadot-l', 'CmAlphadot-r', 'Clp-l', 'Clp-r', 'CYp-l', 'CYp-r', 'Cnp-l', 'Cnp-r', 'Cnr-l', 'Cnr-r', 'Clr-l', 'Clr-r';
%     'alpha',    Cmq_alphal, Cmq_alphar, CLAlphadot_alphal, CLAlphadot_alphar, CmAlphadot_alphal, CmAlphadot_alphar, Clp_alphal, Clp_alphar, CYp_alphal, CYp_alphar, Cnp_alphal, Cnp_alphar, Cnr_alphal, Cnr_alphar, Clr_alphal, Clr_alphar;
%     'Ma',       Cmq_Mal,    Cmq_Mar,    CLAlphadot_Mal,    CLAlphadot_Mar,    CmAlphadot_Mal,    CmAlphadot_Mar,    Clp_Mal,    Clp_Mar,    CYp_Mal,    CYp_Mar,    Cnp_Mal,    Cnp_Mar,    Cnr_Mal,    Cnr_Mar,    Clr_Mal,    Clr_Mar;
%     'alt',      Cmq_altl,   Cmq_altr,   CLAlphadot_altl,   CLAlphadot_altr,   CmAlphadot_altl,   CmAlphadot_altr,   Clp_altl,   Clp_altr,   CYp_altl,   CYp_altr,   Cnp_altl,   Cnp_altr,   Cnr_altl,   Cnr_altr,   Clr_altl,   Clr_altr;
% };
% 
% % 写入 Excel 文件
% filename = 'DynamicDerivatives.xlsx';
% writecell(data5, filename);
% 
% % Excel ActiveX 设置格式
% excelApp = actxserver('Excel.Application');
% excelApp.Visible = false;
% 
% workbook = excelApp.Workbooks.Open(fullfile(pwd, filename));
% sheet = workbook.Sheets.Item(1);
% sheet.Name = 'DynamicDerivatives';
% 
% % 设置统一列宽（A:R）
% sheet.Columns.Item('A:R').ColumnWidth = 15;
% 
% % 设置科学计数法格式（第3到第5行）
% sheet.Range('A3:R5').NumberFormat = '0.0000E+00';
% 
% % 合并单元格（8组）
% mergeRanges = {'B1:C1', 'D1:E1', 'F1:G1', 'H1:I1', 'J1:K1', 'L1:M1', 'N1:O1', 'P1:Q1'};
% titles = {'Cmq', 'CLAlphadot', 'CmAlphadot', 'Clp', 'CYp', 'Cnp', 'Cnr', 'Clr'};
% 
% for i = 1:length(mergeRanges)
%     range = sheet.Range(mergeRanges{i});
%     range.Merge();
%     range.HorizontalAlignment = -4108;  % 居中
%     range.VerticalAlignment   = -4108;
%     range.Value = titles{i};
% end
% 
% % 保存并关闭
% workbook.Save();
% workbook.Close();
% excelApp.Quit();
% 
% disp('数据已写入 DynamicDerivatives.xlsx');
% %% 整合
% % 定义原始文件及对应 sheet 名
% sourceFiles = {'base.xlsx', 'da.xlsx', 'de.xlsx', 'dr.xlsx', 'DynamicDerivatives.xlsx'};
% sheetNames  = {'base', 'da', 'de', 'dr', 'DynamicDerivatives'};
% 
% % 新建目标文件名
% combinedFile = 'derivatives_combined.xlsx';
% 
% % 如果已存在目标文件，先删除它（防止追加冲突）
% if exist(combinedFile, 'file')
%     delete(combinedFile);
% end
% 
% % 遍历每个文件并写入新文件中的不同 sheet
% for i = 1:length(sourceFiles)
%     [~, ~, raw] = xlsread(sourceFiles{i});
%     writecell(raw, combinedFile, 'Sheet', sheetNames{i});
% end
% 
% disp('已成功创建 derivatives_combined.xlsx，并整合所有 Sheet。');
% 
% %% 追加数据说明
% sheetName = '数据说明';
% filename = combinedFile;
% 
% script_input = {
%     'alpha0 (deg)', alpha0;
%     'beta0 (deg)', beta0;
%     'Ma0', Ma0;
%     'alt0 (m)', alt0;
%     'de0 (deg)', de0;
%     'dr0 (deg)', dr0;
%     'da0 (deg)', da0;
%     'h', 0.01
% };
% 
% writecell({'脚本输入'}, filename, 'Sheet', sheetName, 'Range', 'A1');
% writecell({'参数', '数值'}, filename, 'Sheet', sheetName, 'Range', 'A2');
% writecell(script_input, filename, 'Sheet', sheetName, 'Range', 'A3');
% 
% coeff_names = {
%     'CD_base0', CD_base0;
%     'CY_base0', CY_base0;
%     'CL_base0', CL_base0;
%     'Cl_base0', Cl_base0;
%     'Cm_base0', Cm_base0;
%     'Cn_base0', Cn_base0;
%     'CD_de0', CD_de0;
%     'CY_de0', CY_de0;
%     'CL_de0', CL_de0;
%     'Cl_de0', Cl_de0;
%     'Cm_de0', Cm_de0;
%     'Cn_de0', Cn_de0;
%     'CD_dr0', CD_dr0;
%     'CY_dr0', CY_dr0;
%     'CL_dr0', CL_dr0;
%     'Cl_dr0', Cl_dr0;
%     'Cm_dr0', Cm_dr0;
%     'Cn_dr0', Cn_dr0;
%     'CD_da0', CD_da0;
%     'CY_da0', CY_da0;
%     'CL_da0', CL_da0;
%     'Cl_da0', Cl_da0;
%     'Cm_da0', Cm_da0;
%     'Cn_da0', Cn_da0;
%     'Cmq0', Cmq0;
%     'CLAlphadot0', CLAlphadot0;
%     'CmAlphadot0', CmAlphadot0;
%     'Clp0', Clp0;
%     'CYp0', CYp0;
%     'Cnp0', Cnp0;
%     'Cnr0', Cnr0;
%     'Clr0', Clr0;
% };
% 
% startRow = size(script_input, 1) + 4;
% writecell({'平衡状态下各系数'}, filename, 'Sheet', sheetName, 'Range', ['A' num2str(startRow)]);
% writecell({'系数名', '数值'}, filename, 'Sheet', sheetName, 'Range', ['A' num2str(startRow + 1)]);
% writecell(coeff_names, filename, 'Sheet', sheetName, 'Range', ['A' num2str(startRow + 2)]);
% 
% %% 美化所有 sheet：设定科学计数法 + 自动列宽
% excel = actxserver('Excel.Application');
% excel.Visible = false;  % 不显示界面
% workbook = excel.Workbooks.Open(fullfile(pwd, filename));
% 
% for i = 1:workbook.Sheets.Count
%     sheet = workbook.Sheets.Item(i);
%     usedRange = sheet.UsedRange;
% 
%     % 设置科学计数法格式
%     usedRange.NumberFormat = '0.0000E+00';
% 
%     % 自动调整列宽
%     usedRange.Columns.AutoFit;
% end
% 
% % 保存并关闭
% workbook.Save();
% workbook.Close(false);
% excel.Quit();
% delete(excel);
% 
% disp('所有 sheet 格式已统一为科学计数法，并自动调整列宽。');
% 
% 
% 
% 
% 
% 
% 
% 
% 
