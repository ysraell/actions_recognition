clear all
close all
clc
addpath('HDM05-Parser')

var_sample_size = [1000:100:2000]'; %  max(R(:)) 9236
T=max(size(var_sample_size));
R=zeros(T,1);
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

for t=1:T
    
    tamanho_sinal = var_sample_size(t);
    disp('tamanho_sinal t T')
    disp([tamanho_sinal t T])
    

    % Path to database
    data = '/home/israel/Documents/actions_app/Datasets_actions/BMHAD/BerkeleyMHAD/Mocap/OpticalData';

    % Total classes
    N = 11;
    Atores = 12;
    Rep = 5;

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
%                     fprintf('D) Generating sample %d for class %d.\n',sample,n)
                    Temp = load(filename);
                    Temp = Temp(:,1:end-2);
                    Size(cont) = max(size(Temp));
                    temp_traj = zeros(43,tamanho_sinal,3);
                    for j=1:43
                        for i=1:3
                            temp_traj(j,:,i) = normalizar(interpolar(Temp(:,(j*3-(3-i)))',tamanho_sinal-1,'spline'));                    
                        end
                    end

                    sample=sample+1;
                    atores_temp = [atores_temp sample];
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

    
    [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'f');
    R1 = TMP/TM;
    [TMP,~,TM] = TEST_step(trajectories,test_samples,training_samples,N,'n');
    R2 = TMP/TM;
    R(t) = max([R1 R2]);
    disp(R(t))
end

clear trajectories
  save search_mhad_1.mat 
  pause(5)
%   system('poweroff')