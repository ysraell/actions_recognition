clear all
close all
clc

load dataset_DI700
C = max(size(trajectories));
S = zeros(C,1);
for c=1:C
    S(c) = max(size(trajectories{c}));
end

R=20;
U0 = cpd_rnd(size(trajectories{1}{1}),R);

error_c = zeros(C,2);
for c=1:C
    disp([c C])
    clear error U UU
    error = zeros(S(c)-1,2);
    U = cpd(trajectories{c}{1},U0);
    UU{1} = U{1};
    UU{2} = U{2};
    T = cpdgen(UU);
    ft = frob(T);
    ftr= frob(trajectories{c}{1});
    for s=2:S(c)
        clear V VV
        V = cpd(trajectories{c}{s},U0);
        VV{1} = V{1};
        VV{2} = V{2};
        error(s-1,1) = frob(cpdgen(VV)-T);
        error(s-1,2) = frob(trajectories{c}{s}-trajectories{c}{1});
    end
%     figure;
%     stem(error)
%     legend('Decomposed','Original')
    error_c(c,:) = mean(error);
    error_s{c} = error;
end

figure;
stem(error_c)

