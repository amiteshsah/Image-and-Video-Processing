clc;clear all; close all;
inImg = imread('barbara_gray.bmp');
grayImg=single(inImg);

my_filter=[1 2 1;1 2 1;1 2 1]/12;
[xh xw] = size(inImg); 
[hh hw]=size(my_filter);
hhh=(hh-1)/2;
hhw=(hw-1)/2;
z=zeros(xh,xw);

for m=hhh+1:xh-hhh
 for n = hhw+1:xw-hhw
%skip first and last hhw columns to avoid boundary problems
 tmpv = 0;
 for k = -hhh:hhh
 for l = -hhw:hhw
 tmpv = tmpv + grayImg(m-k,n-l)*my_filter(k+hhh+1,l+hhw+1);
 %h(0,0) is stored in h(hhh+1,hhw+1)
 end
 end
 z(m, n) = tmpv;
 end
end
f=z;
filteredImg=uint8(255*my_mat2gray(f)); 

cf=figure(1);
subplot(1,2,1); 
imshow(inImg);
title('Original Image');
subplot(1,2,2);
imshow(filteredImg);
title('Filtered Image with Filter 1');
