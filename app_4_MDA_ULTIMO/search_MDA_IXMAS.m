clear all
close all
clc

% load dataset_K
% load dataset_JJ
% load dataset_G

load rounds_O.mat
load dataset_P.mat



% Dim = [0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
% Dim = [0.01:0.01:0.95 0.99 0.999 0.9999];
% Dim = [0.01:0.01:0.95 0.99 0.999 0.9999 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]];
% Dim=0.75;
Dim = [0.1:0.1:0.9];
T_Dim = max(size(Dim));
rr = [0 1];
T_rr = max(size(rr));
zeta = [0:6]';
T_zeta = max(size(zeta));
dop = [1 2 3];
T_dop = max(size(dop));

R=zeros(Rounds,T_dop,T_zeta,T_rr,T_Dim);
Skip_rounds = 0;
% Skip_rounds = 0;
for di=1:T_Dim
    for ri=1:T_rr
        for zi=1:T_zeta
            for pi=1:T_dop
                for r=1:Rounds
%                     R(r,pi,zi,ri,di) = DMSD(trajectories_cut,test_samples{Skip_rounds+r},training_samples{Skip_rounds+r},dop(pi),Dim(di),rr(ri),zeta(zi))
                    R(r,pi,zi,ri,di) = AMDA(trajectories,test_samples{Skip_rounds+r},training_samples{Skip_rounds+r},dop(pi),Dim(di),rr(ri),zeta(zi));                    disp([Rounds T_dop T_zeta T_rr T_Dim;r pi zi ri di])
                end
            end
        end
    end
end
       
clear trajectories
save search_IXMAS_P_results.mat
