function lp = mergex(p,e1,e2,l1,l2)
%finding the weights of each point in horizetal corner case, refer to report for
%explnation
    w2 = abs(p(1)-e1(1))/abs(e2(1)-e1(1));
    w1 = 1-w2;
    lp = w1*l1+w2*l2;
end