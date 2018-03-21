%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DGTDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_DGTDA,Cl_DGTDA,Dist_DGTDA] = DGTDA3_actions(trajectories,test_samples,training_samples)

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

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-mode
    
    % mean tensor class and the mean tensor general
    Yc = zeros(l*c,p,N);
    Ym = zeros(l*c,p);
    for Ni=1:N
        for gmi = training_samples{Ni}
            Yc(:,:,Ni) = Yc(:,:,Ni)+reshape(trajectories{Ni}{gmi},l*c,p);
        end
        Yc(:,:,Ni) = max(size(training_samples{Ni})).\Yc(:,:,Ni);
        Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
    end
    Ym(:,:) = N.\Ym(:,:);

    % bettween scatter 
    Sb = zeros(p,p);
    for Ni=1:N
        A = Yc(:,:,Ni)-Ym(:,:);
        Sb = Sb+A'*A;
    end

    % Wthin scatter
    Sw = zeros(p,p);
    for Ni=1:N
        for gmi = training_samples{Ni}
            A = reshape(trajectories{Ni}{gmi},l*c,p)-Yc(:,:,Ni);
            Sw = Sw+A'*A;
        end
    end
    clear A

    [Up,~] = eig(Sb - Sw);
    clear Sb Sw
    
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
    
    
    %%%%% Classification All testing samples vs All training samples
    
    Cl = zeros(N,1);
    dist_ni = zeros(N,N);
    
    for Ni=1:N
%         disp(Ni)
        for Nii=1:N
            M_test = max(size(test_samples{Ni}));
            dist_mi = zeros(M_test,1);
            cont_Mi=0;
            for Mi = test_samples{Ni}
                cont_Mi=cont_Mi+1;
                M_training = max(size(training_samples{Nii}));
                dist_mii =  zeros(M_training,1);
                cont_Mii =0;
                for Mii = training_samples{Nii}
                    cont_Mii=cont_Mii+1;
                    
                    % Frobeniuns Norm
                    dist_mii(cont_Mii) = frob(trajectories_proj{Ni}{Mi}-trajectories_proj{Nii}{Mii});
                    
                    % 1-NN
%                     dist_mii(Mii) = norm(sinalTeste_proj{Ni}{Mi}-sinalTreino_proj{Nii}{Mii});
                    
                end
                dist_mi(cont_Mi) = min(dist_mii);
            end
            dist_ni(Nii,Ni) = min(dist_mi);
        end
        [~,index_img] = min(dist_ni(:,Ni));
        Cl(Ni) = (Ni==index_img);
    end
    R_DGTDA =  sum(Cl)/N;
    Cl_DGTDA = Cl;
    Dist_DGTDA = dist_ni;
end