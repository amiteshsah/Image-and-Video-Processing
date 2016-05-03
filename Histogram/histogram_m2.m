function h = histogram_m2(imagename)
% This function calculates the histogram of a gayscale image using the 2nd method
% Here, each pixel value is checked only once and an increment is done at
% the location where location value is the pixel value

img=imread(imagename);
figure, imshow(img);
tic
[N M]=size(img);
h=zeros(256,1);
    for i=1:N
        for j=1:M
            f= img(i,j);
                h(f+1)=h(f+1)+1;
        end
    end
figure,bar(h);
toc