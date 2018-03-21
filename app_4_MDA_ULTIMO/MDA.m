function out = MDA(trajectories,test_samples,training_samples,dop,Dim,rr,zeta,T)
    N = max(size(trajectories));
    [l,c,p] = size(trajectories{1}{1});
    Uc =eye(c,c);
    Up =eye(p,p);
    for t=1:T
        if dop>0
            [Ul,Ll] = subspace_proj_MDA(training_samples,trajectories,N,l,c*p,1,zeta);
        end
        if dop>1
            [Uc,Lc] = subspace_proj_MDA(training_samples,trajectories,N,c,l*p,2,zeta);
        end
        if dop>2
            [Up,Lp] = subspace_proj_MDA(training_samples,trajectories,N,p,l*c,3,zeta);
        end
        trajectories = proj_Func(trajectories,Ul,Uc,Up);
    end
    
    if dop>0
        [Ul,~] = redux_dim(Ul,Ll,Dim,rr);
    end
    if dop>1
        [Uc,~] = redux_dim(Uc,Lc,Dim,rr);
    end
    if dop>2
        [Up,~] = redux_dim(Up,Lp,Dim,rr);
    end
        
    trajectories = proj_Func(trajectories,Ul,Uc,Up);
    [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'f');
    out1 = TMP/TM;
    [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'n');
    out2 = TMP/TM;
    out=max([out1 out2]);
end
