clear all
close all
clc

load dataset_CMU_X.mat

T = max(size(X));

trajectories = [];
c=0;
for t=1:T
    S=max(size(X{t}));
    if S>0
        c=c+1;
        
        m=0;
        for s=1:S
            
            Q=max(size(X{t}{s}));
            
            for q=1:Q
                
                    m=m+1;
                    trajectories{c}{m} = X{t}{s}{q};
                
            end
            
        end
        
    end
    disp([num2str(t) '/' num2str(T)])
end

N=c;

save dataset_CMU.mat trajectories N


