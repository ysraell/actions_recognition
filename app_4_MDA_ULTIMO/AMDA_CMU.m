



function [out] = AMDA_CMU(trajectories,testing_unlabel,testing_label,training,dop,Dim,rr,zeta,dist_method)

    R = zeros(10,2);
    N = max(size(trajectories));
    [l,c,p] = size(ful(trajectories{1}{1}));

    Uc =eye(c,c);
    Up =eye(p,p);
    if dop>0
        [Ul,~] = subspace_proj_DMDA(training,trajectories,N,l,c*p,1,Dim,rr,zeta);
    end
    if dop>1
        [Uc,~] = subspace_proj_DMDA(training,trajectories,N,c,l*p,2,Dim,rr,zeta);
    end
    if dop>2
        [Up,~] = subspace_proj_DMDA(training,trajectories,N,p,l*c,3,Dim,rr,zeta);
    end
    trajectories_DMDA = proj_Func(trajectories,Ul,Uc,Up);  


    Uc =eye(c,c);
    Up =eye(p,p);
    if dop>0
        [Ul,~] = subspace_proj_DMSD(training,trajectories,N,l,c*p,1,Dim,rr,zeta);
    end
    if dop>1
        [Uc,~] = subspace_proj_DMSD(training,trajectories,N,c,l*p,2,Dim,rr,zeta);
    end
    if dop>2
        [Up,~] = subspace_proj_DMSD(training,trajectories,N,p,l*c,3,Dim,rr,zeta);
    end
    trajectories_DMSD = proj_Func(trajectories,Ul,Uc,Up);

    
    for r=1:10
        [R(r,1),~] = TEST_step(trajectories_DMDA,testing_unlabel{r},testing_label{r},N,dist_method);
        [R(r,2),~] = TEST_step(trajectories_DMSD,testing_unlabel{r},testing_label{r},N,dist_method);
    end

    
    
    out = R;
    
end

