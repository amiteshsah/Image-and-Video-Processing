% 1.Write a program that can:
% i) read in a short video clip (keep up to only, say 30 frames); 
% ii)Compare each two successive frames to extract pixels with significant 
%     change (absolute difference greater than a threshold T), set such pixels
%     to white, while keeping other pixels as black; 
% iii) Display the successive thresholded difference images as a movie;
% iv) Save the successive difference images as an ".avi" file. 

xyloObj=VideoReader('pen4.mp4');
nFrames=xyloObj.NumberOfFrames;
vidHeight=xyloObj.Height;
vidWidth=xyloObj.Width;
mov(1:30)= struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),'colormap', []);

%select each 2 successive frames
for i=1:1:30
frame1 =read(xyloObj,i);
frame2=read(xyloObj,i+1);
frame1=uint8(frame1);
frame2=uint8(frame2);
diff=abs(frame1-frame2);
mov(i).cdata=diff;
end
%display the difference of two frames
diff=rgb2gray(diff);
diff=(diff>30)*255;
diff=uint8(diff);
subplot(1,3,1);imshow(frame1,[]);
subplot(1,3,2);imshow(frame2,[]);
subplot(1,3,3);imshow(diff,[]);
% show the difference as a movie at framerate = 5
% movie(figure, mov, 1, 5);
% save the difference as a ".avi" file
myObj=VideoWriter('newfile.avi');
myObj.FrameRate=5;
open(myObj);
for i=1:30
temp=mov(i).cdata;
writeVideo(myObj,temp);
end
close(myObj);
hf = figure; % Create New Display Window
set(hf, 'position', [150 150 vidWidth vidHeight]) % Set window Location
movie(hf, mov, 1, xyloObj.FrameRate); % Display video sequence
% or:
% v = VideoReader('Street.MPG');
% mov = read(v);
% mov_new = diff(mov,1,4);% if 4 =>1 then it is the x ax diff, 4=>2 y ax diff
% new_vid = VideoWriter('Street_new');
% open(new_vid);
% writeVideo(new_vid,mov_new);
% close(new_vid);
