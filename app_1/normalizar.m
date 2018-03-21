function out = normalizar(sinal)
    
    out = (sinal-min(sinal(:)))/(max(sinal(:))-min(sinal(:)));
    
end