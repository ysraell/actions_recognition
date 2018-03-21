%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all
close all
clc

addpath(pwd)
addpath('matlab_libsvm322')
w = warning ('on','all');

load dataset_CMU.mat % trajectories N
load rounds_var.mat % testing_unlabel testing_label training

arg_svm  = '-s 0 -c 1 -t 0';

R=zeros(10,3);

for o=1:3
    for r=1:10
        [R(r,o),~,~] = SVM_actions(trajectories,testing_unlabel{o}{r},training{o},arg_svm);
    end
end
Rmax = mean(mean(R,2));
disp('###')
disp(Rmax)
disp('###')

save results_MDA_SVM.mat Rmax