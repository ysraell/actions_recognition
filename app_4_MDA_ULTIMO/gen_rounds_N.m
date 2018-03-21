%%%%%%%%%%%


clear all
close all
clc

load dataset_N_notraj.mat


combs = combnk(1:5,2);
T_com = max(size(combs));

test_samples = [];
training_samples = [];
r=0;
[N,S] = size(map_cameras);

for t=1:T_com    
    for n=1:N
        temp1 = [];
        temp2 = [];
        for s=1:S
            switch map_cameras(n,s)
                case combs(t,1)
                    temp1 = [temp1 s];
                case combs(t,2)
                    temp2 = [temp2 s];
            end
        end
        training_samples{t}{n} = temp1;
        test_samples{t}{n} = temp2;        
        training_samples{t+T_com}{n} = temp2;
        test_samples{t+T_com}{n} = temp1;

    end
    disp([t T_com])
end

Rounds = T_com*2;

save rounds_N.mat training_samples test_samples Rounds


