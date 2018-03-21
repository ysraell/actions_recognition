%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all
close all
clc

load dataset_CMU.mat % trajectories N
load rounds_var.mat % testing_unlabel testing_label training

Rounds = 30; % 30

RR=zeros(Rounds,2);
rr=0;
for o=1:3
    for r=1:10
        rr=rr+1;
        RR(rr,:) = [o r];
    end
end

dist_methods = 'o';
T_dist = max(size(dist_methods));
R = zeros(Rounds,T_dist);
% T = zeros(Rounds,T_dist);
parfor rr=1:Rounds
    disp([num2str(rr) '/30'])
    for t=1:T_dist
        disp(['Dist method: ' dist_methods(t)])
%         tic
        [R(rr,t),~] = TEST_step(trajectories,testing_unlabel{RR(rr,1)}{RR(rr,2)},testing_label{RR(rr,1)}{RR(rr,2)},N,dist_methods(t));
%         T(rr,t)=toc;
        disp([dist_methods(t) ': ' num2str(R(rr,t))])
    end
end

save results_KNN_CMU.mat R