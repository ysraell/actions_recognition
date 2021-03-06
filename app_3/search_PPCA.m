%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All experiments with dataset A.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');

load dataset_C
trajectories = trajectories_C;
atores = atores_C;

%% For all experiments

% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = [0.5];

%% Experiment random samples, mix actors
T_rounds = 20;

rr = 1;
Dim = [0.5 0.6 0.7 0.8 0.9 0.99 0.999 0.9999];

T_d = max(size(Dim));

dist_method_type = 'n';
T_dm = max(size(dist_method_type));

N = max(size(trajectories));
T_bal = max(size(bal));
MC = zeros(N,N,T_d,T_rounds,T_bal);
R = zeros(T_d,T_rounds,T_bal);

time = zeros(T_d,1);
for b=1:T_bal
    for r=1:T_rounds
        [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
        for d=1:T_d

            texto = ['d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
            disp(texto)
            tic
            [R(d,r,b),MC(:,:,d,r,b)] = PPCA_actions(trajectories,test_samples,training_samples,dist_method_type,Dim,rr);
            time(d) = toc;
        end
    end
end


% Rn = reshape(R(1,:,:),3,10);
% Rf = reshape(R(2,:,:),3,10);

 save search_PPCA_data.mat
% pause(60)
% disp('poweroff')
% system('poweroff')
 %EOF

