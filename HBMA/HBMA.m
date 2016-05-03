clc,clear all;close all
fid1=fopen('foreman100.Y');
B1 = fread(fid1, [352, 288], 'uint8=>double')';
 
fid2=fopen('foreman103.Y');
B2 = fread(fid2, [352, 288], 'uint8=>double')';
 
N=16;
R=8;
[height, width]=size(B1);
 
fi1=imresize(B1,0.5,'bilinear');
fi2=imresize(B2,0.5,'bilinear');
 
[row,col]=size(fi1);
 
f1=zeros(row+2*R,col+2*R);
f2=f1;
f1(R+1:R+row,R+1:R+col)=fi1;
f2(R+1:R+row,R+1:R+col)=fi2;
fp=zeros(size(f1));
    mvx=0;
        mvy=0;
for i=1+R:N:row+R-N
    for j=1+R:N:col+R-N
        MAD_min=256*N*N;
     
        for k=-R:R
            for l=-R:R
                MAD=sum(sum(abs(f1(i:i+N-1,j:j+N-1)-f2(i+k:i+k+N-1,j+l:j+l+N-1))));
                if MAD<MAD_min
                    MAD_min=MAD;
                    dy=k;
                    dx=l;
                end
            end
        end
        fp(i:i+N-1,j:j+N-1)=f2(i+dy:i+dy+N-1,j+dx:j+dx+N-1);
        iblk=floor((i-1-R)/N)+1;
        jblk=floor((j-1-R)/N)+1;
        mvx(iblk,jblk)=dx;
        mvy(iblk,jblk)=dy;
    end
end
 
fps=fp(9:152,9:184);
fi11=imresize(fps,2,'bilinear');
 
f11=zeros(height+2*R,width+2*R);
f22=f11;
f11(R+1:R+height,R+1:R+width)=fi11;
f22(R+1:R+height,R+1:R+width)=B2;
fpp=zeros(size(f11));
    mvx2=0;
        mvy2=0;
for i=1+R:N:height+R-N
    for j=1+R:N:width+R-N
        MAD_min2=256*N*N;
     
        for k=-R:R
            for l=-R:R
                MAD2=sum(sum(abs(f11(i:i+N-1,j:j+N-1)-f22(i+k:i+k+N-1,j+l:j+l+N-1))));
                if MAD<MAD_min2
                    MAD_min2=MAD;
                    dy2=k;
                    dx2=l;
                end
            end
        end
        fpp(i:i+N-1,j:j+N-1)=f22(i+dy2:i+dy2+N-1,j+dx2:j+dx2+N-1);
        iblk2=floor((i-1-R)/N)+1;
        jblk2=floor((j-1-R)/N)+1;
        mvx2(iblk2,jblk2)=dx2;
        mvy2(iblk2,jblk2)=dy2;
    end
end
 
MSE=mean2((f22-fpp).^2);
PSNR=10*log10(255^2/MSE)
 
figure,subplot(2,2,1),imshow(f11,[]),title('Anchor');
subplot(2,2,2),imshow(f22,[]),title('Target');
subplot(2,2,3),quiver(mvx2,mvy2),title('Motion Vector');
subplot(2,2,4),imshow(fpp,[]),title('Predicted image');
