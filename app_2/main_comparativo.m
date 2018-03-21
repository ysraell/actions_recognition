clear all
close all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado_comparativo.mat
break
[R_DGTDA2,MC_DGTDA2]= DGTDA2_actions(trajectories,test_samples,training_samples);
% [R_DGTDA3,MC_DGTDA3]= DGTDA3_actions(trajectories,test_samples,training_samples);

fig=0;

fig=fig+1;
figure(fig)
plot_confusion_matrix(MC_DGTDA2)
title('Confusion matrix: MDA 3-2, Actors 1-2/3-5')
