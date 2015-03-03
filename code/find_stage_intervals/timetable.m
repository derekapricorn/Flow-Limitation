function [] = timetable ()
filedir = uigetdir;
cd(filedir);
fname = dir('*.mat');
list = [];
for jj = 1:length(fname)
    load(fname(jj).name);
    list = [list;int16(t(1)),int16(t(end))];
end

T = table(list);
writetable(T,'Timetable.txt','Delimiter',' ')
end