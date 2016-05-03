clc;
clear all;
close all;
I=imread('heart image.jpg');
Gray=rgb2gray(I);
Ga=adapthisteq(Gray);
G=histeq(Ga);
G1=histeq(Gray);
figure(1);
imshow(I);title('original image');
figure(2);
subplot(3,3,1),imshow(Gray);title('Gray image1');
subplot(3,3,2),imhist(Gray);title('Hist gray image1');
% subplot(3,3,3),imshow(Ga);title('Adaptive hist image12');
% subplot(3,3,4),imhist(Ga);title('Hist. Adaptive12');
% subplot(3,3,5),imshow(G);title('eqali of adaptive123'); 
% subplot(3,3,6),imhist(G);title('eq. ad. hist im123');
subplot(3,3,3),imshow(G1);title('hist eq14')
subplot(3,3,4),imhist(G1);title('im.histeq14');
%%
 m=fspecial('gaussian');
IF=imfilter(G1,m);
figure,imshow(G1),title('Using gaussian filter');
%%
C=imcrop(IF);
% C=imcrop(IF,[31.5 58.5 221 59]);
figure,imshow(C);title('cropped image');
[m n]=size(C);
a1=C(1:m/2,1:floor(n/4.5));
a2=C(1:m/2,ceil(n/4.5):floor(n/2.5));
a3=C(1:m/2,ceil(n/2.5):n);
a4=C((m/2)+1:m,1:floor(n/4.5));
a5=C((m/2)+1:m,ceil(n/4.5):floor(n/2.5));
a6=C((m/2)+1:m,ceil(n/2.5):n);
figure;
subplot(2,3,1),imshow(a1,[]);
subplot(2,3,2),imshow(a2,[]);
subplot(2,3,3),imshow(a3,[]);
subplot(2,3,4),imshow(a4,[]);
subplot(2,3,5),imshow(a5,[]);
subplot(2,3,6),imshow(a6,[]);
X=[a1 a2 a3;a4 a5 a6];
[m1 n1]=size(X);
figure,imshow(X);title('Added image');
%%
b1=im2bw(a1,0.1);
b2=im2bw(a2,graythresh(a2));
b3=im2bw(a3,graythresh(a3));
b4=im2bw(a4,graythresh(a4));
b5=im2bw(a5,0.06);
b6=im2bw(a6,0.08);
Y=[b1 b2 b3;b4 b5 b6];
figure,imshow(Y);title('after thresholding');
%
% g1=im2bw(C,0.2);
% 
%%
Y=~Y;
 Cb=bwareaopen(Y,100);
   D=bwmorph(Cb,'open');
figure,imshow(Cb);title('Before removing small area');
figure,imshow(D);title('After removing small area');
%%


CC=bwconncomp(D);
[B,L,N,A]=bwboundaries(D);
stats=regionprops(D,'Area','MinorAxisLength');

mask=zeros(size(L));
numPixels = cellfun(@numel,CC.PixelIdxList);
        [biggest,idx] = max(numPixels);
        mask(CC.PixelIdxList{idx})=1;
        mask=~mask;
        figure(8),imshow(mask);
        thick=stats(idx).MinorAxisLength;
        message=sprintf('The thickness of the nerve in pixel is %3.3g',thick);
        msgbox(message);