 function [NonZeroNum,PSNR,outimg,f2,ff2]=WaveletQuant(inimg,wname,QS)

[ca,ch,cv,cd]=dwt2(inimg,wname,'mode','sym');
[caa,cah,cav,cad]=dwt2(ca,wname,'mode','sym');

f1=[caa,cav;cah,cad];
f2=[f1,cv;ch,cd];

fun=@(x)(floor((x+QS/2)./(QS).*QS));
cah1=blkproc(cah,[128 128],fun);
cah1=blkproc(cah,[128 128],fun);
cav1=blkproc(cav,[128 128],fun);
cad1=blkproc(cad,[128 128],fun);
ch1=blkproc(ch,[256 256],fun);
cv1=blkproc(cv,[256 256],fun);
cd1=blkproc(cd,[256 256],fun);
mean=128;
fun1=@(x)(floor((x-mean+QS/2)./(QS)).*QS+mean);
caa1=blkproc(caa,[128 128],fun1);
ff1=[caa1,cav1;cah1,cad1];
ff2=[ff1,cv1;ch1,cd1];
NonZeroNum=nnz(ff1)+nnz(cv1)+nnz(ch1)+nnz(cd1);

ca1=idwt2(caa1,cah1,cav1,cad1,wname);
outimg=idwt2(ca1,ch1,cv1,cd1,wname);
outimg=uint8(outimg);

MSE = mean2((outimg- inimg).^2);
PSNR = 10*log10(255^2/MSE);

end


