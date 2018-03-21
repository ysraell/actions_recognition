clear all
close all
clc

% load dataset_D203
% load dataset_D10
% load dataset_E


load rounds_O.mat
load dataset_P.mat



% Dim = [0.6:0.01:0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
% Dim = [0.01:0.01:0.15 0.99 0.999 0.9999];
Dim = [0.55 0.75 0.95 ];
T_Dim = max(size(Dim));
rr = [0 1];
T_rr = max(size(rr));
zeta = [0:6]';
T_zeta = max(size(zeta));
dop = [1 2 3];
T_dop = max(size(dop));

R=zeros(T_dop,T_zeta,T_rr,T_Dim);



% parpool('local',3)
for di=1:T_Dim
    for ri=1:T_rr
        for zi=1:T_zeta
            for pi=1:T_dop
                tmp=zeros(Rounds,1);
                parfor k=1:Rounds
                    [tmp(k),~] = AMDA(trajectories,test_samples{k},training_samples{k},dop(pi),Dim(di),rr(ri),zeta(zi));
                end
                R(pi,zi,ri,di) = mean(tmp);
                disp([T_dop T_zeta T_rr T_Dim; pi zi ri di])
            end
        end
    end
    save trajectories_TMP.mat trajectories
    clear trajectories
    save results_test_ixmas_TMP.mat
    load trajectories_TMP.mat
    disp('########################################################')
    tmp = R(:,:,:,di);
    disp([T_Dim Dim(di) 0 ; di max(R(:)) max(tmp(:))])
end
       
clear trajectories
save results_test_ixmas.mat

% pause(50)
% system('poweroff')

