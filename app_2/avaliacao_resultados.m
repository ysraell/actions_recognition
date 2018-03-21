clear all
close all
clc

run carrega_resultados.m

fig=0;

fig=fig+1;
figure(fig)
plot_confusion_matrix(MC_DGTDA2_Final_05)
title('Confusion matrix: MDA 3-2, 50%/50%')

fig=fig+1;
figure(fig)
plot_confusion_matrix(MC_DGTDA2_Final_02)
title('Confusion matrix: MDA 3-2, 20%/80%')

fig=fig+1;
figure(fig)
plot_confusion_matrix(MC_DGTDA2_Final)
title('Confusion matrix: MDA 3-2')
