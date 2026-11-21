ep4 = readmatrix('e.4.txt');
ep6 = readmatrix('e.6.txt');
different = xor(ep4, ep6);
C_ep = [
    "CD_base_alpha",    "CD_base_Ma",    "CD_base_beta"
    "CY_base_alpha",    "CY_base_Ma",    "CY_base_beta"
    "CL_base_alpha",    "CL_base_Ma",    "CL_base_beta"
    "Cl_base_alpha",    "Cl_base_Ma",    "Cl_base_beta"
    "Cm_base_alpha",    "Cm_base_Ma",    "Cm_base_beta"
    "Cn_base_alpha",    "Cn_base_Ma",    "Cn_base_beta"
    "CD_de_alpha",      "CD_de_Ma",      "CD_de_de"
    "CY_de_alpha",      "CY_de_Ma",      "CY_de_de"
    "CL_de_alpha",      "CL_de_Ma",      "CL_de_de"
    "Cl_de_alpha",      "Cl_de_Ma",      "Cl_de_de"
    "Cm_de_alpha",      "Cm_de_Ma",      "Cm_de_de"
    "Cn_de_alpha",      "Cn_de_Ma",      "Cn_de_de"
    "CD_dr_alpha",      "CD_dr_Ma",      "CD_dr_dr"
    "CY_dr_alpha",      "CY_dr_Ma",      "CY_dr_dr"
    "CL_dr_alpha",      "CL_dr_Ma",      "CL_dr_dr"
    "Cl_dr_alpha",      "Cl_dr_Ma",      "Cl_dr_dr"
    "Cm_dr_alpha",      "Cm_dr_Ma",      "Cm_dr_dr"
    "Cn_dr_alpha",      "Cn_dr_Ma",      "Cn_dr_dr"
    "CD_da_alpha",      "CD_da_Ma",      "CD_da_da"
    "CY_da_alpha",      "CY_da_Ma",      "CY_da_da"
    "CL_da_alpha",      "CL_da_Ma",      "CL_da_da"
    "Cl_da_alpha",      "Cl_da_Ma",      "Cl_da_da"
    "Cm_da_alpha",      "Cm_da_Ma",      "Cm_da_da"
    "Cn_da_alpha",      "Cn_da_Ma",      "Cn_da_da"
    "Cmq_alpha",        "Cmq_Ma",        "Cmq_alt"
    "CLAlphadot_alpha", "CLAlphadot_Ma", "CLAlphadot_alt"
    "CmAlphadot_alpha", "CmAlphadot_Ma", "CmAlphadot_alt"
    "Clp_alpha",        "Clp_Ma",        "Clp_alt"
    "CYp_alpha",        "CYp_Ma",        "CYp_alt"
    "Cnp_alpha",        "Cnp_Ma",        "Cnp_alt"
    "Cnr_alpha",        "Cnr_Ma",        "Cnr_alt"
    "Clr_alpha",        "Clr_Ma",        "Clr_alt"
];

for i = 1:numel(C_ep)
    if different(i)
        fprintf('%s\n', C_ep(i));
    end
end

