clear all
close all
clc

% load dataset_D203
% load dataset_D10
% load dataset_E
load dataset_DI700

N=max(size(trajectories));

[test_samples,training_samples,test_count,training_count] = gen_by_authors(trajectories,atores,8:12,1:7);

% [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'f');
% disp(TMP/TM)
% 
% [TMP,~,TM] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'f');
% disp(TMP/TM)

% [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'f');
% disp(TMP/TM)
% [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'g');
% disp(TMP/TM)
% [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'o');
% disp(TMP/TM)
% [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'s');
% disp(TMP/TM)
% [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'r');
% disp(TMP/TM)


% Dim = [0.6:0.01:0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
% Dim = [0.01:0.01:0.15 0.99 0.999 0.9999];
Dim = [0.1:0.1:0.9 0.99];
T_Dim = max(size(Dim));
rr = [0 1];
T_rr = max(size(rr));
zeta = [0:6]';
T_zeta = max(size(zeta));
dop = [1 2 3];
T_dop = max(size(dop));

R=zeros(T_dop,T_zeta,T_rr,T_Dim);


parpool('local',8)
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
    save test_mhad_results_DI700_TMP.mat
    load trajectories_TMP.mat
    disp('########################################################')
    tmp = R(:,:,:,di);
    disp([T_Dim Dim(di) 0 ; di max(R(:)) max(tmp(:))])
end
       
clear trajectories
save test_mhad_results_DI700.mat

pause(5)
system('poweroff')

