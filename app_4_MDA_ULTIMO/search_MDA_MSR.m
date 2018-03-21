clear all
close all
clc

% load dataset_S1.mat
% load dataset_S2.mat
load dataset_S3.mat
N = max(size(trajectories));

[test_samples,training_samples,test_count,training_count] = gen_by_authors(trajectories,atores,[2 4 6 8 10],[1 3 5 7 9]);

% [A,~,B] = TEST_step(trajectories,test_samples,training_samples,N,'f');
% disp(A/B)
% [A,~,B] = TEST_step(trajectories,test_samples,training_samples,N,'n');
% disp(A/B)
% 
% [A,~,B] = TEST_step(trajectories,test_samples,training_samples,N,'o');
% disp(A/B)
% [A,~,B] = TEST_step(trajectories,test_samples,training_samples,N,'s');
% disp(A/B)
% 
% 
% break

Dim = [0.01:0.01:0.95 0.99 0.999 0.9999 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]];
rr = [0 1];
zeta = [0:6]';
dop = [1:3];


% Dim = [0.01 0.001];
% rr = [0 1];
% zeta = [0 6]';
% dop = [1 3];
% delete(gcp)
% parpool('local',8);

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
%                 R = MDA(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi),ti);
                R1 = DMDA(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi));
                R2 = DMSD(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi));
                disp([T_dop T_zeta T_rr T_Dim])
                disp([pi zi ri di])
                R=max([R1 R2]);
                if R>Rmax
                    Rmax = R;
                    Dimax=Dim(di);
                    rrmax=rr(ri);
                    zmax=zeta(zi);
                    dopmax=dop(pi);
                elseif (R==Rmax)&&(Dim(di)<Dimax)
                    Dimax=Dim(di);
                    rrmax=rr(ri);
                    zmax=zeta(zi);
                    dopmax=dop(pi);
                elseif (R==Rmax)&&(dop(pi)>dopmax)
                    Dimax=Dim(di);
                    rrmax=rr(ri);
                    zmax=zeta(zi);
                    dopmax=dop(pi);
                end  
            end
        end
    end
end

disp('Rmax final:')
disp(Rmax)
% save search_MDA_MSR_S1.mat
% save search_MDA_MSR_S2.mat
save search_MDA_MSR_S3.mat

break

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

                    if R>Rmax
                        Rmax = R;
                        Dimax=Dim(di);
                        rrmax=rr(ri);
                        zmax=zeta(zi);
                        dopmax=dop(pi);
                        timax=ti;
                    elseif (R==Rmax)&&(Dim(di)<Dimax)
                        Dimax=Dim(di);
                        rrmax=rr(ri);
                        zmax=zeta(zi);
                        dopmax=dop(pi);
                        timax=ti;
                    elseif (R==Rmax)&&(dop(pi)>dopmax)
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

save search_MDA_MSR.mat
