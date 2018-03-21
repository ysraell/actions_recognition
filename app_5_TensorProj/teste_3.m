clear all
close all
clc

load dataset_DI700
C = 2;
for c = 1:C
    X{c} = trajectories{c};
end

clear trajectories
trajectories  = X;
clear X;

R = 100;
disp('Factorazing...')

[test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,0.5);

trajectories_tp = TensorProject(trajectories,test_samples,training_samples,training_count,R);


disp('Testinng 1...')
[R1,MC1,~] = TEST_step_KNN(trajectories_tp,test_samples,training_samples,'o',1);

disp('Testinng 2...')
[R2,MC2,~] = TEST_step_KNN(trajectories,test_samples,training_samples,'o',1);

figure;
plot_confusion_matrix(MC1)
figure;
plot_confusion_matrix(MC2)
disp([R1 R2])