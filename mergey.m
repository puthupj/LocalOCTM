function lp = mergey(p,e1,e2,l1,l2)
%finding the weights of each point in vertical corner case, refer to report for
%explnation
    w2 = abs(p(2)-e1(2))/abs(e2(2)-e1(2));
    w1 = 1-w2;  
    lp = w1*l1+w2*l2;
end