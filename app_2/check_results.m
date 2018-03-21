clear all
close all
clc 

load results_MDA_actions_rand_140417_test_T_max

% size(R_DGTDA);
Y = double(tenmat(R_DGTDA,3))';
[Dim mean(Y)' std(Y)' max(Y)' min(Y)']