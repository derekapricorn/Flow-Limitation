function [ v ] = v_listbox( type )
%determine the value of the list box, returning 1 if the first entry, 2
% the second, and so on
if strcmp(type,'Unknown')
    v = 1;
elseif strcmp(type,'Normal')
    v = 2;
elseif strcmp(type,'Intermediate')
    v = 3;
else
    v = 4;
end


end

