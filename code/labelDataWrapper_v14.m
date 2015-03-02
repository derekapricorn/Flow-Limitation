%this version deals iwth 
clear
filedir = uigetdir;
cd(filedir);
filetoRead = uigetfile('*.txt'); %get the filename

startTime = input('Please enter the time to start: ');
lightsOffTime = input('Please enter duration of lights off: ') + startTime;

bias = input('Bias: ');
min_intv = input('Minimum duration of each inspiratory event: '); %default 1
min_area = input('Minimum enclosed area: '); %default 300

addpath('C:\Users\zhid\Documents\Analysis\Codes\FlowLimitation\Saline_Flow\');

importfile(filetoRead); %function to import the file
%find sampling rate: this might bug out if sampling rate is recorded to a different precision
Fs = str2double(colheaders{2}(1:5));
%resample to 40Hz 

data_rs = resample(data,40*100,Fs*100);
numSamples = size(data_rs,1);
startInd = round(startTime*40);
lastInd = round(lightsOffTime*40);
count = 0;

%assign data columns to variable names for clarity
time = linspace(0,numSamples/40,size(data_rs,1))';
nasalP = data_rs(:,2);

%flip the nasalP signal
nasalP = nasalP * (-1)-bias; %correct the bias
% chest = data_rs(:,4);
% abdomen = data_rs(:,3);
% sum_1 = data_rs(:,5);

%loop through analyze every 12000 data points
incr = 12000; %increment approximately 5 minutes (300 seconds)
           
for ii = startInd:incr:lastInd;
    count = count + 1;
    %Find zero-crossings for each subset - repeat of above but to lazy to
    %figure out indexing
    nasalPincr = nasalP(ii:ii+incr-1); %vector of nasalP window
    nasalP_g = smooth_fn(nasalPincr,40);
    
    %subtract the offset
    %nasalPincr = nasalPincr - mean(nasalPincr);
    
    nasalPsign =  nasalP_g > bias; %vector of 1s for nasalP > 0 and 0s for nasalP <= 0
    dif = nasalPsign(2:end)- nasalPsign(1:end-1); %find differences to identify transition from 0 to 1
    i_start = find(dif == 1); %dif = 1 is transition from neg to pos
    i_end = find(dif == -1); % dif = -1 is transition from pos to neg
    %error checking
    
    if i_start(1)>i_end(1)
        i_start = i_start(1:end-1);
        i_end = i_end(2:end);
    end
    %validation of zero-crossings
    [start_stamp, end_stamp] = event_capture(nasalP_g,i_start,i_end,40,min_intv,min_area);
    t_start = time(ii) + start_stamp/40;
    t_end = time(ii) + end_stamp/40;

    %find individual breath for analysis in GUI
    capture_breath_test2(time(ii:ii+incr-1),nasalP_g, t_start, t_end, count);

   close all 
end