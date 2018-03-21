clear

movimento=[];
teste=[];

pasta='data/throwBasketball/HDM';

for ator=3:5
    
    arq=sprintf('%s_%d*.mat',pasta,ator);

    arquivos=ls(arq); % lista arquivos por usuario
    n=sum(arquivos=='.'); % quantos arquivos esse user tem
    n=n/2;
    for repeticao=1:n

        carregar=sprintf('%s_%d_%d.amc.mat',pasta,ator,repeticao);
        load(carregar);

        t=size(mot.jointTrajectories{1},2);
        matriz_Ang=[];
        for i=1:t

            a=1; b=2; c=7;
            matriz_Ang(1,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]); 

            a=2; b=1; c=3;
            matriz_Ang(2,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=7; b=1; c=8;
            matriz_Ang(3,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=3; b=2; c=4;
            matriz_Ang(4,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=8; b=7; c=9;
            matriz_Ang(5,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=4; b=3; c=6;
            matriz_Ang(6,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=9; b=8; c=11;
            matriz_Ang(7,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=14; b=16; c=25;
            matriz_Ang(8,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
           
            a=16; b=14; c=17;
            matriz_Ang(9,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]); 

            a=18; b=19; c=14;
            matriz_Ang(10,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=25; b=26; c=14;
            matriz_Ang(11,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=19; b=18; c=21;
            matriz_Ang(12,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=26; b=25; c=28;
            matriz_Ang(13,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=21; b=19; c=23;
            matriz_Ang(14,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=28; b=26; c=30;
            matriz_Ang(15,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

            
        end % fim i
        
        movimento{end+1,1}=matriz_Ang;
        
    end % fim repeticao
end  % fim ator


for ator=1:2
    
    arq=sprintf('%s_%d*.mat',pasta,ator);

    arquivos=ls(arq); % lista arquivos por usuario
    n=sum(arquivos=='.'); % quantos arquivos esse user tem
    n=n/2;
    for repeticao=1:n

        carregar=sprintf('%s_%d_%d.amc.mat',pasta,ator,repeticao);
        load(carregar);

        t=size(mot.jointTrajectories{1},2);
        matriz_Ang=[];
        for i=1:t

            a=1; b=2; c=7;
            matriz_Ang(1,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]); 

            a=2; b=1; c=3;
            matriz_Ang(2,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=7; b=1; c=8;
            matriz_Ang(3,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=3; b=2; c=4;
            matriz_Ang(4,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=8; b=7; c=9;
            matriz_Ang(5,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=4; b=3; c=6;
            matriz_Ang(6,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=9; b=8; c=11;
            matriz_Ang(7,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=14; b=16; c=25;
            matriz_Ang(8,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
           
            a=16; b=14; c=17;
            matriz_Ang(9,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]); 

            a=18; b=19; c=14;
            matriz_Ang(10,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=25; b=26; c=14;
            matriz_Ang(11,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=19; b=18; c=21;
            matriz_Ang(12,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=26; b=25; c=28;
            matriz_Ang(13,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=21; b=19; c=23;
            matriz_Ang(14,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);
            
            a=28; b=26; c=30;
            matriz_Ang(15,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

            
        end % fim i
        
        teste{end+1,1}=matriz_Ang;
        
    end % fim repeticao
end  % fim ator
    
% plot3(mot.jointTrajectories{1}(1,1),mot.jointTrajectories{1}(2,1),mot.jointTrajectories{1}(3,1))
% hold on;
% for i=2:t
%     scatter3(mot.jointTrajectories{i}(1,1),mot.jointTrajectories{i}(2,1),mot.jointTrajectories{i}(3,1));
% end