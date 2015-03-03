function [ t_out ] = intersec_interval( t_ref,t_niu )
%The function takes two arrays of intervals and finds the intersection of 
%the two intervals
%in:[m*2],[n*2]
%out:[k*2]

temp = [];
for ii = 1:length(t_niu)
    if in_or_out(t_ref, t_niu(ii,:))
        temp = [temp;t_niu(ii,:)];
    end
end

t_out = temp;
end