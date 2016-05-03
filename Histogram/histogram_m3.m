function h = histogram_m3(imagename)
% This function calculates the histogram of a gayscale image using the 3rd method
% Here, particular gray value is checked in whole image and then added all
% at once, 1st row is checked and summed, then all row is checked and then
% summation.
img=imread(imagename);
figure, imshow(img);
tic
[N M]=size(img);
h=zeros(256,1);
   for I=0:255
         h(I+1)=sum(sum(img==I));
   end
figure,bar(h);
toc