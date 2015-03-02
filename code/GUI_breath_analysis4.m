function varargout = GUI_breath_analysis4(varargin)
% GUI_BREATH_ANALYSIS4 MATLAB code for GUI_breath_analysis4.fig
%      GUI_BREATH_ANALYSIS4, by itself, creates a new GUI_BREATH_ANALYSIS4 or raises the existing
%      singleton*.
%
%      H = GUI_BREATH_ANALYSIS4 returns the handle to a new GUI_BREATH_ANALYSIS4 or the handle to
%      the existing singleton*.
%
%      GUI_BREATH_ANALYSIS4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_BREATH_ANALYSIS4.M with the given input arguments.
%
%      GUI_BREATH_ANALYSIS4('Property','Value',...) creates a new GUI_BREATH_ANALYSIS4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_breath_analysis4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_breath_analysis4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_breath_analysis4

% Last Modified by GUIDE v2.5 22-Feb-2015 17:30:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_breath_analysis4_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_breath_analysis4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_breath_analysis4 is made visible.
function GUI_breath_analysis4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_breath_analysis4 (see VARARGIN)

% Choose default command line output for GUI_breath_analysis4
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_breath_analysis4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_breath_analysis4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function textbox1_Callback(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox1 as text
%        str2double(get(hObject,'String')) returns contents of textbox1 as a double


% --- Executes during object creation, after setting all properties.
function textbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Textbox2_Callback(hObject, eventdata, handles)
% hObject    handle to Textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Textbox2 as text
%        str2double(get(hObject,'String')) returns contents of Textbox2 as a double


% --- Executes during object creation, after setting all properties.
function Textbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat', 'Pick a segment');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       %initial setup
       S = load(filename);
       handles.filename = filename;
       counter = 1;
       handles.S=S;
       handles.counter = counter;     
       handles.type = S.type_cell;
       handles.window = 30;
       handles.stage_on = 0; % stage_on = -1 =>"OFF", 1 =>"ON"
       
       %set textbox
       set(handles.textbox1, 'String', length(S.t_cell));
       set(handles.Textbox2, 'String', counter);
       set(handles.textbox4, 'String', handles.window);
       
       %set listbox
       if strcmp(handles.type(counter),'Unknown')
           v = 1;
       elseif strcmp(handles.type(counter),'Normal')
           v = 2;
       elseif strcmp(handles.type(counter),'Intermediate')
           v = 3;
       else
           v = 4;
       end
       
       set(handles.listbox1,'Value',v);

       
       %set axes1
       axes(handles.axes1);       
       plot(S.t_cell{counter},S.p_cell{counter})
       ylim([0,max(S.p_cell{counter})]);
              
       %set axes 3
       axes(handles.axes3);  
       [i_s,i_e,~,c_e] = axis3_indexes(S.t,counter,handles.window,S.t_cell,0);%c_e is the end counter
       plot(S.t(i_s:i_e),S.p(i_s:i_e)) %plot half of a minute of data
       ylim([0,max(S.p(i_s:i_e))]);
       yL = get(gca,'YLim');
       line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
       hline = refline(0,0); %plot reference line at 0
       set(hline,'Color','k')
       axis tight
       handles.c_e = c_e;
       handles.c_s = 1;
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
counter = handles.counter;
counter = counter -1;
S = handles.S;

if counter == 0
    ME = MException('This is the beginning already, try something else');
    throw(ME);
else
    axes(handles.axes1);
    plot(S.t_cell{counter},S.p_cell{counter});
    ylim([0,max(S.p_cell{counter})]);
    set(handles.Textbox2, 'String', counter);
    if strcmp(handles.type(counter),'Unknown')
        v = 1;
    elseif strcmp(handles.type(counter),'Normal')
        v = 2;
    elseif strcmp(handles.type(counter),'Intermediate')
        v = 3;
    else
        v = 4;
    end
    set(handles.listbox1,'Value',v);
    %label the current waveform
    axes(handles.axes3);
     yL = get(gca,'YLim');

     if counter >= handles.c_s
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        line([S.t_cell{counter+1}(round(end/2)),S.t_cell{counter+1}(round(end/2))],[yL(1),yL(2)],'Color',[1,1,1],'LineWidth',2);
     else
        [i_s,i_e,c_s,c_e] = axis3_indexes(S.t,counter,handles.window,S.t_cell,-1);
        plot(S.t(i_s:i_e),S.p(i_s:i_e)) 
        ylim([0,max(S.p(i_s:i_e))]);
        yL = get(gca,'YLim');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %this part annotates the signal by a green horizontal bar according
        %to the specified stage
            if handles.stage_on == 1
                load('event_time.mat')
                xL = intersec_interval([S.t(i_s),S.t(i_e)],t_event);
                if ~isempty(xL)
                    hold on
                    if (xL(2)-xL(1)) > (S.t(i_e)-S.t(i_s))
                        plot([S.t(i_s),S.t(i_e)],[yL(2)/2,yL(2)/2],'g','Linewidth',3)
                    else
                        plot([xL(1),xL(2)],[yL(2)/2,yL(2)/2],'g','Linewidth',3)
                    end
                    hold off
                end
            end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        hline = refline(0,0); %plot reference line at 0
        set(hline,'Color','k');
        axis tight
        handles.c_s = c_s;
        handles.c_e = c_e;
    end
end

handles.counter = counter;
guidata(hObject, handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
counter = handles.counter;
counter = counter + 1;
S = handles.S;


if counter > length(S.t_cell)
    ME = MException('out of range');
    throw(ME)
else
    axes(handles.axes1);
    plot(S.t_cell{counter},S.p_cell{counter});
    ylim([0,max(S.p_cell{counter})]);    
    set(handles.Textbox2, 'String', counter);
    
    %determine the value of the list box, returning 1 if the first entry, 2
    % the second, and so on
    if strcmp(handles.type(counter),'Unknown')
        v = 1;
    elseif strcmp(handles.type(counter),'Normal')
        v = 2;
    elseif strcmp(handles.type(counter),'Intermediate')
        v = 3;
    else
        v = 4;
    end
    set(handles.listbox1,'Value',v);
    %label the current waveform
    axes(handles.axes3);
    yL = get(gca,'YLim');
    %plot the vertical bar to indicate the current wave
    %check if the vertical bar goes out of the window
    if counter < handles.c_e
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        line([S.t_cell{counter-1}(round(end/2)),S.t_cell{counter-1}(round(end/2))],[yL(1),yL(2)],'Color',[1,1,1],'LineWidth',2);
    else
        [i_s,i_e,c_s,c_e] = axis3_indexes(S.t,counter,handles.window,S.t_cell,1);
        plot(S.t(i_s:i_e),S.p(i_s:i_e)) 
        ylim([0,max(S.p(i_s:i_e))]);
        yL = get(gca,'YLim');
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %this part annotates the signal by a green horizontal bar according
        	%to the specified stage
            if handles.stage_on == 1
                load('event_time.mat')
                xL = intersec_interval([S.t(i_s),S.t(i_e)],t_event);
                if ~isempty(xL)
                    hold on
                    if (xL(2)-xL(1)) > (S.t(i_e)-S.t(i_s))
                        plot([S.t(i_s),S.t(i_e)],[yL(2)/2,yL(2)/2],'g','Linewidth',3)
                    else
                        plot([xL(1),xL(2)],[yL(2)/2,yL(2)/2],'g','Linewidth',3)
                    end
                    hold off
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        hline = refline(0,0); %plot reference line at 0
        set(hline,'Color','k');
        axis tight
        handles.c_s = c_s;
        handles.c_e = c_e;
    end
end

handles.counter = counter;
guidata(hObject, handles);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
v = get(handles.listbox1,'Value');
if v==1
    handles.type{handles.counter} = 'Unknown';
elseif v==2
    handles.type{handles.counter} = 'Normal';
elseif v==3
    handles.type{handles.counter} = 'Intermediate';    
else 
    handles.type{handles.counter} = 'Flattened';
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = handles.filename;
type_cell = handles.type;
save(filename,'type_cell','-append');
guidata(hObject,handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_value = get(handles.textbox3,'String');
t_value = str2num(t_value);
S = handles.S;
%check if fallen in the range
if t_value < S.t(1) || t_value > S.t(end)
        disp('out of range');
else
    for ii = 1:length(S.t_cell)
        temp = S.t_cell{ii};
        if ~isempty(temp)&&temp(1)>t_value           
            axes(handles.axes1);       
            plot(S.t_cell{ii-1},S.p_cell{ii-1})
            %ylim([0,max(S.p_cell{ii})]);
            %update type and current number
            handles.counter = ii;
            v = v_listbox(handles.type(ii));
            set(handles.listbox1,'Value',v);
            set(handles.Textbox2, 'String', ii);            
            break
        end
    end
end
guidata(hObject,handles);

function textbox3_Callback(hObject, eventdata, handles)
% hObject    handle to textbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox3 as text
%        str2double(get(hObject,'String')) returns contents of textbox3 as a double


% --- Executes during object creation, after setting all properties.
function textbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(handles.slider1,'Value');
window = 7.5*slider_value + 15;
handles.window = window;
set(handles.textbox4,'String',window);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);    
end



function textbox4_Callback(hObject, eventdata, handles)
% hObject    handle to textbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox4 as text
%        str2double(get(hObject,'String')) returns contents of textbox4 as a double


% --- Executes during object creation, after setting all properties.
function textbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stage_on = get(hObject,'Value');
display(handles.stage_on)
   
% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
handles.stage_on = get(hObject,'Value');
display(handles.stage_on)
guidata(hObject,handles);
