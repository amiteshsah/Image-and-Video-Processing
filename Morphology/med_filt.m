function m=my_med_filt(y)

[xh xw] = size(y); 

in=input('Enter the order of filter');
h = ones(in,in)/(in^2);
[hh hw] = size(h);
hhh = (hh - 1) / 2;
hhw = (hw- 1) / 2; 

z = y; %or z=zeros(xh,xw) if not low-pass filter
for m = hhh + 1:xh - hhh,
%skip first and last hhh rows to avoid boundary problems
 for n = hhw + 1:xw - hhw,
%skip first and last hhw columns to avoid boundary problems
 tmpy = 0;
 for k = -hhh:hhh,
 for l = -hhw:hhw,
 tmpv(k+hhh+1,l+hhw+1) = y(m - k,n - l);
 % substitute with median value
[r,c]=size(tmpv);
len=r*c;
b=reshape(tmpv,1,len);
me=median(b);
 end
 end
 z(m, n) = me;
 end
 m=z;
end 