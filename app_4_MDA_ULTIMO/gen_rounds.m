%%%%%%%%%%%%%%%%
%
% Outer-3-fold-Inner-10-fold cv
%
%%%%%%%%%%%%%%%%

clear all
close all
clc

load dataset_CMU.mat % trajectories N

kfold = [];

for n=1:N
    M = max(size(trajectories{n}));
    temp = randperm(M);
    SM = floor(M/15);    
    if SM>0
        for s=1:15
            kfold{n}{s} = temp(1+(s-1)*SM:s*SM);
        end

        s=0;
        for i=15*SM+1:M
            s=s+1;
            kfold{n}{s} = [kfold{n}{s} temp(i)];
        end
    else
        for s=1:M
            kfold{n}{s} = temp(s);
        end
        i=0;
        for s=M+1:15
            i=i+1;
            kfold{n}{s} = temp(i);
        end
    end
end

Folds = [];

% Folds{o}{r}{n}

for o=1:3
    for r=1:5
        for n=1:N
            Folds{o}{r}{n} = kfold{n}{r+(o-1)*5};
        end
    end
end
    
for o=1:3
    for n=1:N
        training{o}{n} =  [];
    end
    for n=1:N
        for r=1:5
            training{o}{n} =  [training{o}{n} Folds{o}{r}{n}];
        end
    end
end

OR = [3     2;
      3     1;
      2     1];

for o=1:3
    for round=1:10
        for n=1:N
            testing_label{o}{round}{n} =  [];
            testing_unlabel{o}{round}{n} =  [];
        end   
        for n=1:N
            rr = 0;
            for r=1:5
                for i=1:2
                    rr=rr+1;
                    if rr==round
                        testing_unlabel{o}{round}{n} =  [testing_unlabel{o}{round}{n} Folds{OR(o,i)}{r}{n}];
                    else
                        testing_label{o}{round}{n} =  [testing_label{o}{round}{n} Folds{OR(o,i)}{r}{n}];
                    end
                end
            end
        end
    end
end



save rounds_var.mat testing_unlabel testing_label training Folds
