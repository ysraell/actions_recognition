clear all
close all
clc

load check_distances_1st_NN_090317_SSIM.mat

% x = -1./(1-y);
x = -y;
x2 = -1./z;
x3 = -1./w;


close all
fig=0;

fig=1+fig;
figure(fig)
title('Distance map (SSIM)')
grid
hold on
mesh(y(:,:,1),'FaceColor','none','LineStyle','none','Marker','*')
mesh(y(:,:,2),'FaceColor','none','LineStyle','none','Marker','*')
colorbar
xlabel('N')
ylabel('N')

fig=1+fig;
figure(fig)
title('Distance map (-1/(1-SSIM))')
grid
hold on
mesh(x(:,:,1),'FaceColor','none','LineStyle','none','Marker','*')
mesh(x(:,:,2),'FaceColor','none','LineStyle','none','Marker','*')
colorbar
xlabel('N')
ylabel('N')

fig=1+fig;
figure(fig)
title('Distance map (FROB)')
grid
hold on
mesh(z(:,:,1),'FaceColor','none','LineStyle','none','Marker','*')
mesh(z(:,:,2),'FaceColor','none','LineStyle','none','Marker','*')
colorbar
xlabel('N')
ylabel('N')

fig=1+fig;
figure(fig)
title('Distance map (-1/(FROB))')
grid
hold on
mesh(x2(:,:,1),'FaceColor','none','LineStyle','none','Marker','*')
mesh(x2(:,:,2),'FaceColor','none','LineStyle','none','Marker','*')
colorbar
xlabel('N')
ylabel('N')

fig=1+fig;
figure(fig)
title('Distance map (FROB)')
grid
hold on
mesh(w(:,:,1),'FaceColor','none','LineStyle','none','Marker','*')
mesh(w(:,:,2),'FaceColor','none','LineStyle','none','Marker','*')
colorbar
xlabel('N')
ylabel('N')

fig=1+fig;
figure(fig)
title('Distance map (-1/(FROB))')
grid
hold on
mesh(x3(:,:,1),'FaceColor','none','LineStyle','none','Marker','*')
mesh(x3(:,:,2),'FaceColor','none','LineStyle','none','Marker','*')
colorbar
xlabel('N')
ylabel('N')