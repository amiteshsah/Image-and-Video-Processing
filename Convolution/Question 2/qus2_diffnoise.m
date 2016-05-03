% % Write a Matlab to simulate noise removal. First create a noisy image, by adding
% zero mean Gaussian random noise to your image using ?imnoise()?. You can
% specify the noise variance in ?imnoise( )?). Then apply an averaging filter to the
% noise added image. For a chosen variance of the added noise, you need to try
% different window sizes (from 3x3 to 9x9) to see which one gives you the best
% trade-off between noise removal and blurring. Hand in your program, the original
% noise-added images at two different noise levels (0.01 and 0.1) and the
% corresponding filtered images with the best window sizes. Write down your
% observation. For the filtering operation, if your program in Prob. 1 does not work
% well, you could use the matlab ?conv2()? function. Your program should allow
% the user to specify the window size as an input parameter. 
clc;clear all;close all;
inImg = imread('barbara_gray.bmp');

%convert the inImg to int or single or double before proceeding!
grayImg=double(inImg);

noiseLevel1=0.01;
noisy_img1 = imnoise(inImg, 'gaussian', 0, noiseLevel1);
noiseLevel2=0.1;
noisy_img2 = imnoise(inImg, 'gaussian', 0, noiseLevel2);
%imnoise does not work when inImg is not uint8!
noisy_img1=single(noisy_img1);
noisy_img2=single(noisy_img2);

%%
%set filter
filterSize=input('Enter the filter size');

% filterSize=3;
denoising_filter=ones(filterSize,filterSize)/(filterSize*filterSize);

tmpImg1 = my_conv2(noisy_img1, denoising_filter);
tmpImg2 = my_conv2(noisy_img2, denoising_filter);
% III) Normalize and convert the image to uint8
denoisedImg1 = 255*my_mat2gray(tmpImg1); 
denoisedImg2 = 255*my_mat2gray(tmpImg2); 
%% iv) display the original and the filtered images. 

cf=figure(1);
subplot(2,3,1); 
imshow(inImg);
title('Original Image');
subplot(2,3,2);
imshow(noisy_img1,[]); 
title(['Noisy Image with ' num2str(noiseLevel1)]);
%note you need to use [] option to see the full range of noisy image
subplot(2,3,3);
imshow(denoisedImg1,[]);
title(['Denoised Image with ' num2str(noiseLevel1) 'FilterSize=' num2str(filterSize)]);
subplot(2,3,4); 
imshow(inImg);
title('Original Image');
subplot(2,3,5);
imshow(noisy_img2,[]); 
title(['Noisy Image with ' num2str(noiseLevel2)]);
%note you need to use [] option to see the full range of noisy image
subplot(2,3,6);
imshow(denoisedImg2,[]);
title(['Denoised Image with ' num2str(noiseLevel2) 'FilterSize=' num2str(filterSize)]);

% v) save the filtered images into another file.


print(cf, 'HW2_Q2_diffnoise', '-dtiff');
