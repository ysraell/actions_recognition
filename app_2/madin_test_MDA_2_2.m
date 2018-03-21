close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado.mat

[R_DGTDA2,Cl_DGTDA2,Dist_DGTDA2] = DGTDA2_actions(trajectories);

[R_DGTDA3,Cl_DGTDA3,Dist_DGTDA3] = DGTDA3_actions(trajectories);

save results_test_MDA.mat

%EOF