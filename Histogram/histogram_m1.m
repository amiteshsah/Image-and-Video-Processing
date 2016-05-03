% Write a Matlab function that can compute the histogram of a grayscale image
% (assuming 256 levels of gray). Try the three possible ways described in slide 7, and
% see which one is faster. Finalize your program with the fastest method. In a
% separate main program, apply the program to a test image, and display the
% histogram as a stem plot besides the image (using ?subplot? function). You are not
% allowed to simply use the ?imhist? or ?hist? function in Matlab, although you are
% encouraged to compare your results with those obtained using these functions. 

function h = histogram_m1(imagename)
% This function calculates the histogram of a gayscale image using the 1st
% method. Here, each pixel value is checked 256 times

img=imread(imagename);
figure, imshow(img);
tic
[N M]=size(img);
h=zeros(256,1);
for I=0:255
    for i=1:N
        for j=1:M
            if img(i,j)==I
                h(I+1)=h(I+1)+1;
            end
        end
    end
end
figure,bar(h);
toc
      