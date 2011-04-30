function [A centers endp] = SEGMENT(lum,x_div, y_div, i , j)
% this function take the lum matrix and number of the row and coloumn
% divisions and segment the image by taking to acount the remaindar of row
% and coloumn division , please refer to report
x = length(lum(:,1));
y = length(lum(1,:));
x_rem=rem(x,x_div);
y_rem=rem(y,y_div);
x_pix=floor(x/x_div);
y_pix=floor(y/y_div);
%when still some remainder left
if(x_rem-i>=0 && y_rem-j>=0)
    A =lum((i-1)*x_pix+(i):(i)*x_pix+(i),(j-1)*y_pix+(j):(j)*y_pix+(j));
    centers=[(j-1)*y_pix+(j)+floor(y_pix/2);(i-1)*x_pix+(i)+floor(x_pix/2)];
  %  endp = [(j-1)*y_pix+(j),(i-1)*x_pix+(i);(j)*y_pix+(j),(i)*x_pix+(i)];
%when there is row remainder left and no coloumn remaindar
elseif(x_rem-i>=0 && y_rem-j<0)
    A =lum((i-1)*x_pix+(i):(i)*x_pix+(i),(j-1)*y_pix+(y_rem+1):(j)*y_pix+(y_rem));
    centers=[(j-1)*y_pix+(y_rem)+floor(y_pix/2);(i-1)*x_pix+(i)+floor(x_pix/2)];
   % endp =[(j-1)*y_pix+(y_rem+1),(i-1)*x_pix+(i);(j)*y_pix+(y_rem),(i)*x_pix+(i)];
%when there is coloumn remainder left and no row remaindar
elseif(x_rem-i<0 && y_rem-j>=0)
    A =lum((i-1)*x_pix+(x_rem+1):(i)*x_pix+(x_rem),(j-1)*y_pix+(j):(j)*y_pix+(j));
    centers=[(j-1)*y_pix+(j)+floor(y_pix/2);(i-1)*x_pix+(x_rem)+floor(x_pix/2)];
   % endp = [(j-1)*y_pix+(j),(i-1)*x_pix+(x_rem+1);(j)*y_pix+(j),(i)*x_pix+(x_rem)];
%when there is no coloumn remainder left and no row remaindar 
else
    A =lum((i-1)*x_pix+(x_rem+1):(i)*x_pix+(x_rem),(j-1)*y_pix+(y_rem+1):(j)*y_pix+(y_rem));
    centers=[(j-1)*y_pix+(y_rem)+floor(y_pix/2);(i-1)*x_pix+(x_rem)+floor(x_pix/2)];
   % endp = [(j-1)*y_pix+(y_rem+1), (i-1)*x_pix+(x_rem+1);(j)*y_pix+(y_rem),(i)*x_pix+(x_rem)];
end


end