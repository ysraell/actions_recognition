clear all
close all
clc
w = warning ('off','all');
addpath(pwd)
addpath('tensor_toolbox_2.6')
addpath('tensorlab')

% 
% load samples_kfold_A 
% load dataset_A
% N=80;

% 
% load samples_kfold_B 
% load dataset_B
% N=65;

% load samples_kfold_C
% load dataset_C
% N=76;

load samples_kfold_DI700
load dataset_DI700
N=11;

% parpool('local',5)
K=5;
tk=1;

Nframes = [195 205 210 215]; %  200.0000    0.9985
D = max(size(Nframes));
Rmax = zeros(D,1);
for d=1:D

    % Path to database
    data = '/home/israel/Documents/actions_app/Datasets_actions/BMHAD/BerkeleyMHAD/Mocap/OpticalData';
    dataa = '/home/israel/Documents/actions_app/Datasets_actions/BMHAD/BerkeleyMHAD/Accelerometer';


    % Total classes
    N = 11;
    Atores = 12;
    Rep = 5;

    % number_of_frames = 3602.91 -+2510.94, (min/max 774/14567), it is good to
    % 90.17% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
    % tamanho_sinal=6100; 4148611952 B ~ 4 GB
    tamanho_sinal = Nframes(d);

    trajectories = [];
    atores = [];
    missing_files = [];
    missing_count = 0;
    % Size = [];
    cont = 0;
    for n=1:N;
        sample=0;
        for a=1:Atores
            atores_temp = [];
            for r=1:Rep

                filename = strcat(data,'/moc_s',num2str(a,'%02i'),'_a',num2str(n,'%02i'),'_r',num2str(r,'%02i'),'.txt');

                if exist(filename,'file')
                    cont=cont+1;
                    fprintf('D) Generating sample %d for class %d.\n',sample,n)
                    Temp = load(filename);
                    Temp = Temp(:,1:end-2);

                    if (sum(isnan(Temp(:)))>0)
                        disp('##NaN##')
                        disp([n sample])
                    end
                    if (sum(isinf(Temp(:)))>0)
                        disp('##Inf##')
                        disp([n sample])
                    end

                    Temp(isnan(Temp))=0;
                    Temp(isinf(Temp))=0;
    %                 Size(cont) = max(size(Temp));
                    temp_traj = zeros(43+6,tamanho_sinal,3);
                    for j=1:43
                        for i=1:3
                            temp_traj(j,:,i) = normalizar(interpolar(Temp(:,(j*3-(3-i)))',tamanho_sinal-1,'spline'));                    
                        end
                    end
    %                 temp_traj = normalizar(temp_traj);
                    if (sum(isnan(temp_traj(:)))>0)
                        disp('!!NaN!!')
                        disp([n sample])
                    end
                    if (sum(isinf(temp_traj(:)))>0)
                        disp('!!Inf!!')
                        disp([n sample])
                    end


                    for s=1:6
                        filenamea{s} = strcat(dataa,'/Shimmer',num2str(s,'%02i'),'/acc_h',num2str(s,'%02i'),'_s',num2str(a,'%02i'),'_a',num2str(n,'%02i'),'_r',num2str(r,'%02i'),'.txt');
                    end


                    fprintf('I) Generating sample %d for class %d.\n',sample,n)
                    TempA = [];
                    c = Inf;
                    for s=1:6
                        TempA{s} = reshape(load(filenamea{s}),1,[],4);
                        c = min(size(TempA{s},2),c);
                    end

                    Temp = [TempA{1}(1,1:c,1:3); ...
                            TempA{2}(1,1:c,1:3); ...
                            TempA{3}(1,1:c,1:3); ...
                            TempA{4}(1,1:c,1:3); ...
                            TempA{5}(1,1:c,1:3); ...
                            TempA{6}(1,1:c,1:3)];

                    if (sum(isnan(Temp(:)))>0)
                        disp('##NaN##')
                        disp([n sample])
                    end
                    if (sum(isinf(Temp(:)))>0)
                        disp('##Inf##')
                        disp([n sample])
                    end
                    Temp(isnan(Temp))=0;
                    Temp(isinf(Temp))=0;
                    cont=cont+1;
    %                 Size(cont) = max(size(Temp));

                    for j=44:(43+6)
                        for i=1:3
                            temp_traj(j,:,i) = normalizar(interpolar(Temp(:,((j-43)*3-(3-i)))',tamanho_sinal-1,'spline'));
                        end
                    end




                    sample=sample+1;
                    atores_temp = [atores_temp sample];
                    if (sum(isnan(temp_traj(:)))>0)
                        disp('!!NaN!!')
                        disp([n sample])
                    end
                    if (sum(isinf(temp_traj(:)))>0)
                        disp('!!Inf!!')
                        disp([n sample])
                    end
                    temp_traj(isnan(temp_traj))=0;
                    temp_traj(isinf(temp_traj))=0;
                    trajectories{n}{sample} = temp_traj;
                else
                    missing_count=missing_count+1;
                    missing_files{missing_count} = filename;
                end

            end
            atores{a}{n} = atores_temp;
        end
    end
    
    
    
    R = zeros(K,1);
    MC = zeros(N,N,K);
    parfor k=1:K
        disp([k K])
        [R(k),~] = TEST_step_KNN(trajectories,test_samples_kfold{tk}{k},training_samples_kfold{tk}{k},N,'o');
    end
    Rmax(d) = mean(R);
    disp(mean(R))
end

clear trajectories
save search_db_mhad_5fold.mat


