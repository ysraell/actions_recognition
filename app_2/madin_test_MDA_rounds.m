close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado.mat

T_rounds = 20; % total rounds
bal = [0.5 0.2]; % bal% of test samples and (bal-1)% training samples

T_bal= max(size(bal));
N = max(size(trajectories));

R_DGTDA2 = zeros(T_rounds,T_bal);
R_DGTDA3 = zeros(T_rounds,T_bal);

MC_DGTDA2 = zeros(N,N,T_rounds,T_bal);
MC_DGTDA3 = zeros(N,N,T_rounds,T_bal);

disp('Round: ')

for j=1:T_bal
    for r=1:T_rounds

        disp([bal(j) r])

    %     [test_samples,training_samples] = gen_round(r,trajectories);
        [test_samples,training_samples] = gen_round_rand_balance(trajectories,bal(j));


        [R_DGTDA2(r,j),MC_DGTDA2(:,:,r,j)]= DGTDA2_actions(trajectories,test_samples,training_samples);

        [R_DGTDA3(r,j),MC_DGTDA3(:,:,r,j)] = DGTDA3_actions(trajectories,test_samples,training_samples);

    end
end

clearvars -except R_DGTDA2 R_DGTDA3 MC_DGTDA3 MC_DGTDA2 bal T_rounds T_bal N bal
save results_MDA_actions_250117.mat

%EOF