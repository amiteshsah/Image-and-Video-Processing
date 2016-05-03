%%Q1. 

 

clc;

clear all;

close all;

 

%Read colour image, convert to grayscale

A =imread('barbara_gray.bmp');
[M,N] = size(A); 

 

%%Downsampling

%Main image and downsampled image using 'imresize'

C = imresize(A,0.5);

figure(1);

subplot(2,1,1);

imshow(A);

title('Main image');

subplot(2,1,2);

imshow(C);

title('Downsampled image with resize');

 

%Downsampling without prefiltering

G = A(1:2:M,1:2:N);

figure(2);

subplot(2,1,1);

imshow(G);

title('Downsample without prefiltering')

 

%Downsampling with prefiltering

H = fspecial('average',2);

average = imfilter(A,H,'replicate');

subplot(2,1,2);

imshow(average);

title('Downsample with prefiltering');

 

 

 

%%Upsampling

E = 2;

F = 2;

matrix = zeros(E*M,F*N);

 

%Bilinear without prefiltering

for i = 1:(N-1);

    for j = 1:(M-1);

    matrix(2*i,2*j) = A(i,j);

    matrix(2*i,2*j+1) = 1/2*(A(i,j) + A(i,j+1));

    matrix(2*i+1,2*j) = 1/2*(A(i+1,j) + A(i,j));

    matrix(2*i+1,2*j+1) = 1/4*(A(i,j)+A(i+1,j)+A(i,j+1)+A(i+1,j+1));

    end

end

figure(3);

subplot(2,2,1);

imshow(matrix);

title('Upsampling without prefiltering(bilinear)');

 

%Bilinear with prefiltering

for i = 1:(N-1);

    for j = 1:(M-1);

    matpre(2*i,2*j) = average(i,j);

    matpre(2*i,2*j+1) = 1/2*(average(i,j) + average(i,j+1));

    matpre(2*i+1,2*j) = 1/2*(average(i+1,j) + average(i,j));

    matpre(2*i+1,2*j+1) = 1/4*(average(i,j)+average(i+1,j)+average(i,j+1)+average(i+1,j+1));

    end

end

subplot(2,2,2);

imshow(matpre);

title('Upsampling with prefiltering(bilinear)');

 

%Bicubic without prefiltering

for i = 2:N-2;

    for j = 2:M-2;

    matbicu(2*i,2*j) = A(i,j);

    matbicu(2*i,2*j+1) = 1/8*(-A(i,j-1)+5*A(i,j)+5*A(i,j+1)-A(i,j+2));

    matbicu(2*i+1,2*j) = 1/8*(-A(i-1,j)+5*A(i,j)+5*A(i+1,j)-A(i+2,j));

    end

end

subplot(2,2,3);

imshow(matbicu);

title('Upsampling without prefiltering(bicubic)');

 

 

%Bicubic with prefiltering

for i = 2:N-2;

    for j = 2:M-2;

    matbicuf(2*i,2*j) = average(i,j);

    matbicuf(2*i,2*j+1) = 1/8*(-average(i,j-1)+5*average(i,j)+5*average(i,j+1)-average(i,j+2));

    matbicuf(2*i+1,2*j) = 1/8*(-average(i-1,j)+5*average(i,j)+5*average(i+1,j)-average(i+2,j));

    end

end

subplot(2,2,4);

imshow(matbicuf);

title('Upsampling with prefiltering(bicubic)');