clear all
close all
clc
w = warning ('off','all');
addpath(pwd)
addpath('tensor_toolbox_2.6')
addpath('tensorlab')

% 
% load samples_kfold_A 
% load dataset_A
% N=80;

% 
% load samples_kfold_B 
% load dataset_B
% N=65;

% load samples_kfold_C
% load dataset_C
% N=76;

load samples_kfold_DI700
load dataset_DI700
N=11;

parpool('local',5)
K=5;
TK =20;
Rmax = zeros(TK,1);

for tk=1:TK

    R = zeros(K,1);
    MC = zeros(N,N,K);
    parfor k=1:K
        disp([k K])
        [R(k),~] = TEST_step_KNN(trajectories,test_samples_kfold{tk}{k},training_samples_kfold{tk}{k},N,'o');
    end
    Rmax(tk) = mean(R);
    disp(mean(R))
end

clear trajectories
save results_mhad_5fold.mat


