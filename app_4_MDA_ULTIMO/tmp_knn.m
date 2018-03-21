clear all
close all
clc

K = 10;
S = 20;

A = [randn(S,1) randi(5,S,1)];

B = sortrows(A);

pass = 0;
while pass == 0;

    C = B(1:K,:);
    v = unique(C(:,2));
    n = hist(C(:,2),v);
    disp(v(n==max(n)))
    disp(C(:,2))
    
    if sum(n==max(n)) ==1
        pass =1;
    else
        K=K-1;
    end
    
end



% clear all
% close all
% clc
% 
% K = 10;
% S = 20;
% 
% A = [randn(S,1) randi(5,S,1)];
% 
% B = sortrows(A);
% 
% pass = 0;
% while pass == 0;
% 
%     C = B(1:K,:);
%     v = unique(C(:,2));
%     n = hist(C(:,2),v);
%     disp(v(n==max(n)))
%     disp(C(:,2))
%     
%     if sum(n==max(n)) ==1
%         pass =1;
%     else
%         K=K-1;
%     end
%     
% end