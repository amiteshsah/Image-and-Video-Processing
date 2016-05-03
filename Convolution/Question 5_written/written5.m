clc;
clear all;
close all;

H1=[1 2 1;2 4 2;1 2 1]/16;
H2=[-1 -1 -1;-1 8 -1;-1 -1 -1];
H3=[0 -1 0;-1 5 -1;0 -1 0];

[H,FX,FY]=freqz2(H1);
du=[-0.5:0.01:0.5];
dv=1;

Fu1=abs(cos(2*pi*du));
Fv1=(cos(2*pi*dv));
F1=(Fu1+1)'*(Fv1+1)/4;
plot(du,F1)
% mesh(du,dv,F1);
% colorbar;
% imagesc(F1);
% colormap(gray);truesize;
% 
% du=[-0.5:0.01:0.5];
% dv=[-0.5:0.01:0.5];
% Fu1=abs(cos(2*pi*du));
% Fv1=(cos(2*pi*dv));
% F1=Fu1'*(Fv1+1)/4;
% mesh(du,dv,F1);
% colorbar;
% imagesc(F1);
% colormap(gray);truesize;