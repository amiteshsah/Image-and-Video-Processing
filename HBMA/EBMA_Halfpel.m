% 6.13 Repeat the above exercise for EBMA with half-pel accuracy. Compare the
% PSNR of the predicted image obtained using integer-pel and that using halfpel
% accuracy estimation. Which method gives you more accurate prediction?\

close all,clear all,clc
f1 = 'foreman103.Y'; % anchor frame 
f2 = 'foreman100.Y'; % target frame 
R = 32; % search range
W = 352; % frame width
H = 288; % frame height
N = 16; % block size
fp = zeros(H, W); % predicted frame
mvx = zeros(H/N, W/N);
mvy = zeros(H/N, W/N);
[X, Y] = meshgrid(N/2:N:W, N/2:N:H);
% read frames
fid1 = fopen(f1, 'r');
fid2 = fopen(f2, 'r');
f1 = fread(fid1, [W, H], 'uint8=>double')';
f2 = fread(fid2, [W, H], 'uint8=>double')'; fclose(fid1);
fclose(fid2);
fd = f2-f1; % the direct difference between f1 and f2
figure,
subplot(1,2,1),imshow(f1,[]),title('Anchor Image');
subplot(1,2,2),imshow(f2,[]),title('Target Image');
% EBMA with half-pel accuracy
%mvx,mvy: store the MV image
%first upsample f2 by a factor of 2 in each direction
f3=imresize(f2, 2,'bilinear'); 
mvx=0;mvy=0;
for i = 1:N:H
for j = 1:N:W
MAD_min = 255*N*N; 
    for k = -R:0.5:R
        if i+k < 1 || i+k+N-1 > H % check vertical boundary 
            continue;
        end
    for l = -R:0.5:R
         if j+l < 1 || j+l+N-1 > W % check horizontal boundary 
            continue;
         end
MAD=sum(sum(abs(f1(i:i+N-1,j:j+N-1)-f3(2*(i+k):2:2*(i+k+N-1),2*(j+l):2:2*(j+l+N-1)))));
        if MAD < MAD_min 
            MAD_min = MAD;
            dy = k;
            dx = l;
        end
    end
    end
fp(i:i+N-1, j:j+N-1) = f3(2*(i+dy):2:2*(i+dy+N-1),2*(j+dx):2:2*(j+dx+N-1));
iblk = (i-1)/N+1;
jblk = (j-1)/N+1;
mvx(iblk, jblk) = dx;
mvy(iblk, jblk) = dy;
end
end
ferr = fp-f1; % the motion compensation error image 

figure,imshow(f1,[]),title('Anchor Image with MV');
    hold on
 quiver(X,Y,mvx,mvy);
    hold off

figure,imshow(fp,[]),title('Predeicted frame');

fd = f2-f1; % the direct difference between f1 and f2
% calculate the error frame bysubtracting the predicted frame from the
% anchor frame
errorframe=imabsdiff(f1,fp);
figure,imshow(errorframe),title('Error frame');

ferr = fp-f1; % the motion compensation error image
% compute the variances
var_f1 = mean(mean((f1-mean(mean(f1))).^2)) 
var_fd = mean(mean((fd-mean(mean(fd))).^2)) 
var_fe = mean(mean((ferr-mean(mean(ferr))).^2))

% Calculate PSNR
PSNR_full=10*log10(255*255/mean(mean(errorframe.^2)))