% EMBA (templatematching())function:
function [xm,ym,matchblock]=EBMA(template,img,x0,y0,Rx, Ry)
%x0,y0 define the location of the top left corner of the template in the previous image
%xm,ym define the matched position of the template in the current image
%R is the search range
%template and img should be saved in integer or float
[H,W]=size(img);
[BH,BW]=size(template);
maxerror=BH*BW*255;
xm=x0;
ym=y0;
for (k=max(1,x0-Rx):min(W-BW,x0+Rx))
for (l=max(1,y0-Ry):min(H-BH,y0+Ry))
candidate=img(l:l+BH-1,k:k+BW-1);
error=sum(sum(abs(template-candidate))); %SAD
if (error<maxerror)
xm=k;ym=l;matchblock=candidate;
maxerror=error;
end
end
end
