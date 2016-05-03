%  Write a matlab program that can i) read your color image into a matrix (you can use
% imread() function in MATLAB); ii) covert it to a 8-bit grayscale image
% using the RGB to Y conversion formula in the RGB to YCbCr formula
% provided (You should not use the MATLAB built-in function rgb2ycbcr),
% iii) generate a digital negative version of your grayscale image, and iv)
% display both the color image, the original gray scale and the negative
% image.

clc;clear all;close all;


% Reading a image into a matrix from a file
IRGB_unsigned_raw=imread('amitesh.jpg');
IRGB_unsigned=imrotate(IRGB_unsigned_raw,90);

IRGB_signed=im2double(IRGB_unsigned);

% Conversion of RGB to 8-bit grayscale image
T=[0.257 0.504 0.098;-0.148 -0.291 0.439; 0.439 -0.368 -0.071]; % Conversion matrix from RGB to YCbCr

R=IRGB_signed(:,:,1);
G=IRGB_signed(:,:,2);
B=IRGB_signed(:,:,3);
[Row,Col]=size(R);
for i=1:Row
        for j=1:Col
            Y(i,j)= (0.257*R(i,j))+(0.504*G(i,j))+(0.098*B(i,j))+(16/255);
            Cb(i,j)=(-0.148*R(i,j))+(-0.291*G(i,j))+(0.439*B(i,j))+(128/255);
            Cr(i,j)=(0.439*R(i,j))+(-0.368*G(i,j))+(-0.071*B(i,j))+(128/255);
        end
end
    I_YCbCr= im2uint8(cat(3,Y,Cb,Cr));
    figure,subplot(1,2,1),imshow(IRGB_unsigned);
        title('RGB Color Space Original Image');
    subplot(1,2,2), imshow(I_YCbCr);%8 bit greyscale image Y
        title('YCbCr color space');
    figure,
    Y1=I_YCbCr(:,:,1);
    Cb1=I_YCbCr(:,:,2);
    Cr1=I_YCbCr(:,:,3);
    subplot(1,3,1);
    imshow(Y1);
    title('Luminance');
    subplot(1,3,2);
    imshow(Cb1);
    title('Chroma: Blue');
    subplot(1,3,3);
    imshow(Cr1);
    title('Chroma: Red');

% Generating a digital negative version of your greyscale image of
% Y(Luminance)

Neg_Y=255-Y1(:,:);
figure,subplot(1,2,1),imshow(Y1);
title('Positive Version of Luminance');
subplot(1,2,2),imshow(Neg_Y);
title('Negative Version of Luminance');


