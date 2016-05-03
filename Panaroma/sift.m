function [image, descriptors, locs] = sift(imageFile)
 
% Load image
image = imread(imageFile);
 
% If you have the Image Processing Toolbox, you can uncomment the following
%   lines to allow input of color images, which will be converted to grayscale.
% if isrgb(image)
%    image = rgb2gray(image);
% end
 
[rows, cols] = size(image); 
 
% Convert into PGM imagefile, readable by "keypoints" executable
f = fopen('tmp.pgm', 'w');
if f == -1
    error('Could not create file tmp.pgm.');
end
fprintf(f, 'P5\n%d\n%d\n255\n', cols, rows);
fwrite(f, image', 'uint8');
fclose(f);
 
% Call keypoints executable
if isunix
    command = '!./sift ';
else
    command = '!siftWin32 ';
end
command = [command ' <tmp.pgm >tmp.key'];
eval(command);
 
% Open tmp.key and check its header
g = fopen('tmp.key', 'r');
if g == -1
    error('Could not open file tmp.key.');
end
[header, count] = fscanf(g, '%d %d', [1 2]);
if count ~= 2
    error('Invalid keypoint file beginning.');
end
num = header(1);
len = header(2);
if len ~= 128
    error('Keypoint descriptor length invalid (should be 128).');
end
 
% Creates the two output matrices (use known size for efficiency)
locs = double(zeros(num, 4));
descriptors = double(zeros(num, 128));
 
% Parse tmp.key
for i = 1:num
    [vector, count] = fscanf(g, '%f %f %f %f', [1 4]); %row col scale ori
    if count ~= 4
        error('Invalid keypoint file format');
    end
    locs(i, :) = vector(1, :);
    
    [descrip, count] = fscanf(g, '%d', [1 len]);
    if (count ~= 128)
        error('Invalid keypoint file value.');
    end
    % Normalize each input vector to unit length
    descrip = descrip / sqrt(sum(descrip.^2));
    descriptors(i, :) = descrip(1, :);
end
fclose(g);

function [points1, points2] = SIFTmatch(im1, im2, mode, show)
if nargin < 4, show = false;end
 
if nargin >= 3 && mode == 1
    load previous_points points1 points2
    fprintf('using previous points (%i matches)\n',size(points1,1));
else
 
    % Get matching SIFT keypoints
    [loc1,loc2,matchidxs]=mymatch( rgb2gray(im1), rgb2gray(im2), show );
 
    % Initialize point vectors
    points1 = loc1(find(matchidxs>0),1:2);
    points2 = loc2(nonzeros(matchidxs),1:2);
    points1 = points1(:,[2 1]);
    points2 = points2(:,[2 1]);
 
    % Remove duplicate points
    pts=unique([points1 points2], 'rows');
    disp(sprintf('Number of matches: %i (unique: %i)',size(points1,1),size(pts,1)))
    fprintf('\n')
    points1 = pts(:,[1 2]);
    points2 = pts(:,[3 4]);
 
    save previous_points points1 points2
 
end
end
