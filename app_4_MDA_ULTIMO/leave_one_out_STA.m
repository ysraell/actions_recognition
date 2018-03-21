clear all
close all
clc

load dataset_J.mat
N = max(size(trajectories));
[test_atores,training_atores,T_rounds] = gen_comb_authors(8,atores);



Dim = [0.01:0.01:0.95 0.99 0.999 0.9999 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]];
rr = [0 1];
zeta = [0:6]';
dop = [1:3];
Iters = 4;

% Dim = [0.01 0.001];
% rr = [0 1];
% zeta = [0 6]';
% dop = [1 3];
delete(gcp)
parpool('local',9);

T_Dim = max(size(Dim));
T_rr = max(size(rr));
T_zeta = max(size(zeta));
T_dop = max(size(dop));
Rmax = 0;
Dimax=Inf;
rrmax=NaN;
zmax=NaN;
dopmax=5;
timax=0;

for di=1:T_Dim
    for ri=1:T_rr
        for zi=1:T_zeta
            for pi=1:T_dop
                for ti=2:Iters
                    R=zeros(T_rounds,1);
                    parfor r=1:T_rounds
                        [test_samples,training_samples,test_count,training_count] = gen_by_authors(trajectories,atores,test_atores(r),training_atores(r,:));
                        R(r) = MDA(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi),ti);
%                         R(r) = DMDA(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi));
    %                     R(r) = DMSD(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi));
                    %     [A,~,B] = TEST_step(trajectories,test_samples,training_samples,N,'f');
                    %     R(r)= A/B;
                    end
                    disp([T_dop T_zeta T_rr T_Dim])
                    disp([pi zi ri di])

                    if mean(R)>Rmax
                        Rmax = mean(R);
                        Dimax=Dim(di);
                        rrmax=rr(ri);
                        zmax=zeta(zi);
                        dopmax=dop(pi);
                        timax=ti;
                    elseif (mean(R)==Rmax)&&(Dim(di)<Dimax)
                        Dimax=Dim(di);
                        rrmax=rr(ri);
                        zmax=zeta(zi);
                        dopmax=dop(pi);
                        timax=ti;
                    elseif (mean(R)==Rmax)&&(dop(pi)>dopmax)
                        Dimax=Dim(di);
                        rrmax=rr(ri);
                        zmax=zeta(zi);
                        dopmax=dop(pi);
                        timax=ti;
                    end  
                end
            end
        end
    end
end

save lout_STA_MDA.mat
