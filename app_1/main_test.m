%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by MDA technics.
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all
clc

run load_actions
 
[R_DGTDA,MC_DGTDA] = DGTDA_actions(classe_teste,classe_treino,sinalTeste,sinalTreino);
% disp(R_DGTDA_actions)

% Tmax = 2;
% tol = 1;
% Dim_red = [15 125]';
% [R_DATER_actions,Cl_DATER_actions,Dist_DATER_actions] = DATER_actions(classe_teste,classe_treino,sinalTeste,sinalTreino,Tmax,tol,Dim_red);
% disp(mean(R_DATER_actions))
% 
% Tmax = 1;
% tol = 1;classe_teste
% Dim_red = [15 100]';
% zeta = 0;
% [R_GTDA_actions,Cl_GTDA_actions,Dist_GTDA_actions] = GTDA_actions(classe_teste,classe_treino,sinalTeste,sinalTreino,Tmax,tol,Dim_red,zeta);
% 
% disp(mean(R_GTDA_actions))
% 
% clc
% 
% disp([mean(R_DGTDA_actions) mean(R_DATER_actions) mean(R_GTDA_actions)])
% save results_actions_test.mat

% EOF
