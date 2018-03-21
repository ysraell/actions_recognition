

N=max(size(trajectories));

for n=1:N
    M=max(size(trajectories{n}));
    for m=1:M
        
        tmp = trajectories{n}{m};
        if sum(isnan(tmp(:)))>0
            dips([nan n m])
        end
        
        if sum(isinf(tmp(:)))>0
            dips([inf n m])
        end
    end
end