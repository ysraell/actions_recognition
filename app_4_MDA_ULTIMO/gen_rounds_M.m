clear all
close all
load dataset_M

Reps{1} = [1 2 3];
Reps{2} = [1 2 4];
Reps{3} = [1 3 2];
Reps{4} = [1 3 4];
Reps{5} = [1 4 2];
Reps{6} = [1 4 3];
Reps{7} = [2 3 1];
Reps{8} = [2 3 4];
Reps{9} = [2 4 1];
Reps{10} = [2 4 3];
Reps{11} = [3 4 1];
Reps{12} = [3 4 2];

N = 30;
Atores = 9;
Rep = 4;

Rounds = 12;
test_samples = [];
training_samples = [];
for r=1:Rounds
    for n=1:N
        temp1 = [];
        temp2 = [];        
        for a=1:Atores
            if max(size(atores{a}{n}))==4
                temp1 = [temp1 atores{a}{n}(Reps{r}(3))];
                temp2 = [temp2 atores{a}{n}(Reps{r}(1:2))];
            elseif max(size(atores{a}{n}))==3
                temp1 = [temp1 atores{a}{n}(3)];
                temp2 = [temp2 atores{a}{n}(1:2)];
            elseif max(size(atores{a}{n}))==2
                temp1 = [temp1 atores{a}{n}(2)];
                temp2 = [temp2 atores{a}{n}(1)];
            elseif max(size(atores{a}{n}))==1
                temp1 = [temp1 atores{a}{n}(1)];
                temp2 = [temp2 atores{a}{n}(1)];                
            end
        end
        test_samples{r}{n} = temp1;
        training_samples{r}{n} = temp2;
    end
end

save rounds_M.mat test_samples training_samples Rounds

