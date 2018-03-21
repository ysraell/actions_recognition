close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado.mat

T_rounds = 50; % total rounds
bal = [0.2 0.5 0.8]; % bal% of test samples and (bal-1)% training samples
dist_method_type = [1 2 3];

T_bal= max(size(bal));
N = max(size(trajectories));
T_dist = max(size(dist_method_type));

R_DGTDA2 = zeros(T_dist,T_rounds,T_bal);
R_DGTDA3 = zeros(T_rounds,T_bal);

MC_DGTDA2 = zeros(N,N,T_dist,T_rounds,T_bal);
MC_DGTDA3 = zeros(N,N,T_dist,T_rounds,T_bal);

disp('Round: ')


for j=1:T_bal
    for r=1:T_rounds
        for k=1:T_dist

            disp([j r k])
            disp([bal(j) r k])

        %     [test_samples,training_samples] = gen_round(r,trajectories);
            [test_samples,training_samples] = gen_round_rand_balance(trajectories,bal(j));

            [R_DGTDA2(k,r,j),MC_DGTDA2(:,:,k,r,j)]= DGTDA2_actions(trajectories,test_samples,training_samples,dist_method_type(k));

            [R_DGTDA3(k,r,j),MC_DGTDA3(:,:,k,r,j)] = DGTDA3_actions(trajectories,test_samples,training_samples,dist_method_type(k));

        end
    end
end


% save results_MDA_actions_rand_080217.mat


close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado_atores.mat
N=11;
bal = [1 2 3 4];
T_bal = max(size(bal));
dist_method_type = [1 2 3];
T_dist = max(size(dist_method_type));

R_DGTDA2 = zeros(T_dist,5,T_bal);
R_DGTDA3 = zeros(T_dist,5,T_bal);
MC_DGTDA2 = zeros(N,N,T_dist,5,T_bal);
MC_DGTDA3 = zeros(N,N,T_dist,5,T_bal);

for b=1:T_bal

    atores_select = [1 2 3 4 5];
    ator_teste = 1:bal(b);
    ator_training = bal(b)+1:5;
    
    for a=1:5
        for Ni=1:11
            test_samples{Ni} = [];
            training_samples{Ni} = [];
        end
        
        for ai=1:5
            if find(atores_select(ator_teste)==ai)
                TEMP = [];
                for Ni=1:11
                    TEMP = test_samples{Ni};
                    TEMP = [TEMP atores{ai}{Ni}];
                    test_samples{Ni} =  TEMP;
                end
            else
                TEMP = [];
                for Ni=1:11
                    TEMP = training_samples{Ni};
                    TEMP = [TEMP atores{ai}{Ni}];
                    training_samples{Ni} =  TEMP;
                end
            end
        end
        
        for k=1:T_dist
            [R_DGTDA2(k,a,b),MC_DGTDA2(:,:,k,a,b)]= DGTDA2_actions(trajectories,test_samples,training_samples,dist_method_type(k));
            [R_DGTDA3(k,a,b),MC_DGTDA3(:,:,k,a,b)] = DGTDA3_actions(trajectories,test_samples,training_samples,dist_method_type(k));
            disp('b a k')
            disp([b a k])
        end
        atores_select = [atores_select(end) atores_select(1:4)];
    end
end

%save results_MDA_actions_atores_rotativo_080217.mat




%EOF