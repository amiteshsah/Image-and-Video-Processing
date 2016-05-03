clc;
clear all;close all;
I=imread('lena_gray.bmp');
inimg=I;
wname='haar';
QS=[1,4,16,32];
NZ=zeros(2,4);
PSNR1=zeros(2,4);
for i=1:4
[NonZeroNum,PSNR,outimg,f1,f2]=WaveletQuant(inimg,wname,QS(1,i));
NZ(1,i)=NonZeroNum;
PSNR1(1,i)=PSNR;
% figure,imshow(outimg),title(['Image',num2str(i)]);
end
figure,
plot(PSNR1(1,:),NZ(1,:));
xlabel('PSNR');
ylabel('NonZeroNum');
figure,subplot(2,2,1),imshow(inimg),title('Input image');
subplot(2,2,2),imshow(outimg),title('Output image after quant');
subplot(2,2,3),imshow(f1,[]),title('Coefficient');
subplot(2,2,4),imshow(f2,[]),title('quantized coeff');
%%
for i=1:4
[NonZeroNum,PSNR,outimg]=WaveletQuant(inimg,'db4',QS(1,i));
NZ(2,i)=NonZeroNum;
PSNR1(2,i)=PSNR;
end





