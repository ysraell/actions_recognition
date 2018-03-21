%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by GTDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [R_GTDA_actions,Cl_GTDA_actions,Dist_GTDA_actions] = GTDA_actions(classe_teste,classe_treino,sinalTeste,sinalTreino,Tmax,tol,Dim_red,zeta)

    [l,c] = size(sinalTeste{1}{1});
    ll = Dim_red(1);
    cc = Dim_red(2);
    N = max(classe_teste);
    

    Ulb = eye(l,ll);
    Ucb = eye(c,cc);
    Ul = zeros(l,ll);
    Uc = zeros(c,cc);
    t=1;
    err = 1000;
    
    
    while (t<=Tmax)&&(err>tol)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Training step.
        disp('Training step')

        % mean tensor class and the mean tensor general
        Yc = zeros(ll,cc,N);
        Ym = zeros(ll,cc);
        for Ni=1:N
            gm = sum( classe_treino == Ni );
            for gmi=gm
                Yc(:,:,Ni) = Yc(:,:,Ni)+double(ttensor(tensor(sinalTreino{Ni}{gmi}),Ulb',Ucb'));
            end
            Yc(:,:,Ni) = gm.\Yc(:,:,Ni);
            Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
        end
        Ym(:,:) = N.\Ym(:,:);


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-mode

        % bettween scatter 
        Sb = zeros(ll,ll);
        for Ni=1:N
            A = Yc(:,:,Ni)-Ym(:,:);
            Sb = Sb+A*A';
        end

        % Wthin scatter
        Sw = zeros(ll,ll);
        for Ni=1:N
            gm = sum( classe_treino == Ni );
            for gmi=gm
                A = double(ttensor(tensor(sinalTreino{Ni}{gmi}),Ulb',Ucb'))-Yc(:,:,Ni);
                Sw = Sw+A*A';
            end
        end
        clear A

        [Ul(1:ll,:),~] = eig(Sb-zeta.*Sw);
        clear Sb Sw

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-mode

        % bettween scatter 
        Sb = zeros(cc,cc);
        for Ni=1:N
            A = Yc(:,:,Ni)-Ym(:,:);
            Sb = Sb+A'*A;
        end

        % Wthin scatter
        Sw = zeros(cc,cc);
        for Ni=1:N
            gm = sum( classe_treino == Ni );
            for gmi=gm
                A = double(ttensor(tensor(sinalTreino{Ni}{gmi}),Ulb',Ucb'))-Yc(:,:,Ni);
                Sw = Sw+A'*A;
            end
        end
        clear A

        [Uc(1:cc,:),~] = eig(Sb-zeta.*Sw);
        clear Sb Sw Ym Yc
        
        err = max([norm(Ul*Ulb'-eye(l)) norm(Uc*Ucb'-eye(c))]);
        disp([t err])
 
        Ulb = Ul;
        Ucb = Uc;
        t=t+1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Testing step.    
    disp('Testing step')
    
    sinalTeste_proj = sinalTreino;
    sinalTreino_proj = sinalTreino;
    
    % Project the entire base in the new optimal subspace
    for Ni=1:N
        M = sum( classe_treino == Ni );
        for Mi=1:M
            sinalTreino_proj{Ni}{Mi} = double(ttensor(tensor(sinalTreino{Ni}{Mi}),Ul',Uc'));
        end
        M = sum( classe_teste == Ni );
        for Mi=1:M
            sinalTeste_proj{Ni}{Mi} = double(ttensor(tensor(sinalTeste{Ni}{Mi}),Ul',Uc'));
        end
    end
    
    
    %%%%% Classification All testing samples vs All training samples
    
    Cl = zeros(N,1);
    dist_ni = zeros(N,N);
    
    for Ni=1:N
        disp(Ni)
        for Nii=1:N
            M_test = sum( classe_teste == Ni );
            M_training = sum( classe_treino == Nii );
            
            dist_mi = zeros(M_test,1);
            for Mi=1:M_test
                dist_mii =  zeros(M_training,1);
                for Mii=1:M_training
                    
                    % Frobeniuns Norm
                    dist_mii(Mii) = frob(sinalTeste_proj{Ni}{Mi}-sinalTreino_proj{Nii}{Mii});
                    
                    % 1-NN
%                     dist_mii(Mii) = norm(sinalTeste_proj{Ni}{Mi}-sinalTreino_proj{Nii}{Mii});
                    
                end
                dist_mi(Mi) = min(dist_mii);
            end
            dist_ni(Nii,Ni) = min(dist_mi);
        end
        [~,index_img] = min(dist_ni(:,Ni));
        Cl(Ni) = (Ni==index_img);
    end
    R_GTDA_actions =  sum(Cl)/N;
    Cl_GTDA_actions = Cl;
    Dist_GTDA_actions = dist_ni;
    
    
        %%%%% Classification one testing sample vs All training samples
%     
%     R_Cl = zeros(N,1);
%     for Ni=1:N
%         M_test = sum( classe_teste == Ni );
%         dist_mi = zeros(N,M_test);
%         Cl = zeros(M_test,1);
%         for Mi=1:M_test
%             for Nii=1:N
%                 M_training = sum( classe_treino == Nii );
%                 dist_mii = zeros(M_training,1);
%                 for Mii=1:M_training
%                     
%                     % Frobeniuns Norm
%                     dist_mii(Mii) = frob(sinalTeste_proj{Ni}{Mi}-sinalTreino_proj{Nii}{Mii});
%                     
%                     % 1-NN
% %                     dist_mii(Mii) = norm(sinalTeste_proj{Ni}{Mi}-sinalTreino_proj{Nii}{Mii});   
% 
%                 end
%                 dist_mi(Nii,Mi) = min(dist_mii);
%             end
%             [~,index_img] = min(dist_mi(:,Mi));
%             Cl(Mi) = (Ni==index_img);
%         end
%         R_Cl(Ni) = sum(Cl)/M_test;
%     end
%     
%     R_GTDA_actions = R_Cl;
%     Cl_GTDA_actions = 0;
%     Dist_GTDA_actions = 0;
%     
    
end