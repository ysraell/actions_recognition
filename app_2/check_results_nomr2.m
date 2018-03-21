close all
clear all
clc

load results_MDA_actions_rand_270317_norm2_comp

Y = zeros(2,T_rounds,4);
Y(:,:,1) = reshape(R_DGTDA(1,1,:,1,:,1),2,T_rounds);
Y(:,:,2) = reshape(R_DGTDA(1,1,:,1,:,2),2,T_rounds);
Y(:,:,3) = reshape(R_DGTDA(1,1,:,2,:,1),2,T_rounds);
Y(:,:,4) = reshape(R_DGTDA(1,1,:,2,:,2),2,T_rounds);

for i=1:4
    [mean(Y(:,:,i)')' std(Y(:,:,i)')' max(Y(:,:,i)')' min(Y(:,:,i)')']
end

