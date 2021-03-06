%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All datasets with DMDA with MSD.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc

disp('Loading paths')
addpath(pwd)
addpath('tensor_toolbox_2.6')
addpath('tensorlab')

w = warning ('off','all');

disp('Loading vars')
%% Balance
% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = 1;

%% Experiment random samples, mix actors
T_rounds = 10;

% Dim = [0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
Dim = [0.05:0.05:0.95 0.99 0.999 0.9999];
% Dim = [0.1:0.1:0.9];

%% Proporcional dim by eigenvalues or size dim (1 or 0)
rr = [0 1];

%% distance metric
dist_method_type = 'og';

%% How much dim progections
dim_opt_proj = [1 2 3];

%% Weight of discriminant w max scatter
zeta = [0:6]';


%% Totals
T_bal = max(size(bal));
T_d = max(size(Dim));
T_rr = max(size(rr));
T_dm = max(size(dist_method_type));
T_z = max(size(zeta));
T_proj = max(size(dim_opt_proj));


%% Experiments

D_sets = dir('dataset_*.mat');
T_sets = max(size(D_sets));
Exps = 1:T_sets;
T_Exps = max(size(Exps));
 delete(gcp)
 parpool('local',16);

disp('Starting experiments...')
for n=1:T_Exps
    load(D_sets(Exps(n)).name)
    load(['rounds_' set_str '.mat'])
    
    N = max(size(trajectories));
    [~,~,p_dim] = size(trajectories{1}{1});

    for b=bal

        R = zeros(T_dm,T_proj,T_z,T_rr,T_d,T_rounds);
        time = zeros(T_dm,T_proj,T_z,T_rr,T_d,T_rounds);
        parfor r=1:T_rounds
%  	for r=1:T_rounds
            for d=1:T_d
                for rri=1:T_rr
                    for zi=1:T_z
                        for pi=1:T_proj
                             if ((dim_opt_proj(pi)>2)&&(p_dim>1))||(dim_opt_proj(pi)<3)
%                                  texto = ['(' set_str ')'...
%                                           ' Proj = ',num2str(pi),'/',num2str(T_proj),'.'...
%                                           ' zeta = ',num2str(zi),'/',num2str(T_z),'.'...
%                                           ' rr = ',num2str(rr(rri)),'/',num2str(T_rr),'.'...
%                                           ' d = ',num2str(d),'/',num2str(T_d),'.'...
%                                           ' Round:' num2str(r),'/',num2str(T_rounds),'.'...
%                                           ' bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
%                                  disp([pi zi rri d r])
%                                  disp([T_proj T_z T_rr T_d T_rounds])
                                [R(:,pi,zi,rri,d,r),~,~,time(:,pi,zi,rri,d,r)] = DMSD_actions(trajectories,...
                                                                        test_samples{r,b},...
                                                                        training_samples{r,b},...
                                                                        dist_method_type,...
                                                                        dim_opt_proj(pi),...
                                                                        Dim(d),rr(rri),zeta(zi));
                             end
                        end
                    end
                end
            end
        end
        Smax = 6;
        mR = mean(R,Smax);
        sR = std(R,[],Smax);
        minR = min(R,[],Smax);
        maxR = max(R,[],Smax);
        [~,idx] = max(mR(:));
        [i,j,k,l,m] = ind2sub(size(mR),idx);
        
%         mT = mean(T,Smax-1);
%         sT = std(T,[],Smax-1);
%         minT = min(T,[],Smax-1);
%         maxT = max(T,[],Smax-1);
%         (:,pi,zi,rri,d,r)
%         dim_opt_proj(j),Dim(k),rr(l),zeta(k)
        Results(n,b) = struct('Method','DMSD',...
                              'Dataset',set_str,...
                              'Best_R',[mR(i,j,k,l,m) sR(i,j,k,l,m) minR(i,j,k,l,m) maxR(i,j,k,l,m)],...
                              'Best_D',dist_method_type(i),...
                              'Best_Proj',dim_opt_proj(j),...
                              'Best_Dim',Dim(m),...
                              'Best_rr',rr(l),...
                              'Best_zeta',zeta(k),...
                              'R',R,'time',time);
%                               'R',R,'Time',T);                          
        
    end
    clear trajectories
    save results_rounds_DMSD_og.mat

end

clear trajectories
save results_rounds_DMSD_og.mat
rmpath(pwd)

exit

% 
% pause(60)
% disp('poweroff')
% system('poweroff')


% ST=0;
% for n=1:T_sets
%     ST=ST+sum(Results(n).Time(:));
% end

%EOF

