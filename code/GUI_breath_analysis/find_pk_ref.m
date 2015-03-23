function [ ref, ylim ] = find_pk_ref()
%This function finds the top 3% of the peak inspiratory signal from the
%designated subject as the reference for later annotation.
filedir = uigetdir;
cd(filedir);
fname = dir('*.mat');
maximas = [];
%find all the maximas throughout all the study
for jj = 1:length(fname)
    load(fname(jj).name);
     for kk = 1:length(p_cell)
       maximas = [maximas;max(p_cell{kk})];
     end
end
%find the histogram 
histfit(maximas, 100);
[mu,s,~,~] = normfit(maximas);
%find the ref to be miu+2std;
ylim = mu+2*s;
ref = mu+s;
% binranges = linspace(min(maximas),max(maximas),100);%find 100 evenly divided bins within the range
% [bincounts,~] = histc(maximas,binranges);
% possible_range = bincounts((binranges>mu+s));
% temp = find(possible_range == max(possible_range));
% temp2 = find(binranges>mu+s);
% ref = temp2(1)+binranges(temp(end));

end


%%
% implement this filtering script so that any peak that's lower than 10% of
% the reference peak will be denied

% pk_ref = 1031.3;
% fname = dir('*.mat');
% count = 0;
% for jj = 1:length(fname)
%     load(fname(jj).name);
%      for kk = 1:length(p_cell)
%          if max(p_cell{kk})  < 0.1*pk_ref && ~strcmp(type_cell{kk},'Unknown')
%              fname(jj).name;
%              type_cell{kk} = 'Low signal';
%              count = count + 1;
%          end         
%      end
%      fn = strcat('tp_',num2str(jj),'.mat');
%      save(fn,'t_cell','p_cell','t','p','type_cell');
% end
% count
