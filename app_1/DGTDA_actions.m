%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DGTDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [R_DGTDA,MC_DGTDA] = DGTDA_actions(classe_teste,classe_treino,sinalTeste,sinalTreino)

    [l,c] = size(sinalTeste{1}{1});
    N = max(classe_teste);
    
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Training step.
    disp('Training step')
    
    % mean tensor class and the mean tensor general
    Yc = zeros(l,c,N);
    Ym = zeros(l,c);
    for Ni=1:N
        gm = sum( classe_treino == Ni );
        for gmi=gm
            Yc(:,:,Ni) = Yc(:,:,Ni)+sinalTreino{Ni}{gmi};
        end
        Yc(:,:,Ni) = gm.\Yc(:,:,Ni);
        Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
    end
    Ym(:,:) = N.\Ym(:,:);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-mode

    % bettween scatter 
    Sb = zeros(l,l);
    for Ni=1:N
        A = Yc(:,:,Ni)-Ym(:,:);
        Sb = Sb+A*A';
    end

    % Wthin scatter
    Sw = zeros(l,l);
    for Ni=1:N
        gm = sum( classe_treino == Ni );
        for gmi=gm
            A = sinalTreino{Ni}{gmi}-Yc(:,:,Ni);
            Sw = Sw+A*A';
        end
    end
    clear A

    [Ul,~] = eig(Sb - Sw);
    clear Sb Sw

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-mode

    % bettween scatter 
    Sb = zeros(c,c);
    for Ni=1:N
        A = Yc(:,:,Ni)-Ym(:,:);
        Sb = Sb+A'*A;
    end

    % Wthin scatter
    Sw = zeros(c,c);
    for Ni=1:N
        gm = sum( classe_treino == Ni );
        for gmi=gm
            A = sinalTreino{Ni}{gmi}-Yc(:,:,Ni);
            Sw = Sw+A'*A;
        end
    end
    clear A

    [Uc,~] = eig(Sb - Sw);
    clear Sb Sw Ym Yc

    
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
    
%     Cl = zeros(N,1);
%     dist_ni = zeros(N,N);
%     
%     for Ni=1:N
%         disp(Ni)
%         for Nii=1:N
%             M_test = sum( classe_teste == Ni );
%             M_training = sum( classe_treino == Nii );
%             
%             dist_mi = zeros(M_test,1);
%             for Mi=1:M_test
%                 dist_mii =  zeros(M_training,1);
%                 for Mii=1:M_training
%                     
%                     % Frobeniuns Norm
%                     dist_mii(Mii) = frob(sinalTeste_proj{Ni}{Mi}-sinalTreino_proj{Nii}{Mii});
%                     
%                     % 1-NN
% %                     dist_mii(Mii) = norm(sinalTeste_proj{Ni}{Mi}-sinalTreino_proj{Nii}{Mii});
%                     
%                 end
%                 dist_mi(Mi) = min(dist_mii);
%             end
%             dist_ni(Nii,Ni) = min(dist_mi);
%         end
%         [~,index_img] = min(dist_ni(:,Ni));
%         Cl(Ni) = (Ni==index_img);
%     end
%     R_GTDA_actions =  sum(Cl)/N;
%     Cl_GTDA_actions = Cl;
%     Dist_GTDA_actions = dist_ni;
%     
    
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


    %%%%% Classification All testing samples vs All training samples
    

    MC = zeros(N,N);
       
    for Ni=1:N
        
        M_test = sum( classe_teste == Ni );
        for i=1:M_test
            
            dist_nii = zeros(N,1);
            for Nii=1:N
                
                M_training = sum( classe_treino == Nii );
                dist_Mii = zeros(M_training,1);
                for j=1:M_training
                    
                    dist_Mii(j) = frob(sinalTeste_proj{Ni}{i}-sinalTreino_proj{Nii}{j});
                    
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