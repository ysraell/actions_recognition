clear all
close all
clc

Results =  dir('search_MDA_MSR_S*.mat');

TR=max(size(Results));
RR=zeros(TR,1);
for i=1:TR
    
    load(Results(i).name)
    RR(i) = Rmax;
    
end

disp([RR(1) RR(2) RR(3) mean(RR)])