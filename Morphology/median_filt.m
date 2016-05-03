% Write a program which can i) add salt-and-pepper noise to an image with a specified noise
% density, ii) perform median filtering with a specified window size. Consider only median filter
% with a square shape. Try two different noise density (0.05, 0.2) and for each density, comment
% on the effect of median filtering with different window sizes and experimentally determine the
% best window size. You can use imnoise( ) to generate noise. You should write your own
% function for 2D median filtering, but you can calling the MATLAB median( ) function. You can
% ignore the boundary problem by only performing the filtering for the pixels inside the valid
% region. Hint: you need to convert the 2D array within each window to a 1D vector before
% applying median( ) function. You can verify your program with the MATLAB medfilt2( ) function. 
clc;clear all; close all
I=imread('lenna.png');
I=rgb2gray(I);
Id=im2double(I);

% Add a salt and peeper noise
J1 = imnoise(Id,'salt & pepper',0.05);
J2 = imnoise(Id,'salt & pepper',0.2);



figure(1),subplot(2,2,1),imshow(J1,[]);title('noisy with d:0.05');
j=2;
for i=3:2:7
   f1=my_med_filt(J1); 
   subplot(2,2,j),imshow(f1,[]);title(['filt with W :',num2str(i)]);
   j=j+1;
end

j=2;
figure(2),subplot(2,2,1),imshow(J2,[]);title('noisy with d:0.2');
for i=3:2:7
   f2=my_med_filt(J2); 
   subplot(2,2,j),imshow(f2,[]);title(['filt with W :',num2str(i)]);
   j=j+1;
end

