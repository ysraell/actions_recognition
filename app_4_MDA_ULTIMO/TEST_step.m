%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cOMPATIBLE WITH K-Fold cross-validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_,MC_] = TEST_step(trajectories,test_samples,training_samples,N,dist_method_type)

    TM =0;
    MC = zeros(N,N);
    for Ni=1:N
        M_test = max(size(test_samples{Ni}));
        TM=TM+M_test;
        for i=1:M_test
            Mi = test_samples{Ni}(i);
            dist_nii = zeros(N,1);
            for Nii=1:N
                    M_training = max(size(training_samples{Nii}));
                    dist_Mii = zeros(M_training,1);
                    for j=1:M_training
                        Mii = training_samples{Nii}(j);
%                         disp([Ni Mi])
%                         disp([Nii Mii])
                        if (Ni==Nii)&&(Mi==Mii)
                            dist_Mii(j) = Inf;
%                             disp('Error!: (Ni==Nii)&&(Mi==Mii) -> true!!!!')
                        else 
                            dist_Mii(j) = DIST_method(trajectories{Ni}{Mi},trajectories{Nii}{Mii},dist_method_type);
                        end
                    end
                    dist_nii(Nii) = min(dist_Mii);
            end
            [~,index_img] = min(dist_nii);
            MC(Ni,index_img) = MC(Ni,index_img)+1;
        end
        MC(Ni,:) = MC(Ni,:);
    end
    
    R_ = sum(diag(MC))/TM;
    MC_ = MC;
    
end
    %EOF