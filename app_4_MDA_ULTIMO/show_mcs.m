clear  all
close all
clc

load dataset_S1
N=max(size(trajectories));
[test_samples,training_samples,test_count,training_count] = gen_by_authors(trajectories,atores,[2 4 6 8 10],[1 3 5 7 9]);
[tmp,MC] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'o');
disp(tmp)
plot_confusion_matrix(MC)