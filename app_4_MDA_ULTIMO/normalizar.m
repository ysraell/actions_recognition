function out = normalizar(sinal)
    
    tmp = (max(sinal(:))-min(sinal(:)));
    if tmp>0.001 
        out = (sinal-min(sinal(:)))/tmp;
    else
        out = 0.*sinal;
    end
%     out = sinal./max(abs(sinal(:)));
    
end