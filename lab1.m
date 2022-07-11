function varargout = lab1(varargin)
% LAB1 MATLAB code for lab1.fig
%      LAB1, by itself, creates a new LAB1 or raises the existing
%      singleton*.
%
%      H = LAB1 returns the handle to a new LAB1 or the handle to
%      the existing singleton*.
%
%      LAB1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB1.M with the given input arguments.
%
%      LAB1('Property','Value',...) creates a new LAB1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab1

% Last Modified by GUIDE v2.5 02-Sep-2017 10:57:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab1_OpeningFcn, ...
                   'gui_OutputFcn',  @lab1_OutputFcn, ...
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


% --- Executes just before lab1 is made visible.
function lab1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab1 (see VARARGIN)

% Choose default command line output for lab1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function out = heaviside(in)
if in > 0
   out = 1;
elseif in < 0
   out = 0;
else
   out = 0.5;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles) %#ok<*INUSL,*DEFNU>
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
KP=str2double(get(handles.PeriodsNumber,'string'));
pointsCount = str2double(get(handles.NumberOfPoints,'string'));
noise_size = str2double(get(handles.NoiseSKO,'string'));
noise = zeros(pointsCount);
noiseType = get(handles.NoiseType,'Value');
switch noiseType
case 1 % None
   noise = zeros(pointsCount);
case 2 % Gaus
   noise=wgn(pointsCount,1,0);
case 3 % Normal
   noise=randn(pointsCount);
end

values = zeros(pointsCount);
amplitude=str2double(get(handles.SignalAmplitude,'string'));
switch get(handles.SignalType,'Value')
    case 1 % Sin
        for i=1:pointsCount
            values(i) = sin(2*pi*i*KP./pointsCount)*amplitude;
        end
    case 2 % Cos
        for i=1:pointsCount
            values(i) = cos(2*pi*i*KP./pointsCount)*amplitude;
        end
    case 3 % Saw
        for i=1:pointsCount
            values(i) = sawtooth(2*pi*i*KP./pointsCount)*amplitude;
        end
    case 4 % Tri
        for i=1:pointsCount
            t = sin(pi*i*KP./pointsCount - pi/2)*1.5
            values(i) = tripuls(t) * amplitude;
            %values(i) = tripuls(2*pi*i*KP./pointsCount)*amplitude;
        end
    case 5 % Rec
        for i=1:pointsCount
            % t = sin(pi*i*KP./pointsCount - pi/2)*1.5
            % values(i) = (heaviside(t + 0.5) - heaviside(t - 0.5)) * amplitude;
            values(i) = square(2*pi*i*KP./pointsCount)*amplitude;
        end
end

if noiseType > 1
    for i=1:pointsCount
       values(i)=values(i)+noise(i)*noise_size;
    end
end

i=1:pointsCount;
plot(i,values);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)  %#ok<*INUSD>
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose('all');
close('all');

function PeriodsNumber_Callback(hObject, eventdata, handles)
% hObject    handle to PeriodsNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PeriodsNumber as text
%        str2double(get(hObject,'String')) returns contents of PeriodsNumber as a double


% --- Executes during object creation, after setting all properties.
function PeriodsNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PeriodsNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in NoiseType.
function NoiseType_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns NoiseType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from NoiseType


% --- Executes during object creation, after setting all properties.
function NoiseType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumberOfPoints_Callback(hObject, eventdata, handles)
% hObject    handle to NumberOfPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberOfPoints as text
%        str2double(get(hObject,'String')) returns contents of NumberOfPoints as a double


% --- Executes during object creation, after setting all properties.
function NumberOfPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberOfPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SignalType.
function SignalType_Callback(hObject, eventdata, handles)
% hObject    handle to SignalType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SignalType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SignalType


% --- Executes during object creation, after setting all properties.
function SignalType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SignalType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SignalAmplitude_Callback(hObject, eventdata, handles)
% hObject    handle to SignalAmplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SignalAmplitude as text
%        str2double(get(hObject,'String')) returns contents of SignalAmplitude as a double


% --- Executes during object creation, after setting all properties.
function SignalAmplitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SignalAmplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoiseSKO_Callback(hObject, eventdata, handles)
% hObject    handle to NoiseSKO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoiseSKO as text
%        str2double(get(hObject,'String')) returns contents of NoiseSKO as a double


% --- Executes during object creation, after setting all properties.
function NoiseSKO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoiseSKO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
