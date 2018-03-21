%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [OUT] = TensorProject(X,test_samples,training_samples,training_count,R)

    [l,c,p] = size(X{1}{1});
    
    T = zeros(l,c,p,training_count);
%     index = zeros(training_count,2);
    C = max(size(training_samples));
    coount =0;
    for c=1:C
        S = max(size(training_samples{c}));
        for s=1:S
            disp('Building big T')
            disp([s S c C])
            coount=coount+1;
            T(:,:,:,coount) = X{c}{s};
%             index(coount,:) = [c s];
        end
    end
    disp('*****')
    disp('CPD in the big T')

    if R>0
%         rankest(T)
        U = cpd(T,R);
    else
        RR = rankest(T);
        U = cpd(T,RR);
    end
        
%     M = cpdgen({U{1} U{2} U{3}});
    
    model = struct;
    model.variables.d = randn(1, R);
    model.factors.A = U{1};
    model.factors.B = U{2};
    model.factors.C = U{3};
    model.factors.D = 'd';
    model.factorizations.tensor.cpd = {'A', 'B', 'C', 'D'};

    C = max(size(X));
    for c=1:C
        S = max(size(X{c}));
        for s=1:S
            disp('Creating Y.')
            disp([s S c C])
            model.factorizations.tensor.data = X{c}{s};
            sdf_check(model);
            sol = sdf_nls(model);
            Y{c}{s} = sol.factors.D;
        end
    end

    
    
%     C = max(size(test_samples));
%     for c=1:C
%         S = max(size(test_samples{c}));
%         for s=1:S
%             disp('Creating Y training.')
%             disp([s S c C])
%             model.factorizations.tensor.data = X{c}{test_samples{c}(s)};
%             sdf_check(model);
%             sol = sdf_nls(model);
%             Y{c}{s} = sol.factors.D;
%         end
%     end
%     
%     for coount=1:training_count
%        c = index(coount,1);
%        s = index(coount,2);
%        disp('Creating Y testing.')
%        Y{c}{s} = U{4}(coount,:);
%     end
%     
    OUT=Y;
end


%EOF