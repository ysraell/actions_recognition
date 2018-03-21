%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all
close all
clc

load dataset_CMU.mat % trajectories N
load rounds_var.mat % testing_unlabel testing_label training


dist_method = 'o';


Dim = [0.11:0.01:0.19];
dop = [1 2];
rr = [0 1];
zeta = [0:6];


T_Dim = max(size(Dim));
T_dop = max(size(dop));
T_rr = max(size(rr));
T_zeta = max(size(zeta));

Rmax=zeros(T_Dim,T_dop,T_rr,T_zeta);
parfor i=1:T_Dim
    for j=1:T_dop
        for k=1:T_rr
            for l=1:T_zeta
                disp('---------')
                disp([T_Dim T_dop T_rr T_zeta])
                disp([i j k l])
                disp('---------')
                R=zeros(10,2,3);
                for o=1:3
                    R(:,:,o) = AMDA_CMU(trajectories,testing_unlabel{o},testing_label{o},training{o},dop(j),Dim(i),rr(k),zeta(l),dist_method);
                end
                Rmax(i,j,k,l) = max(mean(mean(R,3)));
                disp('###')
                disp([T_Dim T_dop T_rr T_zeta])
                disp([i j k l])
                disp(Rmax(i,j,k,l))
                disp('###')
            end
        end
    end
end

save results_MDA_CMU.mat Rmax