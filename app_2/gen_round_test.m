

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function a = gen_round_test(b)


    switch b
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
        otherwise
            disp(b)
    end
    
    a = b;
end