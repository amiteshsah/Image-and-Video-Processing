%% Homework 2



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem 2
% Write a Matlab to simulate noise removal.

%%
% i) First create a noisy image, by adding zero mean Gaussian random noise
% at two different noise levels (0.01 and 0.1) to your image using
% "imnoise()". You can specify the noise variance in "imnoise( )").

inImg = imread('barbara_gray.bmp');

%convert the inImg to int or single or double before proceeding!
grayImg=double(inImg);

noiseLevel=0.01;
noisy_img = imnoise(inImg, 'gaussian', 0, noiseLevel);
%imnoise does not work when inImg is not uint8!
noisy_img=single(noisy_img);

%%
% ii) Then apply an averaging filter to the noise added image. For a chosen
% variance of the added noise, you need to try different window sizes (from
% 3x3 to 9x9) to see which one gives you the best trade-off between noise
% removal and blurring. Your program should allow the user to specify the
% window size as an input parameter.

%set filter

filterSize=3;
denoising_filter=ones(filterSize,filterSize)/(filterSize*filterSize);

tmpImg = my_conv2_sol(noisy_img, denoising_filter);  %%% here you need to write your own function as my_conv2

%%
% III) Normalize and convert the image to uint8

denoisedImg = 255*my_mat2gray(tmpImg); 


%% iv) display the original and the filtered images. 

cf=figure(2);
subplot(1,3,1); 
imshow(inImg);
title('Original Image');
subplot(1,3,2);
imshow(noisy_img,[]); 

title(['Noisy Image with NoiseLevel=' num2str(noiseLevel)]);
%note you need to use [] option to see the full range of noisy image
subplot(1,3,3);
imshow(denoisedImg,[]);

title(['Denoised Image with NoiseLevel=' num2str(noiseLevel) 'FilterSize=' num2str(filterSize)]);


% v) save the filtered images into another file.


print(cf, 'HW2_Q2', '-dtiff');

%%
% Hand in your program, the original noise-added images at two different
% noise levels (0.01 and 0.1) and the corresponding filtered images with
% the best window sizes. Write down your observation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



