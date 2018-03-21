close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado.mat


T_rounds = 20; % total rounds
bal = [0.5 0.7]; % bal% of test samples and (bal-1)% training samples
dist_method_type = [2];
dim_opt_proj = [3];
Dim = [0.5];
% zeta = [1 1 1;
%         10 10 10;
%         1e2 1e2 1e2];
% T_zeta = max(size(zeta));      
zeta = [10 10 10];
T_zeta = 1;

T_Dim = max(size(Dim));

T_dim_p = max(size(dim_opt_proj));
T_bal= max(size(bal));
N = max(size(trajectories));
T_dist = max(size(dist_method_type));

R_DGTDA = zeros(T_dist,T_zeta,T_dim_p,T_Dim,T_rounds,T_bal);
T_DGTDA = R_DGTDA;
MC_DGTDA = zeros(N,N,T_zeta,T_dist,T_dim_p,T_Dim,T_rounds,T_bal);

disp('dias:')
disp( ((T_rounds*T_Dim*T_dim_p*T_dist*(290.6787 +0.4063)/3600)/24)/2 +(T_rounds*T_dist*(290.6787 +0.4063)/3600)/24)
disp('horas:')
disp( ((T_rounds*T_Dim*T_dim_p*T_dist*(290.6787 +0.4063)/3600))/2 +(T_rounds*T_dist*(290.6787 +0.4063)/3600))


disp('Round: ')
for j=1:T_bal
    for r=1:T_rounds
        [test_samples,training_samples] = gen_round_rand_balance(trajectories,bal(j));
        if (dim_opt_proj(1)==0)
            for s=1:T_zeta
                for k=1:T_dist
                    m=1;
                    dimi=1;
                    disp([j r dimi m s k])
                    disp([bal(j) r Dim(dimi) m zeta(s,:) k])
                    tic
                    % [R_DGTDA(k,s,m,dimi,r,j),MC_DGTDA(:,:,k,s,r,j,m,dimi)]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
                    [R_DGTDA(k,s,m,dimi,r,j),~]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
                    T_DGTDA(k,s,m,dimi,r,j) = toc;
                end
            end
            for dimi = 2:T_Dim
                for s=1:T_zeta
                    for k=1:T_dist
                        disp([j r dimi m s k])
                        disp([bal(j) r Dim(dimi) m zeta(s,:) k])
                        R_DGTDA(k,s,1,dimi,r,j) = R_DGTDA(k,s,1,1,r,j);
%                         MC_DGTDA(:,:,k,s,1,dimi,r,j) = MC_DGTDA(:,:,k,s,1,1,r,j);
                        T_DGTDA(k,s,1,dimi,r,j) = T_DGTDA(k,s,1,1,r,j);
                    end
                end
            end
        end
        for dimi = 1:T_Dim
            for m=1:T_dim_p
                if (dim_opt_proj(m)~=0)
                    for s=1:T_zeta
                        for k=1:T_dist
                            disp([j r dimi m s k])
                            disp([bal(j) r Dim(dimi) m zeta(s,:) k])
                            tic
    %                         [R_DGTDA(k,s,m,dimi,r,j),MC_DGTDA(:,:,k,s,r,j,m,dimi)]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
                              [R_DGTDA(k,s,m,dimi,r,j),~]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
                            T_DGTDA(k,s,m,dimi,r,j) = toc;
                        end
                    end
                end
            end
        end
    end
end

save results_MDA_actions_rand_270317_norm2_comp2.mat
% load handel
% sound(y,Fs)
% clear y Fs
break

close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado_atores.mat
N=11;
bal = [2];
T_bal = max(size(bal));
dist_method_type = [3 5];
dim_opt_proj = [3];
Dim = [0.22:0.0025:0.29];
% Dim = 0.6
% zeta = [1 1 1;
%         100 10 1;
%         10 10 10;
%         100 100 100;
%         1e3 1e3 1e3];
% T_zeta = max(size(zeta));      
zeta = [10 10 10];
T_zeta = 1;


T_Dim = max(size(Dim));

T_dist = max(size(dist_method_type));

T_dim_p = max(size(dim_opt_proj));

R_DGTDA = zeros(T_dist,T_bal);
T_DGTDA = R_DGTDA;
MC_DGTDA = zeros(N,N,T_dist,T_bal);


% last time: dim 60% SSIM 693.7228s FROB 0.6794s
% T_bal*T_zeta*T_Dim*T_dim_p*(693.7228 +0.6794 )/3600
% T_bal*T_zeta*T_Dim*T_dim_p*(213.6742 +0.3804 )/3600


for b=1:T_bal
    for dimi = 1:T_Dim
        for m=1:T_dim_p
            for s=1:T_zeta
            
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
                    disp('b dimi m s k')
                    disp([b dimi m s k])
                    tic
%                     [R_DGTDA(k,s,b,m,dimi),MC_DGTDA(:,:,k,s,b,m,dimi)]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta);
                    [R_DGTDA(k,s,m,dimi,b),~]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta);
                    T_DGTDA(k,s,m,dimi,b) = toc;
                end
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


save results_MDA_actions_atores_rotativo_170317_var_dim_SSIM_022_0025_029.mat

load handel
sound(y,Fs)
% contagem de amostras por ator
pause(60)
disp('poweroff')
system('poweroff')



%EOF