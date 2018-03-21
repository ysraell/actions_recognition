clear all
close all
clc




% load test_mhad_results_D203
load test_mhad_results_D1000_TMP

disp('##############')
disp([T_Dim di Dim(di)]);

% y=zeros(di,1);
% for i=0:di-1
%     tmp = R(:,:,:,di-i);
%     y(i+1)= max(tmp(:));
% end
% 
% stem(Dim(1:di),y)
% break

[v,n] = max(R(:));
[pi,zi,ri,di] = ind2sub(size(R),n);

%  R(pi,zi,ri,di)
disp('##############')
disp([T_dop T_zeta T_rr T_Dim;...
      pi zi ri di;...
      dop(pi) zeta(zi) rr(ri) Dim(di)]);
disp([R(pi,zi,ri,di) max(R(:))]);

% load dataset_DI203
% load dataset_D203
% load dataset_D1000
% [RR,MC] = AMDA(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi));
% 
% plot_confusion_matrix(MC)
% title(['Accur: ' num2str(RR)])
% 
% disp(RR)