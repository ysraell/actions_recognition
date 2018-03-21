clear all
close all
clc

load results_MDA_actions_atores_combinacao_180317_geral_1

% [T_dist,T_zeta,T_dim_p,T_Dim,T_atores] 
Y = zeros(T_atores,T_dist,T_dim_p,T_Dim);
R = zeros(4,T_dist,T_dim_p,T_Dim);
for dimi =1:T_Dim
    for m =1:T_dim_p
        Y(:,:,m,dimi) = reshape(R_DGTDA(:,1,m,dimi,:),T_atores,T_dist);
        X(1,:,m,dimi) = mean(Y(:,:,m,dimi));
        X(2,:,m,dimi) = std(Y(:,:,m,dimi));
        X(3,:,m,dimi) = max(Y(:,:,m,dimi));
        X(4,:,m,dimi) = min(Y(:,:,m,dimi));
        for k=1:T_dist
            Y1(m,dimi,k) = X(1,k,m,dimi);
            Y2(m,dimi,k) = X(2,k,m,dimi);
            Y3(m,dimi,k) = X(3,k,m,dimi);
            Y4(m,dimi,k) = X(4,k,m,dimi);
        end
    end
end




fig=0;
fig=1+fig;
figure(fig)
surf(dim_opt_proj',Dim',Y1(:,:,1)')










% load results_MDA_actions_atores_rotativo_170317_var_dim_001_03_SSIM.mat
% Y1 = reshape(R_DGTDA,2,T_Dim)';
% T1 = reshape(T_DGTDA,2,T_Dim)';
% X1 = Dim';
% load results_MDA_actions_atores_rotativo_170317_var_dim_03_05_SSIM.mat
% Y2 = reshape(R_DGTDA,2,T_Dim)';
% T2 = reshape(T_DGTDA,2,T_Dim)';
% X2 = Dim';
% load results_MDA_actions_atores_rotativo_170317_var_dim_SSIM_022_0025_029.mat
% Y3 = reshape(R_DGTDA,2,T_Dim)';
% T3 = reshape(T_DGTDA,2,T_Dim)';
% X3 = Dim';
% load results_MDA_actions_atores_rotativo_170317_var_dim_SSIM.mat
% 
% fig=0;
% 
% 
% fig=fig+1;
% figure(fig)
% plot(Dim,reshape(R_DGTDA,2,T_Dim)')

% [mean(C) std(C)]
% 0.3339    0.4063  290.6787    0.0848    0.0351   89.1789
