%  Write a Matlab program that performs histogram equalization on a
% grayscale image. Your program should: i) compute the histogram of the input
% image by calling your own histogram function from previous problem; ii)
% compute the histogram equalizing transformation function; iii) apply the
% function to the input image; iv) compute the histogram of the equalized image;
% v) display (and print) the original and equalized images, as well as their
% corresponding histograms, all in one figure. You are not allowed to simply use
% the ?histeq? function in Matlab, although you are encouraged to compare your
% results with those obtained using these functions. 

clc;clear all; close all;

img=imread('7.png');
if ndims(img)>2         % To check if it is rgb or gray image
    img=rgb2gray(img);
end
f=histogram_m3(img);
 [r,c]=size(img);
 count=r*c;
p_f=f./count;
% Making a cumulative function
gl_bar=p_f(1,1);
for i=2:256
    gl_bar(i,1)=gl_bar(i-1,1)+p_f(i,1);
end
gl=round(gl_bar.*255);
% figure,plot(gl);

y=0:255;
p_g=zeros(256,1);
histeq_img=zeros(r,c);
% Now take the individual pixel from the image and store the mapped value
for i=1:r
    for j=1:c
        gray_level=img(i,j)+1; %Gray level of the existing pixel of the original image
        histeq_img(i,j)=gl(gray_level);
    end
end
% figure, imshow(uint8(histeq_img));
k=histogram_m3(histeq_img);

figure,
subplot(2,2,1),imshow(img);title('Original Image');
subplot(2,2,2),bar(f); title('Histogram of Original Image');
subplot(2,2,3),imshow(uint8(histeq_img));title('Contrast Enchanced Image using using transformation function');
subplot(2,2,4),bar(k); title('Histogram of Enhanced Image');
Ieq=histeq(img);
figure,
subplot(2,2,1),imshow(img);title('Original Image');
subplot(2,2,2),imhist(img); title('Histogram of Original Image');
subplot(2,2,3),imshow(uint8(Ieq));title('Contrast Enchanced Image using histeq function');
subplot(2,2,4),imhist(Ieq); title('Histogram of Enhanced Image');
% k=find(f);
% l=length(k);
% x1=k(1,1)-1;
% x2=k(l,1)-1;


% g=histeq(img);
%    figure,subplot(2,2,1), imshow(img);
%    title('Original Gray level Image');
%    subplot(2,2,2),stem(f);
%    title('Histogram of the original Image');
%    subplot(2,2,3), imshow(g);
%    title('Original Gray level Image');
%    subplot(2,2,4),imhist(g);
%    title('Histogram of the original Image');
