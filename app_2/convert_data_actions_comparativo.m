clear all
close all
clc

% Path to database
data = 'data';

% Path to data for each class


path{1} = 'throwBasketball';
path{2} = 'elbowToKnee1RepsLelbowStart';
path{3} = 'grabHighR';
path{4} = 'hopBothLegs1hops';
path{5} = 'jogLeftCircle4StepsRstart';
path{6} = 'kickLFront1Reps';
path{7} = 'lieDownFloor';
path{8} = 'rotateArmsBothBackward1Reps';
path{9} = 'sneak2StepsLStart';
path{10} = 'squat3Reps';
path{11} = 'depositFloorR';

% Total classes
N = max(size(path));

% as acoes tem de 121 a 901 frames, aqui igualamos em 200
tamanho_sinal=200;
test_samples = [];
training_samples = [];

trajectories = [];

cont = 0;
for Ni=1:N
    test_samples_temp = [];
    training_samples_temp = [];
    sample=1;
    for ator=1:5
        take=1;
        filename = strcat(data,'/',path{Ni},'/HDM_',num2str(ator),'_',num2str(take)','.amc.mat');
        while exist(filename,'file')
            cont = cont+1;
            load(filename);
            
            total_joints = max(size(mot.jointTrajectories));
            [total_coord total_frames] = size(mot.jointTrajectories{1});
            
            temp = zeros(total_joints,tamanho_sinal,total_coord);
            for coord = 1:total_coord
                for joint=1:total_joints
                    temp(joint,:,coord) = interpolar(mot.jointTrajectories{joint}(coord,:),tamanho_sinal-1);
                end
                temp(:,:,coord) = normalizar(temp(:,:,coord));
            end
            
            if ator<3
                test_samples_temp = [test_samples_temp sample];
            else
                training_samples_temp = [training_samples_temp sample];
            end
            
            trajectories{Ni}{sample} = temp;
            clear mot skel
            disp(filename)
            take = take+1;
            sample = sample+1;
            filename = strcat(data,'/',path{Ni},'/HDM_',num2str(ator),'_',num2str(take),'.amc.mat');
        end
    end
    test_samples{Ni} = test_samples_temp;
    training_samples{Ni} = training_samples_temp;
end

save HDM_mot_joint_trajectories_3D_normalizado_interpolado_comparativo.mat trajectories test_samples training_samples

