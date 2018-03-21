



function [out,MC_] = AMDA(trajectories,test_samples,training_samples,dop,Dim,rr,zeta)
    N = max(size(trajectories));
    [l,c,p] = size(ful(trajectories{1}{1}));
    outa = zeros(2,1);
    MC = zeros(N,N,2);
    Uc =eye(c,c);
    Up =eye(p,p);
    if dop>0
        [Ul,~] = subspace_proj_DMDA(training_samples,trajectories,N,l,c*p,1,Dim,rr,zeta);
    end
    if dop>1
        [Uc,~] = subspace_proj_DMDA(training_samples,trajectories,N,c,l*p,2,Dim,rr,zeta);
    end
    if dop>2
        [Up,~] = subspace_proj_DMDA(training_samples,trajectories,N,p,l*c,3,Dim,rr,zeta);
    end
    trajectories_A = proj_Func(trajectories,Ul,Uc,Up);
    [outa(1),MC(:,:,1)] = TEST_step_KNN(trajectories_A,test_samples,training_samples,N,'n');
%     [outa(2),MC(:,:,2)] = TEST_step_KNN(trajectories_A,test_samples,training_samples,N,'o');
%     [outa(5),MC(:,:,5)] = TEST_step_KNN(trajectories_A,test_samples,training_samples,N,'n');
    
    
    
    
    Uc =eye(c,c);
    Up =eye(p,p);
    if dop>0
        [Ul,~] = subspace_proj_DMSD(training_samples,trajectories,N,l,c*p,1,Dim,rr,zeta);
    end
    if dop>1
        [Uc,~] = subspace_proj_DMSD(training_samples,trajectories,N,c,l*p,2,Dim,rr,zeta);
    end
    if dop>2
        [Up,~] = subspace_proj_DMSD(training_samples,trajectories,N,p,l*c,3,Dim,rr,zeta);
    end
    trajectories = proj_Func(trajectories,Ul,Uc,Up);
    [outa(2),MC(:,:,2)] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'n');
%     [outa(4),MC(:,:,4)] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'o');
%     [outa(6),MC(:,:,6)] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'n');
%     disp(outa)
    [out,iout]=max(outa);
    MC_=MC(:,:,iout);
    
end

