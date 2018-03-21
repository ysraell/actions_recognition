 clear all
 close all
 clc

%i=0; for a in `cat list |grep bend`; do let "i+=1";  echo "trajectories{}{$i} = $a;"; done
file = '/home/israel/Documents/actions_app/Datasets_actions/ASTS/classification_masks.mat';
load(file)


trajectories{1}{1} = aligned_masks.daria_jump;
trajectories{1}{2} = aligned_masks.denis_jump;
trajectories{1}{3} = aligned_masks.eli_jump;
trajectories{1}{4} = aligned_masks.ido_jump;
trajectories{1}{5} = aligned_masks.ira_jump;
trajectories{1}{6} = aligned_masks.lena_jump;
trajectories{1}{7} = aligned_masks.lyova_jump;
trajectories{1}{8} = aligned_masks.moshe_jump;
trajectories{1}{9} = aligned_masks.shahar_jump;

trajectories{2}{1} = aligned_masks.daria_run;
trajectories{2}{2} = aligned_masks.denis_run;
trajectories{2}{3} = aligned_masks.eli_run;
trajectories{2}{4} = aligned_masks.ido_run;
trajectories{2}{5} = aligned_masks.ira_run;
trajectories{2}{6} = aligned_masks.lena_run1;
trajectories{2}{7} = aligned_masks.lyova_run;
trajectories{2}{8} = aligned_masks.moshe_run;
trajectories{2}{9} = aligned_masks.shahar_run;
% trajectories{2}{10} = aligned_masks.lena_run2;

trajectories{3}{1} = aligned_masks.daria_walk;
trajectories{3}{2} = aligned_masks.denis_walk;
trajectories{3}{3} = aligned_masks.eli_walk;
trajectories{3}{4} = aligned_masks.ido_walk;
trajectories{3}{5} = aligned_masks.ira_walk;
trajectories{3}{6} = aligned_masks.lena_walk1;
trajectories{3}{7} = aligned_masks.lyova_walk;
trajectories{3}{8} = aligned_masks.moshe_walk;
trajectories{3}{9} = aligned_masks.shahar_walk;
% trajectories{3}{10} = aligned_masks.lena_walk2;


% S =zeros(3,90);
% s=0;
% for n=1:10
%     for a=1:9
%         atores{a}{n} = a;
%         s=s+1;
%         [S(1,s),S(2,s),S(3,s)] = size(trajectories{n}{a});
%     end
% end
% [mean(S,2) std(S,[],2) min(S,[],2) max(S,[],2)]
% 
%   114.2667    5.6126  103.0000  129.0000
%    77.1778   10.1257   59.0000  103.0000
%    61.4667   21.9331   28.0000  146.0000

nx=15;
ny=15;
nz=15; %% desired output dimensions

% [X,Y,Z] = meshgrid(1:nx,1:ny,1:nz);

for n=1:3
    for a=1:9
        atores{a}{n} = a;
        trajectories{n}{a} = resize(double(trajectories{n}{a}),[nx ny nz],'spline');
%         close all
%         figure;
%         subplot(1,2,1)       
%         imagesc(sum(double(trajectories{n}{a}),3))
%         subplot(1,2,2)                   
%         imagesc(sum(Temp,3))
%         pause
        
    end
end

N=3;

set_str = 'J';

save -v7.3 dataset_JJ.mat trajectories atores set_str N


