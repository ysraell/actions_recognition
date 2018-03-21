
%  clear all
%  close all
%  clc

FramesN = [3:200];
T_frames = max(size(FramesN));
addpath('HDM05-Parser')

SN{1} =[2 3 5 6 10 13 18 20];   % S1
SN{2} =[1 4 7 8 9 11 14 12]; %S2
SN{3} =[6 14 15 16 17 18 19 20]; %S3 

for s=1:3

    R = zeros(T_frames,2); 
    time = zeros(T_frames,2); 
    for t=1:T_frames
        % Path to database
        data = '/home/israel/Documents/actions_app/Datasets_actions/MSRA3D/MSRAction3D/MS3';
        % data = '/home/israel/Documents/actions_app/Thesis/Thesis/Action3D';

        % Total classes

        Atores = 10;
        Rep = 3;



        % number_of_frames = 39.7681 +- 10.0809, (min/max 20/76), it is good to
        % 90.41% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
        tamanho_sinal=FramesN(t);

        trajectories = [];
        atores = [];
        missing_files = [];
        missing_count = 0;
        NN=0;
        cont=0;

         for n=SN{s}; 
            NN=NN+1;
            sample=0;
            for a=1:Atores
                atores_temp =[];
                for r=1:Rep

                    %filename = strcat(data,'/moc_s',num2str(n,'%02i'),'_a',num2str(a,'%02i'),'_r',num2str(r,'%02i'),'.txt');
                    filename = strcat(data,'/a',num2str(n,'%02i'),'_s',num2str(a,'%02i'),'_e',num2str(r,'%02i'),'_skeleton3D.txt');

                    if exist(filename,'file')
                        cont=cont+1;
    %                     fprintf('H) Generating sample %d for class %d.\n',sample,n)

                        Temp = load(filename);

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


                        [l,c] = size(Temp);
                        Temp = reshape(Temp,20,l/20,4);
                        Temp = Temp(:,:,1:3);
                        
                        temp_traj = zeros(20,tamanho_sinal,3);
                        for j=1:20
                            for i=1:3
                                temp_traj(j,:,i) = normalizar(interpolar(Temp(j,:,i),tamanho_sinal-1,'nearst'));
%                                 temp_traj(j,:,i) = interpolar(Temp(j,:,i),tamanho_sinal-1,'nearst');
                            end
                        end


%                         temp_traj = zeros(20,tamanho_sinal,4);
%                         for j=1:20
%                             for i=1:4
% %                                 temp_traj(j,:,i) = normalizar(interpolar(Temp(j,:,i),tamanho_sinal-1,'nearst'));
%                                 temp_traj(j,:,i) = interpolar(Temp(j,:,i),tamanho_sinal-1,'nearst');
%                             end
%                         end


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

                        sample=sample+1;
                        atores_temp = [atores_temp sample];
                        trajectories{NN}{sample} = temp_traj;
                    else
                        missing_count=missing_count+1;
                        missing_files{missing_count} = filename;
                    end

                end
                atores{a}{NN} = atores_temp;
            end
        end

        [test_samples,training_samples,test_count,training_count] = gen_by_authors(trajectories,atores,[2 4 6 8 10],[1 3 5 7 9]);
        tic
        tic
        [R(t,1),~] = TEST_step_KNN(trajectories,test_samples,training_samples,NN,'f');
        time(t,1)  =toc;
        tic
        [R(t,2),~] = TEST_step_KNN(trajectories,test_samples,training_samples,NN,'o');
        time(t,2)  =toc;



        disp('############')
        disp(R(t,:))
        disp(time(t,:))
    end

    disp(max(R))

    save(['search_dbbKNN_MSR_R_S' num2str(s) '.mat'])
    
end