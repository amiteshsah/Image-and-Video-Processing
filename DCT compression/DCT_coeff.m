close all
clear all
clc
 
I=imread('lena_gray.bmp');

%%
Qmatrix=[16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99];
 
A=mycompress1(I,Qmatrix,0.5);
B=mycompress1(I,Qmatrix,1);
C=mycompress1(I,Qmatrix,2);
D=mycompress1(I,Qmatrix,4);
E=mycompress1(I,Qmatrix,8);
F=mycompress1(I,Qmatrix,16);
 
figure
imshow(I,[])
title('original')
figure
subplot(1,2,1)
imshow(A,[])
title('QP=0.5')
subplot(1,2,2)
imshow(B,[])
title('QP=1')
figure
subplot(1,2,1)
imshow(C,[])
title('QP=2')
subplot(1,2,2)
imshow(D,[])
title('QP=4')
figure
subplot(1,2,1)
imshow(E,[])
title('QP=8')
subplot(1,2,2)
imshow(F,[])
title('QP=16')


fun = @(block_struct) dct2(block_struct.data);
dctImg = blockproc(modeErr, [8 8], fun);
PSNRa = zeros(1,100);
ka = zeros(1,100);
for q = 1:100
    dctImgq = round(dctImg/q)*q + q/2;
    ka(q) = sum(dctImgq(:) ~= q/2);
    fun = @(block_struct) idct2(block_struct.data);
modeErrq = blockproc(dctImgq, [8 8], fun);
img2q = modePre + modeErrq;
PSNRa(q) = 10*log10((255*255)/mean((img2(:) - img2q(:)).^2));
end
figure(3);
plot(ka, PSNRa);
xlabel('K');
ylabel('PSNR');