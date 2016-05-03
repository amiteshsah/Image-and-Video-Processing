% Implementing the fastest histogram calculation technique

clc;clear all; close all;
img=imread('baboon.png');
if ndims(img)>2         % To check if it is rgb or gray image
    img=rgb2gray(img);
end

[N M]=size(img);
h=zeros(256,1);
   for I=0:255
         h(I+1)=sum(sum(img==I));
   end
   figure,subplot(1,2,1), imshow(img);
   title('Original Gray level Image');
   subplot(1,2,2),stem(h);
   title('Histogram of the original Image');

