function t = octm (p, u,d)
%dims = size(lum);
%p = imhist(lum);
L = length(p)-1;

one = ones(1,L+1);
u = u*one;
ds = d*one-one;
zero = zeros(1,L+1);

%genereate the W matrix for constraint
w = [ones(1,d) zeros(1,L-d+1)];

for i=1:L-d+2
    W(i,:) = circshift(w, [0 i-1]);
end

W = sparse(W);
cvx_begin
    variable s(L+1);
    maximize (p'*s);
    subject to;
        s>=zero';
        s<=u';
        one*s == L+1;
        W*s>=ds(L-d+2)';
cvx_end

s = round(s);
s = s/(L+1);


t = cumsum(s);
%yuv(:,:,1) = t((lum(1:(dims(1)), 1:(dims(2))))+1);  %apply transfer function.
end