function [U,L] = subspace_proj_GTDA(training_samples,trajectories,N,l,c,mode,zeta)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% n-mode

        % mean tensor class and the mean tensor general
        Yc = zeros(l,c,N);
        Ym = zeros(l,c);
        for Ni=1:N
            for gmi = training_samples{Ni}
                Yc(:,:,Ni) = Yc(:,:,Ni)+double(tenmat(trajectories{Ni}{gmi},mode));
            end
            Yc(:,:,Ni) = max(size(training_samples{Ni})).\Yc(:,:,Ni);
            Ym(:,:) = Ym(:,:)+Yc(:,:,Ni);
        end
        Ym(:,:) = N.\Ym(:,:);

        % bettween scatter 
        Sb = zeros(l,l);
        for Ni=1:N
            A = Yc(:,:,Ni)-Ym(:,:);
            Sb = Sb+max(size(training_samples{Ni})).*A*A';
        end

        % Wthin scatter
        Sw = zeros(l,l);
        for Ni=1:N
            for gmi = training_samples{Ni}
                A = double(tenmat(trajectories{Ni}{gmi},mode))-Yc(:,:,Ni);
                Sw = Sw+A*A';
            end
        end
        clear A

        if (zeta==-1) 
            zeta = max(eig(Sb/Sw));
        end
        
        if (zeta==-2) 
            zeta = max(eig(Sb));
%             disp('zeta = max(eig(Sb))');
%             disp(zeta);
        end
        
        if (zeta==-3) 
            zeta = max(eig(Sw));
%             disp('zeta = max(eig(Sw))');
%             disp(zeta);
        end        
        
%         if (det(Sb)>zeta*det(Sw))
%             disp('det(Sb) det(Sw) zeta*det(Sw) det(Sb)-zeta*det(Sw)')
%             [det(Sb) det(Sw) zeta*det(Sw) det(Sb)-zeta*det(Sw)]
%         else
%             disp('det(Sb) det(Sw) zeta*det(Sw) det(Sb)-zeta*det(Sw)')
%             [det(Sb) det(Sw) zeta*det(Sw) det(Sb)-zeta*det(Sw)]
%         end

        [U,L] = eig(zeta.*Sb - Sw);
        
end