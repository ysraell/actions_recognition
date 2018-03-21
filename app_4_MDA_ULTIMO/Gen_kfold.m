clear all
close all
clc

% load dataset_A
% load dataset_B
% load dataset_C
load dataset_DI700

% K-Fold Croos-Validation
K = 5;
TK = 50;

N = max(size(trajectories));
for tk=1:TK
    for n=1:N

        NN = max(size(trajectories{n}));
        if NN<K
            rand_samps = randperm(NN);
            temp = zeros(K,1);
            s=0;
            for l=1:K
                s=s+1;
                if s>NN
                    s=1;
                end
                temp(l)= rand_samps(s);
            end
        else
            rand_samps = randperm(NN);
            part_size = ceil(NN/K);
            temp = zeros(K,part_size);

            l=0;
            c=1;
            for nn=1:NN

                l=l+1;
                if l>K 
                    l=1;
                    c=c+1;
                end

                temp(l,c) = rand_samps(nn);

            end
        end
        Samps_Kfold{tk}{n} = temp;

    end
%     disp([tk TK])
end

% save Samps_Kfold_A.mat  Samps_Kfold
% save Samps_Kfold_B.mat  Samps_Kfold
% save Samps_Kfold_C.mat  Samps_Kfold
save Samps_Kfold_DI700.mat  Samps_Kfold