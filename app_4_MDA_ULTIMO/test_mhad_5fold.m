clear all
close all
clc

% load dataset_D203
% load dataset_D10
% load dataset_E

load samples_kfold_DI700
load dataset_DI700
N=11;




% Dim = [0.6:0.01:0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
% Dim = [0.01:0.01:0.15 0.99 0.999 0.9999];
Dim = [0.45 0.55 0.65 0.75 0.85 ];
T_Dim = max(size(Dim));
rr = [0 1];
T_rr = max(size(rr));
zeta = [0:6]';
T_zeta = max(size(zeta));
dop = [1 2 3];
T_dop = max(size(dop));

R=zeros(T_dop,T_zeta,T_rr,T_Dim);
tk=16;
K=5;

% parpool('local',5)
for di=1:T_Dim
    for ri=1:T_rr
        for zi=1:T_zeta
            for pi=1:T_dop
                tmp=zeros(K,1);
                parfor k=1:K
                    [tmp(k),~] = AMDA(trajectories,test_samples_kfold{tk}{k},training_samples_kfold{tk}{k},dop(pi),Dim(di),rr(ri),zeta(zi));
                end
                R(pi,zi,ri,di) = mean(tmp);
                disp([T_dop T_zeta T_rr T_Dim; pi zi ri di])
            end
        end
    end
    save trajectories_TMP.mat trajectories
    clear trajectories
    save test_mhad_results_DI700_kfold2_TMP.mat
    load trajectories_TMP.mat
    disp('########################################################')
    tmp = R(:,:,:,di);
    disp([T_Dim Dim(di) 0 ; di max(R(:)) max(tmp(:))])
end
       
clear trajectories
save test_mhad_results_DI700_kfold2.mat

pause(50)
system('poweroff')

