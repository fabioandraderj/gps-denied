clear all
close all
clc

load('elevation_dtm.mat')
img = A;

x = 600;
X = 1600;
szx = x:X;

y = 800;
Y = 1800;
szy = y:Y;

figure
imagesc(img)
axis image off
caxis([min(min(img)) max(max(img))])
colormap gray
title('Digital Terrain Model')
hold on
plot([y y Y Y y],[x X X x x],'r')
hold off

Sect = img(szx,szy);
Sect = Sect + sqrt(20)*randn(size(Sect)) + 20;

figure
imagesc(Sect)
caxis([min(min(img)) max(max(img))])
axis image off
colormap gray
title('LIDAR')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nimg = img - mean(mean(img));
nSect = nimg(szx,szy);

crr = xcorr2(nimg,nSect);

[ssr,snd] = max(crr(:));
[ij,ji] = ind2sub(size(crr),snd);

figure
plot(crr(:),'o')
title('Cross-Correlation')
hold on
plot(snd,ssr,'or')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
imagesc(img)
axis image off
colormap gray
title('Position')
hold on
plot([y y Y Y y],[x X X x x],'r')
plot([(ji-size(Sect,1)) (ji-size(Sect,1)) ji ji (ji-size(Sect,1))],[(ij-size(Sect,1)) ij ij (ij-size(Sect,1)) ij-size(Sect,1)],'b')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
