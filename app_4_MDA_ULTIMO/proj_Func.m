 function out = proj_Func(trajectories,Ul,Uc,Up)

        % Project the entire base in the new optimal subspace
        N = max(size(trajectories));
        [~,~,p] = size(ful(trajectories{1}{1}));
        if p>1
            for Ni=1:N
                M = max(size(trajectories{Ni}));
                for Mi=1:M
                    trajectories{Ni}{Mi} = double(ttensor(tensor(ful(trajectories{Ni}{Mi})),Ul',Uc',Up'));
                end
            end
        else
            for Ni=1:N
                M = max(size(trajectories{Ni}));
                for Mi=1:M
                    trajectories{Ni}{Mi} = double(ttensor(tensor(ful(trajectories{Ni}{Mi})),Ul',Uc'));
                end
            end
        end
        out=trajectories;
 end