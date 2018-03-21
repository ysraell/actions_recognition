

function [DIST] = DIST_method(A,B,dist_method_type)

    
    switch dist_method_type
        case 1
            [l,c,p] = size(A);
            DIST = norm(reshape(A-B,l,c*p),1);
        case 2
            [l,c,p] = size(A);
            DIST = norm(reshape(A-B,l,c*p),2);
        case 3
            DIST = frob(A-B);
        case 4
            DIST = -1/frob(A-B);
        case 5
%             disp('SSIM calculating...')
%             DIST = -1/(1-ssim(A,B));
            DIST = -ssim(A,B);
%             disp('SSIM calculating... done!')
%             
    end
            
            

end