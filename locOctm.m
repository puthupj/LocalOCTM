function img = locOctm(filename,splitr,splitc,u,d)
%use splitr and splitc for rows and cols. splitr<2  or splitc<2 uses global.
img = imread(filename);
yuv = rgb2ntsc(img);    %convert to colour space, and obtain the luminicance
lum = yuv(:,:,1);     %take the luminacity matrix
cvx_quiet(2);         %not displaying the cvx function output
w=splitr;             %number of row splits
v=splitc;             %number of coloumn splits
si=size(lum);         
final=zeros(si(1),si(2));  % generate the final matrix with same size of lum matrix
if(w==1 || v==1)
    splitr=1;
    splitc=1;
end

if(splitr <2 || splitc<2)
    splitr=1;
    splitc=1;
end
%this loop using desiered row and coloumn split the image to smaller
%sections and return each section with their corresponding center point
for y = 1:splitr
    for x = 1:splitc
            %sementing and finding corresponding  center
        [seg centers] = SEGMENT(lum,splitr, splitc, y,x);
            
        dims = size(seg);
        lum_seg = seg;
        %finding edges on each segment
        e_pdf = edges(seg);
        %apply octm function for each block 
        tfn = octm(e_pdf,u,d);
        %put centerr and transfer function of each segment in new matrix
        cen(x,y,:)=centers;
        
        tfns(x,y,:) = tfn;
    end
   
end




lum = (length(tfn)-1).*lum;   %de normalize luminiscence
lum = round(lum);
% if we have just block it is global octm
if(splitr ==1 && splitc==1)
   dims = size(yuv);
   final = tfn((lum(1:(dims(1)), 1:(dims(2))))+1); 
else
%this case is for local octm 
%this segment is for centeral points 
    for j=1:splitr-1
        for i=1:splitc-1
                % taking each center point and transfer function for each 4
                % segment to run the linear interpolation 
                c1=cen(i,j,:);
                c2=cen(i,j+1,:);
                c3=cen(i+1,j,:);
                t1 = tfns(i,j,:);
                t2 = tfns(i,j+1,:);
                t3 = tfns(i+1,j,:);
                t4 = tfns(i+1,j+1,:);
            
               %applying the weighting on each point inside block c1 , c2,
               %c3 ,c4
            for q = c1(2):c2(2)
                for p= c1(1):c3(1)
                    %operate on pixel pq
                    
                    final(q,p) = merge([p,q],c1,c2,c3,t1(lum(q,p)+1),t2(lum(q,p)+1),t3(lum(q,p)+1),t4(lum(q,p)+1));
                end
            end
        end
    end
    % corner 1,1 
    tfn11 = tfns(1,1,:);
    for j = 1:cen(1,1,2)-1 
        for i = 1:cen(1,1,1)-1
            
            final(j,i) = tfn11(lum(j,i)+1);
        end
    end
    % corner 1,n
    tfn1n = tfns(splitc,1,:);
    for j = 1:cen(splitc,1,2)-1
        for i = cen(splitc,1,1):si(2)%%%%
            final(j,i) = tfn1n(lum(j,i)+1);
        end
    end
    
    %corner n,1
    tfnn1 = tfns(1,splitr,:);
    for j = cen(1,splitr,2):si(1)
        for i = 1:cen(1,splitr,1)-1
            final(j,i) = tfnn1(lum(j,i)+1);
        end
    end
    
    %corner n,n
    tfnnn = tfns(splitc,splitr,:);
    for j = cen(splitc,splitr,2):si(1)
        for i = cen(splitc,splitr,1):si(2)
            final(j,i) = tfnnn(lum(j,i)+1);
        end
    end
    
    %long pieces
    %long piece top
    for m = 1:splitc-1
        t1 = tfns(m,1,:);
        t2 = tfns(m+1,1,:);
        for j = 1:cen(1,1,2)-1
            for i = cen(m,1,1):cen(m+1,1,1)-1
                final(j,i) = mergex([i j],cen(m,1,:),cen(m+1,1,:),t1(lum(j,i)+1),t2(lum(j,i)+1));
            end
        end
    end
    %long piece left
    for m = 1:splitr-1
        t1 = tfns(1,m,:);
        t2 = tfns(1,m+1,:);
        for j = cen(1,m,2):cen(1,m+1,2)-1
            for i = 1:cen(1,1,1)-1
                final(j,i) = mergey([i j],cen(1,m,:),cen(1,m+1,:),t1(lum(j,i)+1),t2(lum(j,i)+1));
            end
        end
    end
    
    %long piece bottom
    for m = 1:splitc-1
        t1 = tfns(m,splitr,:);
        t2 = tfns(m+1,splitr,:);
        for j = cen(1,splitr,2):si(1)
            for i = cen(m,splitr,1):cen(m+1,splitr,1)-1
                final(j,i) = mergex([i j],cen(m,splitr,:),cen(m+1,splitr,:),t1(lum(j,i)+1),t2(lum(j,i)+1));
            end
        end
    end
    
    %long piece right
    for m = 1:splitr-1
        t1 = tfns(splitc,m,:);
        t2 = tfns(splitc,m+1,:);
        for j = cen(splitc,m,2):cen(splitc,m+1,2)-1
            for i = cen(splitc,1,1):si(2)
                final(j,i) = mergey([i j],cen(splitc,m,:),cen(splitc,m+1,:),t1(lum(j,i)+1),t2(lum(j,i)+1));
            end
        end
    end
end

yuv(:,:,1) = final;
img = ntsc2rgb(yuv);

end