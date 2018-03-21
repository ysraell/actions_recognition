%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [test_samples_,training_samples_] = gen_round(round,trajectories)

    N = max(size(trajectories));

    switch (round)
        case 1
            test_samples = [];
            training_samples = [];
            for Ni=1:N
                M = max(size(trajectories{Ni}));

                if (mod(M,2) == 1)
                    test_samples{Ni} = [1:2:M];
                    training_samples{Ni} = [2:2:M];
                else
                    test_samples{Ni} = [2:2:M]-1;
                    training_samples{Ni} = [2:2:M];
                end

            end
            
        case 2
            test_samples = [];
            training_samples = [];
            for Ni=1:N
                M = max(size(trajectories{Ni}));

                if mod(M,2) == 1
                    test_samples{Ni} = [2:2:M];
                    training_samples{Ni} = [1:2:M];
                else
                    test_samples{Ni} = [2:2:M];
                    training_samples{Ni} = [2:2:M]-1;
                end

            end
            
        case 3
            test_samples = [];
            training_samples = [];
            for Ni=1:N
                M = max(size(trajectories{Ni}));
                M2 = floor(M/2);

                test_samples{Ni} = [1:M2];
                training_samples{Ni} = [M2+1:M];

            end
            
        case 4
            test_samples = [];
            training_samples = [];
            for Ni=1:N
                M = max(size(trajectories{Ni}));
                M2 = floor(M/2);

                test_samples{Ni} = [M2+1:M];
                training_samples{Ni} = [1:M2];

            end
            
        otherwise 
            test_samples = [];
            training_samples = [];
            for Ni=1:N
                M = max(size(trajectories{Ni}));
                M2 = floor(M/2);

                temp1 = [1:M2];
                temp2 = [M2+1:M];
                
                loops = round-4;
                
                for i=1:loops
                    temp11 = [temp2(end) temp1(1:end-1)];
                    temp21 = [temp1(end) temp2(1:end-1)];
                    temp1 = temp11;
                    temp2 = temp21;
                end

                
                test_samples{Ni} = temp1;
                training_samples{Ni} = temp2;
                
            end
            
     end
    
    
    test_samples_ = test_samples;
    training_samples_ = training_samples;
    
end