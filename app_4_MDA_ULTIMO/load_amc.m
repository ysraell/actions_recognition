clear all
close all

clc

load -ascii index_files.txt
T_files = max(size(index_files));
s=index_files;
X = [];
str_files  =num2str(T_files);
sample = 0;
for f=1:T_files
    files_amcs = dir([num2str(s(f,1),'%02d') '_' num2str(s(f,2),'%02d') '[*].amc']);
    T_files_amcs = max(size(files_amcs));
    for t=1:T_files_amcs
        TMP = amc_to_matrix(files_amcs(t).name);
        X{s(f,1)}{s(f,2)}{t} = resize(TMP,[62 150],'spline');
    end
    disp([num2str(f) '/' str_files])
end

% disp([mean(L) std(L) min(L) max(L)])
% disp([mean(C) std(C) min(C) max(C)])

%   146.9430   40.2166   71.0000  283.0000
% 
%     62     0    62    62
% trajectories = X;
save dataset_CMU_X.mat X

