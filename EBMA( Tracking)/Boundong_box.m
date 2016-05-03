% Question 2:
% Read the sample program for template matching given in the lecture note (templatematching( ))
% and understand how it works. Select two video frames from a video that contain the same
% object or person with shifted positions. Identify a bounding box for the object in one frame.
% Write your own program that can help find its corresponding position in another frame. Was the
% result accurate? If not, give some reasons that may have contributed to the error. 


xyloObj = VideoReader('pen4.mp4'); % Create Object
nFrames = xyloObj.NumberOfFrames; % Obtain Frame Number
vidHeight = xyloObj.Height; % Obtain Image Height
vidWidth = xyloObj.Width; % Obtain Image Width
mov(1:nFrames)= struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);
target_frame = read(xyloObj, 5); % Read in 5th Frame
for k = 1 : nFrames-1
mov(k).cdata = read(xyloObj, k); % Load video into MOV
end
 hf = figure; % Create New Display Window
set(hf, 'position', [150 150 vidWidth vidHeight]) % Set window Location
 movie(hf, mov, 1, xyloObj.FrameRate); % Display video sequence
a=mov(2).cdata;
b=mov(20).cdata;
subplot(2,2,1);imshow(a); title('frame 2');
subplot(2,2,2);imshow(b); title('frame 20');
subplot(2,2,3);imshow(mov(40).cdata); title('frame 40');
subplot(2,2,4);imshow(mov(55).cdata); title('frame 55');
imwrite(a,'a.jpg');
imwrite(b,'b.jpg');
figure,imshow(a,[]), title('anchor image');
figure,imshow(b,[]), title('target image');

a1=rgb2gray(a);
b1=rgb2gray(b);
a2=int16(a1);
b2=int16(b1);

figure, imshow(a2);title('anchor image');
figure, imshow(b2);title('target image');
x0=590;y0=860;
 x1=850;y1=910;
 Rx=600;Ry=300;
 template=a2(y0:y1,x0:x1);
 [xm,ym,matchblock]=EBMA(template,b2,x0,y0,Rx,Ry);
disp('xm=');
disp(xm);
disp('ym=');
disp(ym);
disp('true location');
disp('x= 495,y=580');
[r,c]=size(matchblock);
 sh1 = insertShape(a, 'rectangle', [x0 y0 x1-x0 y1-y0],'Color', 'red');
figure,subplot(1,2,1),imshow(sh1,[]); title('Anchor frame');
 sh2 = insertShape(b, 'rectangle', [xm ym c r],'Color', 'red');
subplot(1,2,2),imshow(sh2,[]);title('target frame');

% 
% 
% 
