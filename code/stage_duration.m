function [] = stage_duration()
%this is a routine to read the sleep stages in the event.txt file and look 
%for the time intervals for the designated stages within a certain range
%time is all in format of '12:08:56 PM'
%ss = 1:NREM1
%ss = 2:NREM2
%ss = 3:NREM3
%ss = 4:NREM4
%ss = 5:Wake
%ss = 6:not in use
%it prompts user to select the event file of interest, and then input the 
%desired stage. the apnea hypopnea stages are automatically calculated as
%well.
%Output is t_event: start and end of breaths in the specified stages
%and t_intersec_event: start and end of breaths in the A/H stages inside
%the speficied stages.

filedir = uigetdir;
cd(filedir);
filetoRead = uigetfile('*.txt'); %get the filename
%get range and sleep stage
% st = input('Start Time:');
% et = input('End time:');
% lot = input('Lights-off time (eg. [12:08:56 PM]):');
ss = input('Sleep Stage:');
%addpath('C:\Users\zhid\Documents\Analysis\Codes\FlowLimitation\Saline_Flow\');

%this is to read the content into matlab
fid = fopen(filetoRead,'rt'); 
indata = textscan(fid, '%u%s%s%d', 'Delimiter', '\t','HeaderLines',14); 
fclose(fid); 
% epoch = indata{1};
event = indata{2};
start_time = indata{3};
duration = indata{4};


%find the index of light off time
% count = 1;
% while ~strcmp(event{count},'Lights Off')
%     count = count + 1;
% end
t0 = start_time{1};
%find epoch numbers, which is "match", that correspond to the specified stage
if ss == 1
    match = find(strcmp(event,'Stage 1'));
elseif ss == 2
    match = find(strcmp(event,'Stage 2'));
    %match = find(strcmp(event,'NREM 2')); %Stage 2 is renamed to NREM2 by the new system
elseif ss == 3
     match = find(strcmp(event,'Stage 3'));
elseif ss == 4
     match = find(strcmp(event,'Stage 4'));
elseif ss == 5
     match = find(strcmp(event,'Wake')); 
end

%t_event is [n,2] matrix containing start and end ref time for each
%qualified stage
t_event = zeros(length(match),2);
for ii = 1:length(match)
    t_event(ii,1) = (datenum(start_time{match(ii)})-datenum(t0))*24*60*60;
    %find the entries with duration and add duration to the end time; if
    %no duration is found, the end times remains 0
    if duration(match(ii))~=0
        t_event(ii,2) = t_event(ii,1)+duration(match(ii));
    end
end
t_event = t_event((t_event(:,2)~=0),:);
num_int = size(t_event);
tot_time = sum(t_event(:,2)-t_event(:,1));

sprintf('total duration of nrem 2 is %d, and %d entries',tot_time, num_int(1))