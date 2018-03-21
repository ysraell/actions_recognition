clear all
close all
clc

x = 1:31;
k = 3;
X = combnk(x,k);
NX = max(size(X));
Y = zeros(NX,k,2);


for ni=1:NX
    Y(ni,:,1) = X(ni,:);
    Y(ni,:,2) = X(ni,[2 1 3]);
end