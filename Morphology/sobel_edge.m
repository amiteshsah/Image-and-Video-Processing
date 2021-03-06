% % Write a Matlab or C-program for implementing the following simple edge detection algorithm:
% For every pixel: i) find the horizontal and vertical gradients, gx and gy, using the Sobel operator;
% ii) calculate the magnitude of the gradient ; and iii) For a chosen threshold T, consider the pixel
% to be an edge pixel if gm ? T. Save the resulting edge map (Use a gray level of 255 to indicate
% an edge pixel, and a gray level of 0 for a non-edge pixel). Apply this program to your test image,
% and observe the resulting edge map with different T values, until you find a T that gives you a
% good result. Hand in your program and the edge maps generated by two different threshold
% values. Write down your observation. Hint: one automatic way to determine T is by sorting the
% pixels based on the gradient magnitudes, and choose T such that a certain percentage (say
% 5%) of pixels will be edge pixels. You can use either the matlab conv2( ) function or your own
% code for the filtering part.

close all;clc;clear all;

I=imread('cameraman.jpg');
I=rgb2gray(I);
I=im2double(I);
figure,
% subplot(2,2,1),imshow(I,[]);title('image');

% Sobel Operator
Hx=[-1 -2 -1;0 0 0;1 2 1]./4;
Hy=[-1 0 1;-2 0 2;-1 0 1]./4;

% Computing Horizontal and vertical gradient
gx=conv2(I,Hx,'same');
gy=conv2(I,Hy,'same');
subplot(2,2,1),imshow(gx,[]);title('gx');
subplot(2,2,2),imshow(gy,[]);title('gy');

%Magnitude 
gm=sqrt((gx.^2)+(gy.^2));
subplot(2,2,3),imshow(gm,[]);title('gm');
subplot(2,2,4),imhist(gm);title('gm hist');

% Sorting and top 5% 
[r,c]=size(gm);
len=r*c;
b=reshape(gm',1,len);
s=sort(b,'descend');

i=1;
thresh_avg=0;
while i<0.05*len
    thresh_avg=thresh_avg+s(i);
    i=i+1;
end
thresh_avg=thresh_avg/i;

% Thresholding by taking top 5%
for i=1:r
    for j=1:c
        if gm(i,j)<=thresh_avg
            G(i,j)=0;
        else
            G(i,j)=1;
        end
    end
end
% for a chosen Threshold

Bw1=im2bw(gm,0.2);
Bw2=im2bw(gm,0.4);
Bw3=im2bw(gm,0.1);
figure,
subplot(2,2,1),imshow(Bw3,[]);title('T=0.1');
subplot(2,2,2),imshow(Bw1,[]);title('T=0.2');
subplot(2,2,3),imshow(G,[]);title('gm thresh avg');
subplot(2,2,4),imshow(Bw2,[]);title('T=0.4');
