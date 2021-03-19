function [result] = HLR_BM2( A , B )

result = int32(0);
A = int32(A);
B = int32(B);
dm1 = 0;

for index=0:3:9                                 % Using R8ABE2 for the first 4 partial product rows     
    
    dp2 = bitget(B,bin_index(index+2));         % Getting the 4 bit combination from the multiplier D
    dp1 = bitget(B,bin_index(index+1));
    d = bitget(B,bin_index(index));
    
    if (dp2==0 && dp1==0 && d==0 && dm1==1) || ( dp2==0 && dp1==0 && d==1 && dm1==0)
        pp = bitshift(A,0);
    elseif (dp2==0 && dp1==0 && d==1 && dm1==1) || ( dp2==0 && dp1==1 && d==0 && dm1==0) || (dp2==0 && dp1==1 && d==0 && dm1==1)
        pp = bitshift(A,1);
    elseif (dp2==0 && dp1==1 && d==1 && dm1==0) || (dp2==0 && dp1==1 && d==1 && dm1==1)
        pp = bitshift(A,2);
    elseif (dp2==1 && dp1==0 && d==0 && dm1==0) || (dp2==1 && dp1==0 && d==0 && dm1==1)
        pp = -bitshift(A,2);
    elseif (dp2==1 && dp1==0 && d==1 && dm1==1) || ( dp2==1 && dp1==1 && d==0 && dm1==0) || ( dp2==1 && dp1==0 && d==1 && dm1==0)
        pp = -bitshift(A,1);
    elseif(dp2==1 && dp1==1 && d==0 && dm1==1) || ( dp2==1 && dp1==1 && d==1 && dm1==0)
        pp = -bitshift(A,0);
    else pp = 0;
    end
    
    result = result + bitshift(pp,index);
    dm1 = dp2;
end

for index=12:2:14                               % Using Accurate Radix 4 booth for the rest 2 partial product rows
    
    dp1 = bitget(B,bin_index(index+1));         % Getting the 3 bit combination from the multiplier D
    d = bitget(B,bin_index(index));
    dm1 = bitget(B,bin_index(index-1));
    
    if (dp1==0 && d==0 && dm1==1) || ( dp1==0 && d==1 && dm1==0 )
        pp = bitshift(A,0);
    elseif(dp1==1 && d==0 && dm1==1) || ( dp1==1 && d==1 && dm1==0 )
        pp = -bitshift(A,0);
    elseif (dp1==0 && d==1 && dm1==1)
        pp = bitshift(A,1);
    elseif (dp1==1 && d==0 && dm1==0)
        pp = -bitshift(A,1);
    elseif (dp1==1 && d==1 && dm1==1) || ( dp1==0 && d==0 && dm1==0 )
        pp = 0;
    end
    
    result = result + bitshift(pp,index);
end

end
