close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado.mat


T_rounds = 1; % total rounds
bal = [0.5]; % bal% of test samples and (bal-1)% training samples
dist_method_type = [2 3 5];
dim_opt_proj = [3];
rp = 1; % turn on (1) the percentual representativite and turn off (0)
% Dim = [0.8 0.85 0.9 0.95 0.99 0.999 flip(1-eps*10.^[1:1:5])]';
% Dim = 1-eps*10.^6;
Dim = 0.999;

T_Dim = max(size(Dim));

T_dim_p = max(size(dim_opt_proj));
T_bal= max(size(bal));
N = max(size(trajectories));
T_dist = max(size(dist_method_type));

R_DGTDA = zeros(T_dist,T_dim_p,T_Dim,T_rounds,T_bal);
T_DGTDA = R_DGTDA;
MC_DGTDA = zeros(N,N,T_dist,T_dim_p,T_Dim,T_rounds,T_bal);
num_max = zeros(3,2,T_dist,T_dim_p,T_Dim,T_rounds,T_bal);

disp('Round: ')
for j=1:T_bal
    for r=1:T_rounds
        [test_samples,training_samples] = gen_round_rand_balance(trajectories,bal(j));
        for dimi = 1:T_Dim
            for m=1:T_dim_p
                 for k=1:T_dist
                    disp([j r dimi m k])
                    disp([bal(j) r Dim(dimi) m k])
%                     tic
%                     [R_DGTDA(k,m,dimi,r,j),MC_DGTDA(:,:,k,m,dimi,r,j),num_max(:,:,k,m,dimi,r,j)]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),rp,zeta);
                    [R_DGTDA(k,m,dimi,r,j),MC_DGTDA(:,:,k,m,dimi,r,j),num_max(:,:,k,m,dimi,r,j)]= DCMDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),rp);
%                     T_DGTDA(k,m,dimi,r,j) = toc;

                end
            end
        end
    end
end



save results_MDA_actions_rand_100417_test_r.mat
% pause(60)
% disp('poweroff')
% system('poweroff')

break
close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado_atores.mat
N=11;
bal = [2];
T_bal = max(size(bal));
dist_method_type = [3 5];
dim_opt_proj = [0 3];
Dim = [0.6];
zeta = 100.*[10 1 0.1]';

T_Dim = max(size(Dim));

T_dist = max(size(dist_method_type));

T_dim_p = max(size(dim_opt_proj));

R_DGTDA = zeros(T_dist,T_bal);
T_DGTDA = R_DGTDA;
MC_DGTDA = zeros(N,N,T_dist,T_bal);

for dimi = 1:T_Dim
    for m=1:T_dim_p
        for b=1:T_bal

            atores_select = [1 2 3 4 5];
            ator_teste = 1:bal(b);
            ator_training = bal(b)+1:5;
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
                disp('dimi m b k')
                disp([dimi m b k])
                tic
                [R_DGTDA(k,b,m,dimi),MC_DGTDA(:,:,k,b,m,dimi)]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta);
                T_DGTDA(k,b,m,dimi) = toc;
            end
        end
    end
end


S = zeros(5,1);
for a=1:5
    for Ni=1:11
        S(a) = S(a)+max(size(atores{a}{Ni}));
    end
end


save results_MDA_actions_atores_rotativo_110317_comp.mat

% load handel
% sound(y(1:max(size(y))/4),Fs)
% contagem de amostras por ator





%EOF