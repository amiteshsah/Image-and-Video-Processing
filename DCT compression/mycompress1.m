function [ Y ] = mycompress1( I,Qmatrix,QP )
QM=Qmatrix*QP;
fun=@dct2;
A=blkproc(I,[8 8],fun);
fun=@(x)(floor((x+QM/2)./(QM)));
B1=blkproc(A,[8 8],fun);
B2=blkproc(B1,[8 8],'x.*P1',QM);
fun=@(x)(round(idct2(x)));
B3=blkproc(B2,[8 8],fun);
Y=B3;
end

