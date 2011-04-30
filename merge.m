function lp = merge(p,c1,c2,c3,l1,l2,l3,l4)
%finding the weights of each point in inner blocks, refer to report for explnation
    w1 = abs(p(1)-c1(1))/(abs(p(1)-c1(1))+ abs(p(1)-c3(1)));
    w1 = 1-w1;
    w2 = abs(p(1)-c3(1))/(abs(p(1)-c1(1))+ abs(p(1)-c3(1)));
    w2 = 1-w2;
    w3 = abs(p(2)-c1(2))/(abs(p(2)-c1(2))+ abs(p(2)-c2(2)));
    w3 = 1-w3;
    w4 = abs(p(2)-c2(2))/(abs(p(2)-c1(2))+ abs(p(2)-c2(2)));
    w4 = 1-w4;
    
    lp = (w1)*((w3)*l1 + (w4)*l2)+(w2)*((w3)*l3+(w4)*l4);
    
end

