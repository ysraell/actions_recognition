
%load results_MDA_actions_250117.mat
load results_MDA_actions_rand_080217

k=3;

%%%%%%%%%%%%%%%% MDA 3-2 0.5
MC = zeros(N,N);

j=1;
for r=1:T_rounds
    MC = MC+MC_DGTDA2(:,:,k,r,j);
end

MC_DGTDA2_Final_05 = MC./(T_rounds);
R_DGTDA2_Final_05 = [mean(R_DGTDA2(k,:,j)') std(R_DGTDA2(k,:,j)') max(R_DGTDA2(k,:,j)') min(R_DGTDA2(k,:,j)')];



%%%%%%%%%%%%%%%% MDA 3-3 0.5
MC = zeros(N,N);

j=1;
for r=1:T_rounds
    MC = MC+MC_DGTDA3(:,:,k,r,j);
end

MC_DGTDA3_Final_05 = MC./(T_rounds);
R_DGTDA3_Final_05 = [mean(R_DGTDA3(k,:,j)') std(R_DGTDA3(k,:,j)') max(R_DGTDA3(k,:,j)') min(R_DGTDA3(k,:,j)')];


%%%%%%%%%%%%%%%% MDA 3-2 0.2
MC = zeros(N,N);

j=2;
for r=1:T_rounds
    MC = MC+MC_DGTDA2(:,:,k,r,j);
end

MC_DGTDA2_Final_02 = MC./(T_rounds);
R_DGTDA2_Final_02 = [mean(R_DGTDA2(k,:,j)') std(R_DGTDA2(k,:,j)') max(R_DGTDA2(k,:,j)') min(R_DGTDA2(k,:,j)')];



%%%%%%%%%%%%%%%% MDA 3-3 0.2
MC = zeros(N,N);

j=2;
for r=1:T_rounds
    MC = MC+MC_DGTDA3(:,:,k,r,j);
end

MC_DGTDA3_Final_02 = MC./(T_rounds);
R_DGTDA3_Final_02 = [mean(R_DGTDA3(k,:,j)') std(R_DGTDA3(k,:,j)') max(R_DGTDA3(k,:,j)') min(R_DGTDA3(k,:,j)')];

% %%%%%%%%%%%%%%% MDA 3-2 
% MC = zeros(N,N);
% 
% for j=1:T_bal
%     for r=1:T_rounds
%         MC = MC+MC_DGTDA2(:,:,k,r,j);
%     end
% end
% 
% MC_DGTDA2_Final = MC./(T_bal*T_rounds);
% R_DGTDA2_Final = [mean([R_DGTDA2(k,:,1); R_DGTDA2(k,:,2)]) std([R_DGTDA2(k,:,1); R_DGTDA2(k,:,2)]) max(R_DGTDA2(k,:,j)') min(R_DGTDA2(k,:,j)')];
% 
% 
% 
% %%%%%%%%%%%%%%% MDA 3-3
% MC = zeros(N,N);
% 
% for j=1:T_bal
%     for r=1:T_rounds
%         MC = MC+MC_DGTDA3(:,:,k,r,j);
%     end
% end
% 
% MC_DGTDA3_Final = MC./(T_bal*T_rounds);
% R_DGTDA2_Final = [mean(R_DGTDA3(k,:,j)') std(R_DGTDA2(k,:,j)')];







