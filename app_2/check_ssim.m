clear all
close all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado.mat


N=11;
D = 2;
y = zeros(N,N,D);
s=0;
for Ni=1:N
    Simax = max(size(trajectories{Ni}));
    for Nii=1:N
        disp([Ni Nii])
        dist_i = zeros(Simax,D);
        for Si=1:Simax
            Siimax = max(size(trajectories{Nii}));
            dist_ii = zeros(Siimax,1);
            for Sii=1:Siimax
%               tic
                if (Ni==Nii)&&(Si==Sii) 
                    dist_ii(Sii,1) = NaN;
                else
%                     dist_ii(Sii,1) = frob(trajectories{Ni}{Si}-trajectories{Nii}{Sii});
                    dist_ii(Sii,1) = ssim(trajectories{Ni}{Si},trajectories{Nii}{Sii});
                end
%               s=s+1;
%               m(s)=toc;
            end
            dist_i(Si,1) = min(dist_ii(:,1));
            dist_i(Si,2) = max(dist_ii(:,1));
        end
        y(Ni,Nii,1) = min(dist_i(:,1));
        y(Ni,Nii,2) = max(dist_i(:,2));
    end
end
save check_distances_1st_NN_090317_SSIM.mat

N=11;
D = 2;
z = zeros(N,N,D);
s=0;
for Ni=1:N
    Simax = max(size(trajectories{Ni}));
    for Nii=1:N
        disp([Ni Nii])
        dist_i = zeros(Simax,D);
        for Si=1:Simax
            Siimax = max(size(trajectories{Nii}));
            dist_ii = zeros(Siimax,1);
            for Sii=1:Siimax
%               tic
                if (Ni==Nii)&&(Si==Sii) 
                    dist_ii(Sii,1) = NaN;
                else
                    dist_ii(Sii,1) = frob(trajectories{Ni}{Si}-trajectories{Nii}{Sii});
%                     dist_ii(Sii,1) = ssim(trajectories{Ni}{Si},trajectories{Nii}{Sii});
                end
%               s=s+1;
%               m(s)=toc;
            end
            dist_i(Si,1) = min(dist_ii(:,1));
            dist_i(Si,2) = max(dist_ii(:,1));
        end
        z(Ni,Nii,1) = min(dist_i(:,1));
        z(Ni,Nii,2) = max(dist_i(:,2));
    end
end
save check_distances_1st_NN_090317_SSIM.mat

[l,c,p] = size(trajectories{1}{1});

N=11;
D = 2;
w = zeros(N,N,D);
s=0;
for Ni=1:N
    Simax = max(size(trajectories{Ni}));
    for Nii=1:N
        disp([Ni Nii])
        dist_i = zeros(Simax,D);
        for Si=1:Simax
            Siimax = max(size(trajectories{Nii}));
            dist_ii = zeros(Siimax,1);
            for Sii=1:Siimax
%               tic
                if (Ni==Nii)&&(Si==Sii) 
                    dist_ii(Sii,1) = NaN;
                else
                    dist_ii(Sii,1) = norm(reshape(trajectories{Ni}{Si}-trajectories{Nii}{Sii},l,c*p));
%                     dist_ii(Sii,1) = ssim(trajectories{Ni}{Si},trajectories{Nii}{Sii});
                end
%               s=s+1;
%               m(s)=toc;
            end
            dist_i(Si,1) = min(dist_ii(:,1));
            dist_i(Si,2) = max(dist_ii(:,1));
        end
        w(Ni,Nii,1) = min(dist_i(:,1));
        w(Ni,Nii,2) = max(dist_i(:,2));
    end
end
save check_distances_1st_NN_090317_SSIM.mat
% FROBENIUS

% close all
% fig=0;
% 
% fig=1+fig;
% figure(fig)
% title('Distance map')
% grid
% hold on
% mesh(y(:,:,1),'FaceColor','none','LineStyle','none','Marker','*')
% mesh(y(:,:,2),'FaceColor','none','LineStyle','none','Marker','*')
% colorbar
% xlabel('N')
% ylabel('N')

load handel
sound(y,Fs)
