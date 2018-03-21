clear all
close all
clc

load dataset_DI700

C=1;
S=1;

X = trajectories{C}{S};
% rankest(X);
% R = [50:10:100];
% T_R = max(size(R));
% res = zeros(T_R,1);
% for i=1:T_R
%     disp(i)
%     U = cpd(X,R(i));
%     res(i) = frobcpdres(X,U)/frob(X);
% end
% 
% figure;
% plot(R,res)
break
T=10;
R=20;
clear V VT U U0
U0 = cpd_rnd(size(X),R);
error = zeros(T,1);
U = cpd(X,U0);
VT{1} = U{1};
VT{2} = U{2};
V{1} = VT;
close all
mesh(cpdgen(V{1}))
for N=1:T
    U = cpd(X,U0);
    VT{1} = U{1};
    VT{2} = U{2};
    V{N+1} = VT;
    clear VT
    error(N) = frob(cpdgen(V{N+1})-cpdgen(V{N}))/frob(cpdgen(V{N}));
    figure;
    mesh(cpdgen(V{N+1}))
end

stem(error)

% close all
% for i=1:3
%     figure;
%     mesh(U{i})
% end