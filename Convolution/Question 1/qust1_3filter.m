% % Write a Matlab program for implementing filtering of a gray scale image. Your 
% program should allow you to specify the filter with an arbitrary size (but for
% simplicity, you can assume the filter size is KxL where both K and L are odd
% numbers, and the filter origin is at the center. Your program should read in a gray
% scale image, perform the filtering, display the original and filtered image, and
% save the filtered image into another file. You should write a separate function for
% the convolution that can be called by your main program. For simplicity, you can
% use the simplified boundary treatment. You should properly normalize the filtered
% image so that the resulting image values can be saved as 8-bit unsigned
% characters. Apply the filters given in the previous problem to a test image.
% Observe on the effect of these filters on your image. Note: you cannot use the
% MATLAB conv2( ) function. In your report, include your MATLAB code, the
% original test image and the images obtained

%%
clc;clear all; close all;
% i) Your program should read in a gray scale image
inImg = imread('barbara_gray.bmp');

%convert the inImg to int or single or double before proceeding!
grayImg=single(inImg);


H1=[1 2 1;2 4 2;1 2 1]/16;
H2=[-1 -1 -1;-1 8 -1;-1 -1 -1];
H3=[0 -1 0;-1 5 -1;0 -1 0];


%perform convolution
tmpImg1 = my_conv2(grayImg, H1); 
tmpImg2 = my_conv2(grayImg, H2); 
tmpImg3 = my_conv2(grayImg, H3); 

%% scale tmpImg so that it ranges in 0 to 255 and is stored in uint8
filteredImg1=uint8(255*my_mat2gray(tmpImg1)); 
filteredImg2=uint8(255*my_mat2gray(tmpImg2));
filteredImg3=uint8(255*my_mat2gray(tmpImg3));
%% iv) display the original and the filtered images. you can use imshow for displaying an image.
%% make sure to conver all images into uint8 before dispalying them
cf=figure(1);
subplot(2,2,1); 
imshow(inImg);
title('Original Image');
subplot(2,2,2);
imshow(filteredImg1);
title('Filtered Image with Filter H1');
subplot(2,2,3);
imshow(filteredImg2);
title('Filtered Image with Filter H2');
subplot(2,2,4);
imshow(filteredImg3);
title('Filtered Image with Filter H3');


% v) save the filtered images into another file.
print(cf, 'Q1_3filter', '-dtiff');