%%%%%%%%%%%


clear all
close all
clc

load dataset_O2_notraj.mat


combs = [1 2 3;
         1 3 2;
         2 3 1];
T_com = max(size(combs));

test_samples = [];
training_samples = [];

T_a = max(size(atores));

for t=1:T_com    
    for n=1:N
        temp1 = [];
        temp2 = [];

        for a=1:T_a
            
            temp1 = [temp1 atores{a}{n}(combs(t,1:2))];
            temp2 = [temp2 atores{a}{n}(combs(t,3))];
            
        end
        
        training_samples{t}{n} = temp1;
        test_samples{t}{n} = temp2;        

    end
    disp([t T_com])
end

Rounds = T_com;

save rounds_O2.mat training_samples test_samples Rounds


