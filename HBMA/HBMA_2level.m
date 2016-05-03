f1 = 'foreman103.Y';
f2 = 'foreman100.Y';
R = 32;
W = 352;
H = 288;
N = 16;
fp = zeros(H, W);
f3 = zeros(H/2, W/2);
f4 = zeros(H/2, W/2);
f5 = zeros(H*2-1, W*2-1);
mvx = zeros(H/N, W/N);
mvy = zeros(H/N, W/N);
[X, Y] = meshgrid(N/2:N:W, N/2:N:H);
% read frames
fid1 = fopen(f1, 'r');
fid2 = fopen(f2, 'r');
f1 = fread(fid1, [W, H], 'uint8=>double')'; f2 = fread(fid2, [W, H], 'uint8=>double')'; fclose(fid1);
fclose(fid2);
% downsample
for i = 1:H/2
    for j = 1:W/2
        f3(i, j) = mean2(f1(i*2-1:i*2, j*2-1:j*2));
        f4(i, j) = mean2(f2(i*2-1:i*2, j*2-1:j*2));
    end
end
% upsample
f5(1:2:H*2-1, 1:2:W*2-1) = f2; for i = 2:2:H*2-1
f5(i, :) = (f5(i-1, :)+f5(i+1, :))/2;
end
for j = 2:2:W*2-1
f5(:, j) = (f5(:, j-1)+f5(:, j+1))/2;
end
%  EBMA for first layer
for i = 1:N:H/2
    for j = 1:N:W/2
        MAD_min = 255*N*N;
        for k = -R/2:R/2
if i+k < 1 || i+k+N > H/2 % check vertical boundary
        continue;
    end
for l = -R/2:R/2
if j+l < 1 || j+l+N > W/2 % check horizontal boundary
            continue;
        end
MAD = sum(sum(abs(f3(i:i+N-1, j:j+N-1)-f4(i+k:i+k+N-1, j+l:j+l+N-1))));

        if MAD < MAD_min
            MAD_min = MAD;
            dy = k;
            dx = l;
        end
end
        end
iblk = (i-1)/(N/2)+1;
jblk = (j-1)/(N/2)+1;
mvx(iblk:iblk+1, jblk:jblk+1) = 2*dx*ones(2); mvy(iblk:iblk+1, jblk:jblk+1) = 2*dy*ones(2);
    end
end
% HBMA for second layer
for i = 1:N:H
    iblk = (i-1)/N+1;
    for j = 1:N:W
jblk = (j-1)/N+1;
MAD_min = 255*N*N;
for k = mvy(iblk, jblk)-1:mvy(iblk, jblk)+1
if i+k < 1 || i+k+N > H % check vertical boundary continue;
    continue;
end
for l = mvx(iblk,jblk)-1:mvx(iblk, jblk)+1
    if j+l < 1 ||j+l+N > W % check horizontal boundary
        continue;
    end
MAD = sum(sum(abs(f1(i:i+N-1, j:j+N-1)-f2(i+k:i+k+N-1, j+l:j+l+N-1))));

        if MAD < MAD_min
            MAD_min = MAD;
            
dy = k;
dx = l;
        end
end
    end
    mvx(iblk, jblk) = dx;
mvy(iblk, jblk) = dy;
end
end
% half-pel refinement
for i = 1:N:H
    iblk = (i-1)/N+1;
    for j = 1:N:W
jblk = (j-1)/N+1;
MAD_min = 255*N*N;
for k = mvy(iblk, jblk)-0.5:0.5:mvy(iblk, jblk)+0.5
if i+k < 1 || i+k+N > H % check vertical boundary continue;
end
for l = mvx(iblk, jblk)-0.5:0.5:mvx(iblk, jblk)+0.5
if j+l < 1 || j+l+N-1 > W % check horizontal boundary continue;
end
MAD = sum(sum(abs(f1(i:i+N-1, j:j+N-1)-f5((i+k:i+k+N-1)*2-1, (j+l:j+l+N-1)*2-1))));
                if MAD < MAD_min
                    MAD_min = MAD;
dy = k;
dx = l;
end end
end
fp(i:i+N-1,j:j+N-1) = f5((i+dy:i+dy+N-1)*2-1, (j+dx:j+dx+N-1)*2-1);
mvx(iblk, jblk) = dx;
mvy(iblk, jblk) = dy;
end end
PSNR = 10*log10(255^2/mean2((fp-f1).^2));
