%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_DCMDA,MC_DCMDA,num_max,E_DCMDA] = CMDA_actions(trajectories,test_samples,training_samples,dist_method_type,dim_opt_proj,Dim,r,T_max,tolerancia)

    % Total classes
    N = max(size(trajectories));
    
    [l,c,p] = size(trajectories{1}{1});

    Ul =eye(l,l);
    Uc =eye(c,c);
    Up =eye(p,p);
    num_max = zeros(3,2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Training step.
%     disp('Training step')
    t=1;
    Erro_it = -ones(T_max,1);
    erro = Inf;
    trajectories_proj = trajectories;
    
    while (t<=T_max)&&(erro>tolerancia)
        
%         disp('iteracao:')
%         disp(t)
        
        if (t>1)
            for Ni=1:N
                for Mi = training_samples{Ni}
                    trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories_proj{Ni}{Mi}),Ul',Uc',Up'));
                end
            end
        end
%         disp([l c p])
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-mode
        [aUl,Ll] = subspace_proj_CMDA(training_samples,trajectories_proj,N,l,c*p,1);


        if (dim_opt_proj>1)
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-mode
            [aUc,Lc] = subspace_proj_CMDA(training_samples,trajectories_proj,N,c,l*p,2);

            if (dim_opt_proj>2)
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-mode
                [aUp,Lp] = subspace_proj_CMDA(training_samples,trajectories_proj,N,p,l*c,3);

            end
        end   
            
                erro = frob(Ul-aUl)+frob(Up-aUp)+frob(Uc-aUc); 
                Erro_it(t) = erro;
                Ul=aUl;
                Uc=aUc;
                Up=aUp;
                t=t+1;
    end
    
%     disp(diag(Ll))
%     disp(diag(Lc))
%     disp(diag(Lp))
    [Ul,num_max(1,:)] =redux_CMDA(aUl,Ll,Dim,r);
    [Uc,num_max(2,:)] =redux_CMDA(aUc,Lc,Dim,r);
    [Up,num_max(3,:)] =redux_CMDA(aUp,Lp,Dim,r);  
    
        
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

    trajectories_proj = trajectories;
    
    
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
    E_DCMDA = Erro_it;
    
    
end