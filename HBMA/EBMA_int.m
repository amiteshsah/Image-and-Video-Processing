% 6.12 Write a C or Matlab code for implementing EBMA with integer-pel accuracy.
% Use a block size of 16  16. The program should allow the user to choose
% the search range, so that you can compare the results obtained with different
% search ranges. Note that the proper search range depends on the extent of
% the motion in your test images. Apply the program to two adjacent frames
% of a video sequence. Your program should produce and plot the estimated motion 
% field, the predicted frame, the prediction error image. It should also
% calculate the PSNR of the predicted frame compared to the original tracked
% frame. With Matlab, you can plot the motion field using the function quiver. 

clc;clear all;close all;

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
X=X(1:end-1,1:end-1);
Y=Y(1:end-1,1:end-1);
% read frames
fid1 = fopen(f1, 'r');
fid2 = fopen(f2, 'r');
f1 = fread(fid1, [W, H], 'uint8=>double')'; 
f2 = fread(fid2, [W, H], 'uint8=>double')';
fclose(fid1);
fclose(fid2);
figure,
subplot(1,2,1),imshow(f1,[]),title('Anchor Image');
subplot(1,2,2),imshow(f2,[]),title('Target Image');

%f1: anchor frame; f2: target frame, fp: predicted image;
%mvx,mvy: store the MV image
%widthxheight: image size; N: block size, R: search range
mvx=0;mvy=0;
for i=1:N:H-N,
 for j=1:N:W-N %for every block in the anchor frame
 MAD_min=256*N*N;
 
 
 for k=-R:1:R
    if i+k < 1 || i+k+N-1 > H % check vertical boundary 
        continue;
    end

for l=-R:1:R
    if j+l < 1 || j+l+N-1 > W % check horizontal boundary 
        continue;
    end
    
MAD=sum(sum(abs(f1(i:i+N-1,j:j+N-1)-f2(i+k:i+k+N-1,j+l:j+l+N-1))));
% calculate MAD for this candidate
    if MAD<MAD_min
        MAD_min=MAD;
        dy=k;
        dx=l;
    end;
 end;
 end;

 %put the best matching block in the predicted image
 fp(i:i+N-1,j:j+N-1)= f2(i+dy:i+dy+N-1,j+dx:j+dx+N-1);

 iblk=floor((i-1)/N+1); 
 jblk=floor((j-1)/N+1); %block index
 mvx(iblk,jblk)=dx;
 mvy(iblk,jblk)=dy; %record the estimated MV
%  arrow([i j],[i+dy j+dx], 3);
end;
end;

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