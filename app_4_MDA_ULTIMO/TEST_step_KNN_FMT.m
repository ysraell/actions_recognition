%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cOMPATIBLE WITH K-Fold cross-validation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_,MC_] = TEST_step_KNN(trajectories,test_samples,training_samples,N,dist_method_type)

    K=6; % Depois pode-se ajustar como argumento de entrada

    TM =0;
    for Ni=1:N
        M_test = max(size(test_samples{Ni}));
        TM=TM+M_test;
        for i=1:M_test
            Mi = test_samples{Ni}(i);
            KNN_dist{Ni}{Mi} = [inf(K,1) zeros(K,1)];
            for Nii=1:N
                M_training = max(size(training_samples{Nii}));
                for j=1:M_training
                    Mii = training_samples{Nii}(j);
                    a=dist_method_type;
                     if (a=='x')||(a=='y')||(a=='z')
                        tmp = DIST_method(trajectories{Ni}{Mi},trajectories{Nii}{Mii},dist_method_type);
                     else 
                        A=ful(trajectories{Ni}{Mi});
                        B=ful(trajectories{Nii}{Mii});
                        tmp = DIST_method(A,B,dist_method_type);
                     end
                    TMP = sortrows([KNN_dist{Ni}{Mi}; tmp Nii],1);
                    KNN_dist{Ni}{Mi} = TMP(1:K,:);
%                     disp(TMP)
%                     disp(TMP(1:K,:))
                end
            end
        end
    end
    
    MC = zeros(N,N,K);
    
    for Ni=1:N
        M_test = max(size(test_samples{Ni}));
        for i=1:M_test
            Mi = test_samples{Ni}(i);
            for k=1:K
                if k>2
                    Kt=k;
                    TMP = KNN_dist{Ni}{Mi};
                    pass = 0;
                    while pass == 0;

                        v = unique(TMP(1:Kt,2));
                        n = histc(TMP(1:Kt,2),v);
                        if (sum(n==max(n))==1)&&(v(n==max(n))>0)
                            pass =1;
                        else
                            Kt=Kt-1;
                        end

                    end
%                 disp(n==max(n))
%                 disp(n)
%                 disp(v)
%                 disp(TMP(1:Kt,2))
                    if v(n==max(n))>0
                        MC(Ni,v(n==max(n)),k) = MC(Ni,v(n==max(n)),k)+1;
                    end
                elseif k==1
                    TMP = KNN_dist{Ni}{Mi};
%                     disp(TMP)
%                     disp(TMP(1,2))
%                     disp([Ni Mi])
                    if TMP(1,2)>0
                       MC(Ni,TMP(1,2),k) = MC(Ni,TMP(1,2),k)+1;
                    end
                end                
            end
        end
        MC(Ni,:,:)= MC(Ni,:,:)./M_test;
    end
    
    R = zeros(K,1);
    
    for k=1:K
        R(k) = sum(diag(MC(:,:,k)))./N;
    end
%     stem(1:K,R)
    
    [R_,kmax] = max(R);
%    disp(['Kmax = ' num2str(Kmax_)])
    MC_ = MC(:,:,kmax);
    
end
    %EOF