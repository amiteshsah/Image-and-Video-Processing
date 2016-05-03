% Repeat above on a gray scale image, using MATLAB gray scale dilation and
% erosion functions
clc;clear all; close all
I=imread('circuit.jpg');
I=rgb2gray(I);

figure,imshow(I,[]);title('Gray Image');

SE=strel('square',7);
IE=imerode(I,SE);
ID=imdilate(I,SE);

figure,
subplot(2,2,1),imshow(IE,[]);title('Erosion with Square 7*7 SE');
subplot(2,2,2),imshow(ID,[]);title('Dilation');

% Open
IEO=imerode(I,SE);
IDO=imdilate(IEO,SE);

% Close
IDC=imdilate(I,SE);
IEC=imerode(IDC,SE);

subplot(2,2,3),imshow(IDO,[]);title('OPENING ');
subplot(2,2,4),imshow(IEC,[]);title('CLOSING');

