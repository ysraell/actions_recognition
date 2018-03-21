clear all
close all
clc

load dataset_S3
% load dataset_G

N=max(size(trajectories));

[test_samples,training_samples,test_count,training_count] = gen_by_authors(trajectories,atores,[2 4 6 8 10],[1 3 5 7 9]);

% [tmp,~] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'o');
% disp(tmp)
% 
% break

Dim = [0.01:0.01:0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]];
T_Dim = max(size(Dim));
rr = [0 1];
T_rr = max(size(rr));
zeta = [0:6]';
T_zeta = max(size(zeta));
dop = [1 2 3];
T_dop = max(size(dop));

R=zeros(T_dop,T_zeta,T_rr,T_Dim);

% 
% parpool('local',7)
for di=1:T_Dim
    for ri=1:T_rr
        parfor zi=1:T_zeta
            for pi=1:T_dop
                [R(pi,zi,ri,di),~] = AMDA(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi));
                disp([T_dop T_zeta T_rr T_Dim; pi zi ri di])
            end
        end
    end
    save trajectories_TMP.mat trajectories
    clear trajectories
    save test_msr_results_S220_TMP.mat
    load trajectories_TMP.mat
    disp('########################################################')
    tmp = R(:,:,:,di);
    disp([T_Dim Dim(di) 0 ; di max(R(:)) max(tmp(:))])
end
       
clear trajectories
save test_msr_results_S220.mat

% pause(5)
% system('poweroff')
