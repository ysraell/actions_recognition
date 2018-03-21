close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado.mat

T_rounds = 20;


N = max(size(trajectories));
R_DGTDA2 = zeros(T_rounds,1);
R_DGTDA3 = zeros(T_rounds,1);

Cl_DGTDA2 = zeros(N,T_rounds);
Cl_DGTDA3 = zeros(N,T_rounds);

Dist_DGTDA2 = zeros(N,N,T_rounds);
Dist_DGTDA3 = zeros(N,N,T_rounds);

disp('Round: ')
for r=1:T_rounds
    
    disp(r)

%     [test_samples,training_samples] = gen_round(r,trajectories);
    [test_samples,training_samples] = gen_round_rand(trajectories);

    
    [R_DGTDA2(r),Cl_DGTDA2(:,r),Dist_DGTDA2(:,:,r)] = DGTDA2_actions(trajectories,test_samples,training_samples);

    [R_DGTDA3(r),Cl_DGTDA3(:,r),Dist_DGTDA3(:,:,r)] = DGTDA3_actions(trajectories,test_samples,training_samples);

end

save results_test_MDA.mat

%EOF