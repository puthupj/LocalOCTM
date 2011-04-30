function hist = edges(lum)
lf = fspecial('log',[5 5] , 100);
lum_t = imfilter(lum, lf);
t1 = max(max(lum_t));
t2 = min(min(lum_t));
%mask = (mask + abs(t2))./(t1+abs(t2));
lum_t = (lum_t + abs(t2))./(t1+abs(t2));
mask = edge(lum_t,'zerocross',0.003); %create a mask
mask = double(mask);

edges = mask.*lum; %apply mask on edges
edges_z = double((lum==0)).*mask; %apply mask on edges of value 0
  
hist = imhist(edges);    %generate histogram of the edges image
htemp = imhist(edges_z);
htemp(1)=0;
hist(1) = norm(htemp,1);
hist = hist./norm(hist,1);
end