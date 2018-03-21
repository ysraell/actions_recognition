%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Load the dataset. Created by Eric Beltrao and John Soldera.
% Modified by Israel Oliveira to use MDA techinics. 01/17
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear all;  
% close all;
%clc;

%% Inicializações

exercicio{1}='depositFloorR_15';
exercicio{2}='elbowToKnee1RepsLelbowStart_15';
exercicio{3}='grabHighR_15';
exercicio{4}='hopBothLegs1hops_15';
exercicio{5}='jogLeftCircle4StepsRstart_15';
exercicio{6}='kickLFront1Reps_15';
exercicio{7}='lieDownFloor_15';
exercicio{8}='rotateArmsBothBackward1Reps_15';
exercicio{9}='sneak2StepsLStart_15';
exercicio{10}='squat3Reps_15';
exercicio{11}='throwBasketball_15';

teste{1}='teste_depositFloorR_15';
teste{2}='teste_elbowToKnee1RepsLelbowStart_15';
teste{3}='teste_grabHighR_15';
teste{4}='teste_hopBothLegs1hops_15';
teste{5}='teste_jogLeftCircle4StepsRstart_15';
teste{6}='teste_kickLFront1Reps_15';
teste{7}='teste_lieDownFloor_15';
teste{8}='teste_rotateArmsBothBackward1Reps_15';
teste{9}='teste_sneak2StepsLStart_15';
teste{10}='teste_squat3Reps_15';
teste{11}='teste_throwBasketball_15';


% ...

% carrega dados de treino
for i=1:size(exercicio,2)
   load(exercicio{i});
end

sinalTreino{1}=depositFloorR_15_2;
sinalTreino{2}=elbowToKnee1RepsLelbowStart_15_2;
sinalTreino{3}=grabHighR_15_2;
sinalTreino{4}=hopBothLegs1hops_15_2;
sinalTreino{5}=jogLeftCircle4StepsRstart_15_2;
sinalTreino{6}=kickLFront1Reps_15_2;
sinalTreino{7}=lieDownFloor_15_2;
sinalTreino{8}=rotateArmsBothBackward1Reps_15_2;
sinalTreino{9}=sneak2StepsLStart_15_2;
sinalTreino{10}=squat3Reps_15_2;
sinalTreino{11}=throwBasketball_15_2;


% carrega dados de teste

for i=1:11
    sinalTeste{i}=[];    
end

for exer=1:size(exercicio,2)    
    temp_teste=load(teste{exer});
    sinalTeste{exer}=[sinalTeste{exer};temp_teste.teste_15];
end


%% ---- ajustar tamanhos entre ações e normalizar valores ----

tamanho_sinal=200; % as acoes tem de 121 a 901 frames, aqui igualamos em 200
mat=[]; % variavel temporaria

for exer=1:size(exercicio,2)
    for acao=1:size(sinalTreino{exer},1)
        for art=1:size(sinalTreino{1,exer}{1,1},1)
            mat=[mat;interpolar(sinalTreino{1,exer}{acao,1}(art,:), (tamanho_sinal))]; 
        end
        sinalTreino{1,exer}{acao,1}=normalizar(mat(:,1:tamanho_sinal));
        mat=[];
    end
    
    for acao=1:size(sinalTeste{exer},1)
        for art=1:size(sinalTeste{1,exer}{1,1},1)
            mat=[mat;interpolar(sinalTeste{1,exer}{acao,1}(art,:), (tamanho_sinal))]; 
        end

        sinalTeste{1,exer}{acao,1}=normalizar(mat(:,1:tamanho_sinal));
        mat=[];
    end
end


%% criar vetores com a sequencia numerada que identifica as
%  repeticoes que fazem parte de cada acao

classe_treino=[];
classe_teste=[];

for i=1:11

     % sequencia numerada das acoes de treino  
       for j=1:size(sinalTreino{i},1)
            classe_treino=[classe_treino,[i]];
       end
     % sequencia numerada das acoes de teste 
       for j=1:size(sinalTeste{i},1)
            classe_teste=[classe_teste,[i]];
       end
       
end

clearvars -except classe_teste classe_treino sinalTeste sinalTreino

for i=1:11
    sinalcompleto{i} =  [sinalTreino{i}; sinalTeste{i}];
end



% EOF


