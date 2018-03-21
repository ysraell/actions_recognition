clear all
close all
clc

% Load all results for comp exps.
dirRR = dir('results_comp_*.mat');
RN = size(dirRR,1);

TBest_rr = [0 0]';
TBest_zeta = zeros(7,1);
TBest_Proj = zeros(3,1);
s=0;
for rn=1:RN
    load(dirRR(rn).name)
    TR = size(Results,1);
    for tr=1:TR
        s=s+1;
        RR{s} = Results(tr);
        TS{s} = max(size(size(RR{s}.R)));
        mRR{s} = mean(RR{s}.R,TS{s});
        sRR{s} = std(RR{s}.R,[],TS{s});
        minRR{s} = min(RR{s}.R,[],TS{s});
        maxRR{s} = max(RR{s}.R,[],TS{s});
        TBest_rr(RR{s}.Best_rr+1) = TBest_rr(RR{s}.Best_rr+1)+1;
        TBest_zeta(RR{s}.Best_zeta+1) = TBest_zeta(RR{s}.Best_zeta+1)+1;
        TBest_Proj(RR{s}.Best_Proj) = TBest_Proj(RR{s}.Best_Proj)+1;
        
        tmp = Results(tr).Dataset;
        if (tmp == 'A')||(tmp == 'B')||(tmp == 'C')
%             disp(Results(tr).Best_R)
%             disp(Results(tr).Best_Dim)
%             disp(Results(tr).Best_zeta)

             if TS{s}==6
                 tmp = Results(tr).R(:,:,:,:,:,10);
                 disp(max(tmp(:)))
             else
                 tmp = Results(tr).R(:,:,:,:,:,:,10);
                 disp(max(tmp(:)))
             end

        end
    end
%     disp(dirRR(rn).name)
%     disp(TS{s})
    
end
NRR=s;
break
% Verify the Proporcional dim by eigenvalues or size dim (Soldera and Shark. idea)
% Two plots: performance by Dim, w/ and w/out rr

for n=1:NRR

    % mix diff distances
    if size(mRR{n},1)>1
        ymRR{n} = mean(mRR{n},1);
        ysRR{n} = mean(sRR{n},1);
        yminRR{n} = min(minRR{n},[],1);
        ymaxRR{n} = max(maxRR{n},[],1);
    else
        ymRR{n} = mRR{n};
        ysRR{n} = sRR{n};
        yminRR{n} = minRR{n};
        ymaxRR{n} = maxRR{n};            
    end

    if TS{n}==6
        %mix zetas
        yymRR{n} = mean(ymRR{n},3);
        yysRR{n} = mean(ysRR{n},3);
        yyminRR{n} = min(yminRR{n},[],3);
        yymaxRR{n} = max(ymaxRR{n},[],3);        
    else
        %mix iterations
        yymRR{n} = mean(ymRR{n},3);
        yysRR{n} = mean(ysRR{n},3);
        yyminRR{n} = min(yminRR{n},[],3);
        yymaxRR{n} = max(ymaxRR{n},[],3);  
        %mix zetas
        yymRR{n} = mean(ymRR{n},4);
        yysRR{n} = mean(ysRR{n},4);
        yyminRR{n} = min(yminRR{n},[],4);
        yymaxRR{n} = max(ymaxRR{n},[],4); 
    end
    
    %mix projections
    yyymRR{n} = mean(yymRR{n},2);
    yyysRR{n} = mean(yysRR{n},2);
    yyyminRR{n} = min(yyminRR{n},[],2);
    yyymaxRR{n} = max(yymaxRR{n},[],2);        
    
    % 1 apriori dim (calssical idea), 2 aposteriori dim (soldera idea)

    if TS{n}==6
        for rr=1:2
            T_dim = max(size((yyymRR{n})));
            TMP = yyymRR{n}(:,:,:,rr,:);
            R = TMP(:);
            figure;
            plot(Dim',R)
            pause
            close all
        end
    else
        for rr=1:2
            T_dim = max(size((yyymRR{n})));
            TMP = yyymRR{n}(:,:,:,:,rr,:);
            R = TMP(:);
            figure;
            plot(Dim',R)
            pause
            close all
        end        
    end
    
end








