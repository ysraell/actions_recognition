
clear all

%%%%%%%%%%%%%%test_mhad_results_DI700_TMP
% load test_msr_results_S220_TMP.mat
% load test_mhad_results_DI700_kfold_TMP
load results_test_ixmas_TMP
A = Dim(di);
[v,n] = max(R(:));
disp(size(R));

% break

[pi,zi,ri,di] = ind2sub(size(R),n);

%  R(pi,zi,ri,di)
disp([T_dop T_zeta T_rr T_Dim;...
      pi zi ri di;...
      dop(pi) zeta(zi) rr(ri) Dim(di)]);

  disp([A R(pi,zi,ri,di) max(R(:))]);
% 
%   
%       3.0000    7.0000    2.0000    3.0000
%     1.0000    3.0000    1.0000    2.0000
%     1.0000    2.0000         0    0.5000
% 
%     0.9782    0.9782