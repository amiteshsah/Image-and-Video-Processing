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

% Enter the dimension of filter
k=input('Enter K for KxL filter size(ODD LENGTH)');
l=input('Enter L for KxL filter size(ODD LENGTH)');
my_filter=zeros(k,l);

% Enter the filter value
for i=1:k
    my_filter(i,:)=input('Enter Row in [-1 2 3] form for KxL filter');
end

%perform convolution
tmpImg = my_conv2(grayImg, my_filter); 

%% scale tmpImg so that it ranges in 0 to 255 and is stored in uint8
filteredImg=uint8(255*my_mat2gray(tmpImg)); 

%% iv) display the original and the filtered images. you can use imshow for displaying an image.
%% make sure to conver all images into uint8 before dispalying them
cf=figure(1);
subplot(1,2,1); 
imshow(inImg);
title('Original Image');
subplot(1,2,2);
imshow(filteredImg);
title('Filtered Image with Filter 1');

% v) save the filtered images into another file.
print(cf, 'HW2_Q1', '-dtiff');