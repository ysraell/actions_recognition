function out = DMSD(trajectories,test_samples,training_samples,dop,Dim,rr,zeta)
    N = max(size(trajectories));
    [l,c,p] = size(trajectories{1}{1});
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
    [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'f');
    out1 = TMP/TM;
    [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'n');
    out2 = TMP/TM;
    out=max([out1 out2]);
end
