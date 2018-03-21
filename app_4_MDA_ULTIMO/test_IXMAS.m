clear all
close all
clc

load rounds_O2.mat
load dataset_P.mat

R = zeros(Rounds,3);
MC = zeros(N,N,Rounds,3);

% parpool('local',3)
for r=1:Rounds
    disp('#####################')
    disp([r Rounds])
    [R(r,1),MC(:,:,r,1)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'o');
    disp(['L2/C++ ' num2str(R(r,1))])
    [R(r,2),MC(:,:,r,2)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'f');
    disp(['Frob/TensorLAB ' num2str(R(r,2))])
    [R(r,3),MC(:,:,r,3)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'g');
    disp(['Frob/C++ ' num2str(R(r,3))])
end
disp(R)
save results_test_IXMAS_P.mat R MC Rounds

% clear all
% close all
% clc
% 
% load rounds_O2.mat
% load dataset_O2.mat
% 
% R = zeros(Rounds,3);
% MC = zeros(N,N,Rounds,3);
% 
% % parpool('local',3)
% for r=1:Rounds
%     disp([r Rounds])
%     [R(r,1),MC(:,:,r,1)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'x');
%     [R(r,2),MC(:,:,r,2)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'y');
%     [R(r,3),MC(:,:,r,3)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'z');
% end
% disp(R)
% save results_test_IXMAS_O2.mat R MC Rounds


% clear all
% close all
% clc
% 
% load rounds_N.mat
% load dataset_N.mat
% 
% R = zeros(Rounds,1);
% MC = zeros(N,N,Rounds);
% 
% % parpool('local',4)
% for r=1:Rounds
%     disp([r Rounds])
%     [R(r),MC(:,:,r)] = TEST_step_KNN(trajectories,test_samples{r},training_samples{r},N,'o');
% end
% 
% clear trajectories
% save results_test_IXMAS.mat R MC Rounds