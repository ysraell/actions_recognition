clear all
close all
clc

load dataset_M
load rounds_M

R=zeros(Rounds,1);
MC=zeros(N,N,Rounds);
for r=1:Rounds
    disp('###########')
    disp([r Rounds])
    [R(r),MC(:,:,r)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'o');
    disp(R(r))
end

stem(1:Rounds,R)