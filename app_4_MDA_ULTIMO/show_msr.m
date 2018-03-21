
%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

Results = dir('search_db_MSR_R_S*.mat');
ResultsKNN = dir('search_dbKNN_MSR_R_S*.mat');


Set=[1 2 3];

S=max(size(Set));
for s=1:S
    
    load(ResultsKNN(s).name,'R','time','FramesN');
    timeKNN = time;
    RKNN = R;
    load(Results(s).name,'R','time');
    
    figure;
    suptitle(['Normalized 4D Set S' num2str(s)])
    subplot(1,2,1)
    h = stem(FramesN,[R RKNN]);
    set(h(1),'LineStyle','none','MarkerFaceColor','blue')
    set(h(2),'LineStyle','none','MarkerFaceColor','green','Marker','square')
    set(h(3),'LineStyle','none','MarkerFaceColor','red','Marker','x')
    set(h(4),'LineStyle','none','MarkerFaceColor','black','Marker','hexagram')
    legend('1-NN/Frob','1-NN/Norm2','k-NN/Frob','k-NN/Norm2')
    title('Acurracy')
    grid
    subplot(1,2,2)
    ht = stem(FramesN,[time timeKNN]);
    set(ht(1),'LineStyle','none','MarkerFaceColor','blue')
    set(ht(2),'LineStyle','none','MarkerFaceColor','green','Marker','square')
    set(ht(3),'LineStyle','none','MarkerFaceColor','red','Marker','x')
    set(ht(4),'LineStyle','none','MarkerFaceColor','black','Marker','hexagram')
    legend('1-NN/Frob','1-NN/Norm2','k-NN/Frob','k-NN/Norm2')
    title('Time')
    grid
    
end

subset = 'abc';
clear Results ResultsKNN RKNN R

for ii=1:3
    clear Results ResultsKNN RKNN R
    Results = dir(['search_db' subset(ii) '_MSR_R_S*.mat']);
    ResultsKNN = dir(['search_db' subset(ii) 'KNN_MSR_R_S*.mat']);


    Set=[1 2 3];

    S=max(size(Set));
    for s=1:S

        load(ResultsKNN(s).name,'R','time');
        timeKNN = time;
        RKNN = R;
        load(Results(s).name,'R','time');

        figure;
        suptitle(['Subset: ' subset(ii) '. Set S' num2str(s)])
        subplot(1,2,1)
        h = stem(FramesN,[R RKNN]);
        set(h(1),'LineStyle','none','MarkerFaceColor','blue')
        set(h(2),'LineStyle','none','MarkerFaceColor','green','Marker','square')
        set(h(3),'LineStyle','none','MarkerFaceColor','red','Marker','x')
        set(h(4),'LineStyle','none','MarkerFaceColor','black','Marker','hexagram')
        legend('1-NN/Frob','1-NN/Norm2','k-NN/Frob','k-NN/Norm2')
        title('Acurracy')
        grid
        subplot(1,2,2)
        ht = stem(FramesN,[time timeKNN]);
        set(ht(1),'LineStyle','none','MarkerFaceColor','blue')
        set(ht(2),'LineStyle','none','MarkerFaceColor','green','Marker','square')
        set(ht(3),'LineStyle','none','MarkerFaceColor','red','Marker','x')
        set(ht(4),'LineStyle','none','MarkerFaceColor','black','Marker','hexagram')
        legend('1-NN/Frob','1-NN/Norm2','k-NN/Frob','k-NN/Norm2')
        title('Time')
        grid

    end
end