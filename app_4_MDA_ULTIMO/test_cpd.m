clear all
close all
clc

load dataset_J

T = fmt(trajectories{1}{1});
[U,S,sv] = mlsvds(T);

break

maxr = 100;
Rounds = 40;
R=zeros(maxr,Rounds);
delete(gcp)
parpool('local',8);
Ni=randi(10,maxr,Rounds);
Mi=randi(9,maxr,Rounds);

parfor ro=1:Rounds
    for r=1:maxr
        R(r,ro) = frob(trajectories{Ni(ro)}{Mi(ro)}-cpdgen(cpd(trajectories{Ni(ro)}{Mi(ro)},r)))./frob(trajectories{Ni(ro)}{Mi(ro)});
    %     figure;
    %     subplot(1,3,1)
    %     imagesc(sum(trajectories{1}{1},3))
    %     subplot(1,3,2)
    %     imagesc(sum(T,3))
    %     subplot(1,3,3)
    %     imagesc(sum(E,3))
    %     disp(R(r))
    end
end