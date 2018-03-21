clear all
close all
clc

% load Samps_Kfold_A
% N=80;
% 
% load Samps_Kfold_B
% N=65;
% 
% load Samps_Kfold_C
% N=76;

load Samps_Kfold_DI700
N=11;

K=5;
TK=50;
% N = max(size(trajectories));


for tk=1:TK
    for k=1:K


        for n=1:N

            tmp = Samps_Kfold{tk}{n};
            [ll,cc] = size(tmp);

            temp = [];
            for c=1:cc 
                if tmp(k,c)>0
                    temp = [temp tmp(k,c)];
                end
            end
            test_samples_kfold{tk}{k}{n} = temp;

            temp = [];
            for kk=1:K
                if kk~=k
                    for c=1:cc 
                        if tmp(kk,c)>0
                            temp = [temp tmp(kk,c)];
                        end
                    end
                end
            end
            training_samples_kfold{tk}{k}{n} = temp;
        end
    end
    disp([tk TK])
end

% save samples_kfold_A.mat training_samples_kfold test_samples_kfold 
% save samples_kfold_B.mat training_samples_kfold test_samples_kfold 
% save samples_kfold_C.mat training_samples_kfold test_samples_kfold 
save samples_kfold_DI700.mat training_samples_kfold test_samples_kfold 