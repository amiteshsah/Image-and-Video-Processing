

% Reading an image
F=imread('fixed.jpg');
M=imread('moving.jpg');

F1=rgb2gray(F);
M1=rgb2gray(M);

% figure,
% subplot(1,2,1),imshow(F1),title('FIXED Image');
% subplot(1,2,2),imshow(M1),title('MOVING Image');

% Select the corresponding feature point in these two images.
% cpselect(M1,F1);

% Affine Transformation represents a relation between two images.
one=ones(1,8);
A(:,1)=one';
A(:,2)=fixedPoints(:,1);
A(:,3)=fixedPoints(:,1);

x=movingPoints(:,1);
y=movingPoints(:,2);

% Here , K>N i.e. 8>3
% So we use least square solution
% a=inv((A'*A))*A'*x

tform=cp2tform(movingPoints,fixedPoints,'affine');
J=imtransform(F1,tform);

figure,
subplot(2,2,1),imshow(F1),title('FIXED Image');
subplot(2,2,2),imshow(M1),title('Moving Image');
subplot(2,2,3),imshow(J),title('Warping Image');
