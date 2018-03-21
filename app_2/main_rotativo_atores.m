close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado_atores.mat
N=11;
bal = [1 2 3 4];
T_bal = max(size(bal));
dist_method_type = [1 2 3 5];
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


clearvars -except R_DGTDA2 R_DGTDA3 MC_DGTDA3 MC_DGTDA2 bal T_rounds T_bal N bal dist_method_type 
save results_MDA_actions_atores_rotativo_test.mat


