%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DGTDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_DGTDA,MC_DGTDA] = DGTDA2_actions(trajectories,test_samples,training_samples)

    % Total classes
    N = max(size(trajectories));

    [l,c,p] = size(trajectories{1}{1});
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Training step.
%     disp('Training step')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-mode
    
    % mean tensor class and the mean tensor general
    Yc = zeros(l,c*p,N);
    Ym = zeros(l,c*p);
    for Ni=1:N
        for gmi = training_samples{Ni}
            Yc(:,:,Ni) = Yc(:,:,Ni)+reshape(trajectories{Ni}{gmi},l,c*p);
        end
        Yc(:,:,Ni) = max(size(training_samples{Ni})).\Yc(:,:,Ni);
        Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
    end
    Ym(:,:) = N.\Ym(:,:);

    % bettween scatter 
    Sb = zeros(l,l);
    for Ni=1:N
        A = Yc(:,:,Ni)-Ym(:,:);
        Sb = Sb+A*A';
    end

    % Wthin scatter
    Sw = zeros(l,l);
    for Ni=1:N
        for gmi = training_samples{Ni}
            A = reshape(trajectories{Ni}{gmi},l,c*p)-Yc(:,:,Ni);
            Sw = Sw+A*A';
        end
    end
    clear A

    [Ul,~] = eig(Sb - Sw);
    clear Sb Sw

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-mode
    
    % mean tensor class and the mean tensor general
    Yc = zeros(l*p,c,N);
    Ym = zeros(l*p,c);
    for Ni=1:N
        for gmi = training_samples{Ni}
            Yc(:,:,Ni) = Yc(:,:,Ni)+reshape(trajectories{Ni}{gmi},l*p,c);
        end
        Yc(:,:,Ni) = max(size(training_samples{Ni})).\Yc(:,:,Ni);
        Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
    end
    Ym(:,:) = N.\Ym(:,:);

    % bettween scatter 
    Sb = zeros(c,c);
    for Ni=1:N
        A = Yc(:,:,Ni)-Ym(:,:);
        Sb = Sb+A'*A;
    end

    % Wthin scatter
    Sw = zeros(c,c);
    for Ni=1:N
        for gmi = training_samples{Ni}
            A = reshape(trajectories{Ni}{gmi},l*p,c)-Yc(:,:,Ni);
            Sw = Sw+A'*A;
        end
    end
    clear A

    [Uc,~] = eig(Sb - Sw);
    clear Sb Sw Ym Yc
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Testing step.    
%     disp('Testing step')
    
    trajectories_proj = trajectories;
       
    % Project the entire base in the new optimal subspace
    for Ni=1:N
        for Mi = training_samples{Ni}
            trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc'));
        end
        for Mi = test_samples{Ni}
            trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc'));
        end
    end
    
    
   
    
    %%%%% Classification All testing samples vs All training samples
    

    MC = zeros(N,N);
       
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
                    dist_Mii(j) = frob(trajectories_proj{Ni}{Mi}-trajectories_proj{Nii}{Mii});
                    
                end
                dist_nii(Nii) = min(dist_Mii);
            end
            
            [~,index_img] = min(dist_nii);
            MC(Ni,index_img) = MC(Ni,index_img)+1;
            
        end
        MC(Ni,:) = MC(Ni,:)./M_test;
        
    end
    
    R_DGTDA = sum(diag(MC))/N;
    MC_DGTDA = MC;
end