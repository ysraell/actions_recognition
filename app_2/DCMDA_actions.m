%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_DCMDA,MC_DCMDA,num_max] = DCMDA_actions(trajectories,test_samples,training_samples,dist_method_type,dim_opt_proj,Dim,r)

    % Total classes
    N = max(size(trajectories));
    
    [l,c,p] = size(trajectories{1}{1});
    
    Uc =eye(c,c);
    Up =eye(p,p);
    num_max = zeros(3,2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Training step.
%     disp('Training step')
    
    if (dim_opt_proj>0)
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-mode
        [Ul,num_max(1,:)] = subspace_proj_DCMDA(training_samples,trajectories,N,l,c*p,1,Dim,r);

        if (dim_opt_proj>1)
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-mode
            [Uc,num_max(2,:)] = subspace_proj_DCMDA(training_samples,trajectories,N,c,l*p,2,Dim,r);

            if (dim_opt_proj>2)
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-mode
                [Up,num_max(3,:)] = subspace_proj_DCMDA(training_samples,trajectories,N,p,l*c,3,Dim,r);

            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Testing step.    
    %     disp('Testing step')

        trajectories_proj = trajectories;

        % Project the entire base in the new optimal subspace
        for Ni=1:N
            for Mi = training_samples{Ni}
                trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc',Up'));
            end
            for Mi = test_samples{Ni}
                trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc',Up'));
            end
        end
    else
        trajectories_proj = trajectories;
    end
    
    %%%%% Classification All testing samples vs All training samples
    

    MC = zeros(N,N);

       tic
    for Ni=1:N
        
        M_test = max(size(test_samples{Ni}));
        for i=1:M_test
            
            Mi = test_samples{Ni}(i);
            dist_nii = zeros(N,1);
            for Nii=1:N
                
                    M_training = max(size(training_samples{Nii}));
                    dist_Mii = zeros(M_training,1);
                    for j=1:M_training

                        Mii = training_samples{Nii}(j);
                        %dist_Mii(j) = frob(trajectories_proj{Ni}{Mi}-trajectories_proj{Nii}{Mii});

                        dist_Mii(j) = DIST_method(trajectories_proj{Ni}{Mi},trajectories_proj{Nii}{Mii},dist_method_type);



                    end
                    dist_nii(Nii) = min(dist_Mii);
%                 end
            end
            
            [~,index_img] = min(dist_nii);
            MC(Ni,index_img) = MC(Ni,index_img)+1;
            
        end
        MC(Ni,:) = MC(Ni,:)./M_test;
        
    end
    
    R_DCMDA = sum(diag(MC))/N;
    MC_DCMDA = MC;
    
    
end