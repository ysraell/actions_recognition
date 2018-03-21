function [U,L] = subspace_proj_CMDA(training_samples,trajectories,N,l,c,mode)

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

%         switch opt_type
%             case 1
%                 [V,L] = eig(Sb/Sw);
%             case 2
% 
%             case 3
%                 Sb = Sb./frob(Sb);
%                 Sw = Sw./frob(Sw);
%                 [V,L] = eig(Sb,Sw);
%         end

        Sb = Sb./frob(Sb);
        Sw = Sw./frob(Sw);
        [U,L] = eig(Sb/Sw);
        
end