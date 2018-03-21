clear all
close all
clc

% Path to database
data = '/home/israel/Documents/actions_app/Datasets_actions/IXMAS';


actors{1} = 'alba';
actors{2} = 'amel';
actors{3} = 'andreas';
actors{4} = 'chiara';
actors{5} = 'clare';
actors{6} = 'daniel';
actors{7} = 'florian';
actors{8} = 'hedlena';
actors{9} = 'julien';
actors{10} = 'nicolas';
% actors{11} = 'pao';
% actors{12} = 'srikumar';

Choose_class = [1 2 3 4 5 6 7 8 9 10 12];

Reps = 3;
Cams = 5;

nx=200;
ny=200;
nz=50;


trajectories = [];
atores = [];

T_actors = max(size(actors));
T_cc = max(size(Choose_class));

map_cameras = zeros(T_cc,T_actors*Reps*Cams);
class_samples = zeros(T_cc,1);
s = 0;
for a=1:T_actors
    atores_temp = [];
    for r=1:Reps
        pathstr = [data '/' actors{a} num2str(r) '_pbm'];
        frames_truth = load([data '/' actors{a} num2str(r) '_truth.txt']);
        F = max(size(frames_truth));
        N = max(frames_truth);
        for c=1:Cams
            
            dirstr = [pathstr '/cam' num2str(c-1)];
            frames = dir([dirstr '/*.pbm']);
            
            TMP = imread([dirstr '/' frames(1).name]);
            [ll,cc] = size(TMP);

            Temp = [];
            for n=1:N
                if sum(n==Choose_class)
                    Tframes = sum(frames_truth==n);
                    Temp{n} = zeros(ll,cc,Tframes);
                end
            end

            Ncont = zeros(N,1);
            for f=1:F
                n = frames_truth(f);
                if sum(n==Choose_class)
                    Ncont(n)=Ncont(n)+1;
                    TMP = imread([dirstr '/' frames(f).name]);
                    Temp{n}(:,:,Ncont(n)) = TMP;
                end
            end
            
            
            for n=1:T_cc
                class_samples(n)=class_samples(n)+1;
                trajectories{n}{class_samples(n)} = int8(100.*resize(double(Temp{Choose_class(n)}),[nx ny nz],'spline'));
                map_cameras(n,class_samples(n)) = c;
            end
            atores_temp = [atores_temp class_samples];
            
            disp([T_actors Reps Cams])
            disp([a r c])
            
        end
    end
    for n=1:T_cc
       atores{a}{n} =  atores_temp(n,:);
    end
end

cont = sum(class_samples);
set_str = 'IXMAS';
N = T_cc;
save -v7.3 dataset_N.mat trajectories atores cont set_str map_cameras N
save -v7.3 dataset_N_notraj.mat atores cont set_str map_cameras N


