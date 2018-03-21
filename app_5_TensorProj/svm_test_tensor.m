clear all
close all
clc

addpath(pwd)
addpath('matlab_libsvm322')
w = warning ('on','all');

load dataset_DI700


[test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,0.5);

C = [0.52:0.01:1];
T_C = max(size(C));
R1 = zeros(T_C,1);

for c=1:T_C
    arg_svm = ['-s 0 -c ' num2str(C(c)) ' -t 0'];
    disp(['Testinng ' num2str(c) '...'])
    disp(arg_svm)
    [R1(c),~,~] = SVM_actions(trajectories,test_samples,training_samples,arg_svm);
%     figure;
%     plot_confusion_matrix(MC1)
end


disp('Testinng 5...')
[R,MC,~] = TEST_step_KNN(trajectories,test_samples,training_samples,'o',1);

figure;
disp(R1)
disp(R)

save svm_teste_var_c.mat