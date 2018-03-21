clear all
close all
clc
addpath('HDM05-Parser')

var_sample_size = [690 695 699 701 705 710]'; %  max(R(:)) 9236
T=max(size(var_sample_size));
RR=zeros(T,2);
% 
% > max(R(:))
% 
% ans =
% 
%     0.9309
% 
% var_sample_size
% 
% var_sample_size =
% 
%     53
%    103
%    153
%    203
%    253
%    303
%    353
%    403
%    453
%    503



% max(R(:))
% 
% ans =
% 
%     0.9164
% 
% var_sample_size
% 
% var_sample_size =
% 
%      5
%     10
%     15
%     20
%     25
%     30
%     35
%     40
%     45
%     50
%     55
% time = zeros(T,4);
% Path to database
data = '/home/israel/Documents/actions_app/Datasets_actions/BMHAD/BerkeleyMHAD/Mocap/OpticalData';
dataa = '/home/israel/Documents/actions_app/Datasets_actions/BMHAD/BerkeleyMHAD/Accelerometer';
% Total classes
N = 11;
Atores = 12;
Rep = 5;


for t=1:T
    
    tamanho_sinal = var_sample_size(t);
    disp('#####################')
    disp('tamanho_sinal t T')
    disp([tamanho_sinal t T])
    

    
    % number_of_frames = 3602.91 -+2510.94, (min/max 774/14567), it is good to
    % 90.17% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
    % tamanho_sinal=6100; 4148611952 B ~ 4 GB
    % tamanho_sinal = 1100;

    trajectories = [];
    atores = [];
    missing_files = [];
    missing_count = 0;
    Size = [];
    cont = 0;
    for n=1:N;
        sample=0;
        for a=1:Atores
            atores_temp = [];
            for r=1:Rep

            filename = strcat(data,'/moc_s',num2str(a,'%02i'),'_a',num2str(n,'%02i'),'_r',num2str(r,'%02i'),'.txt');
            
                if exist(filename,'file')
                    cont=cont+1;
    %                 fprintf('D) Generating sample %d for class %d.\n',sample,n)
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


    %                 fprintf('I) Generating sample %d for class %d.\n',sample,n)
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
    
    [test_samples,training_samples,test_count,training_count] = gen_by_authors(trajectories,atores,8:12,1:7);
    
    [Rf,~] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'f');
    [Rn,~] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'n');
    [vmax,imax] = max([Rf Rn]);
    RR(t,:) = [vmax imax];
%     load test_mhad_results_D203
%     [v,n] = max(R(:));
%     [pi,zi,ri,di] = ind2sub(size(R),n);
%     [RR(t),~] = AMDA(trajectories,test_samples,training_samples,dop(pi),Dim(di),rr(ri),zeta(zi));
%     
%     time(t,4)=toc;
%     figure;
%     tic
%     [TMP,~,TM] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'f');
%     R(t) = TMP/TM;
%     R1 = TMP/TM;
% %     disp(R1)
%     time(t,1)=toc;
%     figure;
%     tic
%     [TMP,~,TM] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'o');
%     R2 = TMP/TM;
%     time(t,2)=toc;
% %     disp(R2)
%     figure;
%     tic
%     [TMP,~,TM] = TEST_step_KNN(trajectories,test_samples,training_samples,N,'n');
%     R3 = TMP/TM;
%     time(t,3)=toc;
%     R(t) = max([R1 R2 R3]);
%     figure;
%     stem([1 2 3],[R1 R2 R3])
    disp(RR(t,:))
end

clear trajectories
  save search_mhad_spline700c.mat 
%   pause(5)
%   system('poweroff')