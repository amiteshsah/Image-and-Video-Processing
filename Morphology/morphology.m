% Use the MATLAB program imdilate( ) and imerode( ) on a sample BW image. Try a
% simple 3x3 square structuring element. Comment on the effect of dilation and
% erosion. By concatenating the dilation and erosion operations, also generate result
% of closing and opening, and comment on their effects. Repeat above with a 7x7
% structure element. Comment on the effect of the window size. You can generate a
% binary image from a grayscale one by thresholding. 

clc;clear all; close all
I=imread('circuit.jpg');
I=rgb2gray(I);
Ib=im2bw(I,0.65);
figure,imshow(Ib,[]);title('Binary Image');

SE=strel('square',3);
IE=imerode(Ib,SE);
ID=imdilate(Ib,SE);


figure,
subplot(2,2,1),imshow(IE,[]);title('Erosion with Square 7*7 SE');
subplot(2,2,2),imshow(ID,[]);title('Dilation');

% Open,  Eliminate false touching, thin ridges and branches 
IEO=imerode(Ib,SE);
IDO=imdilate(IEO,SE);

% Close, Fill small gaps and holes 
IDC=imdilate(Ib,SE);
IEC=imerode(IDC,SE);

subplot(2,2,3),imshow(IDO,[]);title('OPENING ');
subplot(2,2,4),imshow(IEC,[]);title('CLOSING');
