function varargout = result(varargin)
% RESULT M-file for result.fig
%      RESULT, by itself, creates a new RESULT or raises the existing
%      singleton*.
%
%      H = RESULT returns the handle to a new RESULT or the handle to
%      the existing singleton*.
%
%      RESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULT.M with the given input arguments.
%
%      RESULT('Property','Value',...) creates a new RESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before result_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to result_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help result

% Last Modified by GUIDE v2.5 10-Oct-2017 17:02:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @result_OpeningFcn, ...
                   'gui_OutputFcn',  @result_OutputFcn, ...
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


% --- Executes just before result is made visible.
function result_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to result (see VARARGIN)

global filename
global param
global pathname
global seismic_file
addpath(genpath(pwd))
addpath(pathname)
disp(pathname)
seismic_file=[pathname,filename];
disp(seismic_file)
if strcmp(seismic_file((length(seismic_file)-2):(length(seismic_file))),'sgy')==1 || ...
     strcmp(seismic_file((length(seismic_file)-3):(length(seismic_file))),'segy')==1; 
 [seismic,text_header,binary_header]=read_segy_file(seismic_file);
  Data=seismic.traces; 
 elseif strcmp(seismic_file((length(seismic_file)-2):(length(seismic_file))),'sg2')==1
      Data=seg2read(seismic_file);
 elseif strcmp(seismic_file((length(seismic_file)-3):(length(seismic_file))),'seg2')==1; 
     Data_=Seg2FileReader(seismic_file);
     Data=readTraceData(Data_);
end
 
dt=param(3,1);   % Sampling Periode (s)
%Geometry
x0=param(1,1);      % distance first geophone - source (m)
dx=param(2,1);       % distance between geophones (m)
miring=0;   % 0 untuk miring kanan
         % 1 untuk miring kiri
fmin=param(1,2);     % min frequency (Hz) 
fmax=param(2,2);    % max frequency (Hz)
vrmin=param(3,2);    % min Vs (m/s) 
vrmax=param(4,2); % max Vs  (m/s) 
incv=param(5,2);     % Vs increment (m/s)
disp(x0);disp(dx);disp(dt);
[Data, ff, vr, plt] = psm(seismic_file, x0, dx, dt, fmin, fmax, vrmin, vrmax, incv);
axes(handles.axes1);
wiggle(Data);
set(gca,'xtick',[1:length(Data(1,:))]); 
set(gca,'FontSize',12,'FontName','Times');
ylabel('Time (ms)','FontSize',12,'FontName','Times'); 
xlabel('Geophone Number','FontSize',12,'FontName','Times'); 
title('TRACE','FontSize',12,'FontName','Times');
axes(handles.axes3);
h=pcolor(ff,vr,abs(plt));
set(h, 'EdgeColor', 'none');
set(gca,'FontSize',12,'FontName','Times'); 
xlabel('Frequency (Hz.)','FontSize',12,'FontName','Times'); 
ylabel('Phase Velocity (m/s)','FontSize',12,'FontName','Times');  
title('DISPERSION CURVE','FontSize',12,'FontName','Times');
ylim([vrmin vrmax]) 
% Choose default command line output for result
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes result wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = result_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in picking.
function picking_Callback(hObject, eventdata, handles)
% hObject    handle to picking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global kurva
global plt
hold on
kurva=[];
axes(handles.axes3);
[x, y] = getpts(handles.axes3);
kurva=[x y];
plt=plot(x,y,'linewidth',4);


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)\
global kurva
global filename

if strcmp(filename((length(filename)-2):(length(filename))),'sgy')==1 || ...
     strcmp(filename((length(filename)-2):(length(filename))),'sg2')==1; 
dlmwrite([filename(1:length(filename)-4),'_dispersion.txt'],...
    kurva,'precision', '%.5f', 'delimiter', '\t','newline','pc');
elseif strcmp(filename((length(filename)-3):(length(filename))),'segy')==1 || ...
     strcmp(filename((length(filename)-3):(length(filename))),'seg2')==1; 
dlmwrite([filename(1:length(filename)-5),'_dispersion.txt'],...
    kurva,'precision', '%.5f', 'delimiter', '\t','newline','pc');
end


% --- Executes on button press in close_all.
function close_all_Callback(hObject, eventdata, handles)
% hObject    handle to close_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
clear all


% --- Executes on button press in clear_pick.
function clear_pick_Callback(hObject, eventdata, handles)
% hObject    handle to clear_pick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global plt
global kurva
kurva=[];
if exist('plt')==1
    delete(plt)
end
