function varargout = phase_shift(varargin)
% PHASE_SHIFT M-file for phase_shift.fig
%      PHASE_SHIFT, by itself, creates a new PHASE_SHIFT or raises the existing
%      singleton*.
%
%      H = PHASE_SHIFT returns the handle to a new PHASE_SHIFT or the handle to
%      the existing singleton*.
%
%      PHASE_SHIFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHASE_SHIFT.M with the given input arguments.
%
%      PHASE_SHIFT('Property','Value',...) creates a new PHASE_SHIFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before phase_shift_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to phase_shift_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help phase_shift

% Last Modified by GUIDE v2.5 10-Oct-2017 14:08:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @phase_shift_OpeningFcn, ...
                   'gui_OutputFcn',  @phase_shift_OutputFcn, ...
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


% --- Executes just before phase_shift is made visible.
function phase_shift_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to phase_shift (see VARARGIN)
clc
addpath(genpath(pwd))
image(imread('geometry.png','backgroundcolor','none'))
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
%set(gca,'box','off')
set(gca,'Visible','off')
% Choose default command line output for phase_shift
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes phase_shift wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = phase_shift_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
about


% --- Executes on button press in open_data.
function open_data_Callback(hObject, eventdata, handles)
% hObject    handle to open_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pathname
global filename
[filename, pathname] = uigetfile({'*.sgy;*.sg2;*.segy;*.seg2',...
 'SEISMIC Files (*.sgy,*.sg2,*.segy,*.seg2)'}, 'Select a MSAW file');
if isequal(filename,0)
   disp('User selected Cancel')
else
    if strcmp(filename((length(filename)-3):(length(filename))),'seg2')==1; 
     Data_=Seg2FileReader(filename);
     for i = 1:Data_.NumberOfTraces
         disp(['TRACE - ' num2str(i)]);
         deskripsi=Data_.TraceDescription(1,i).RawTextBlock;
         disp(deskripsi)
         disp('----------------------------------------------');
         %keterangan=strsplit(deskripsi);
         %ket(i,1)=keterangan(1,5);
         %ket(i,2)=keterangan(1,11);
         %ket(i,3)=keterangan(1,15);
     end
    end
    set(handles.nama_file,'String',filename)
    %x0_val=str2double(ket(1,3))-str2double(ket(1,2));
    %dx_val=str2double(ket(2,3))-str2double(ket(1,3));
    %dt_val=str2double(ket(1,1));
    %set(handles.x0,'String',num2str(x0_val))
    %set(handles.dx,'String',num2str(dx_val))
    %set(handles.dt,'String',num2str(dt_val))
end


function dx_Callback(hObject, eventdata, handles)
% hObject    handle to dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
dx=(str2double(get(hObject,'String')));
param(2,1) = dx;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of dx as text
%        str2double(get(hObject,'String')) returns contents of dx as a double


% --- Executes during object creation, after setting all properties.
function dx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dt_Callback(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
dt=(str2double(get(hObject,'String')));
param(3,1) = dt;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of dt as text
%        str2double(get(hObject,'String')) returns contents of dt as a double


% --- Executes during object creation, after setting all properties.
function dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0_Callback(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
x0=(str2double(get(hObject,'String')));
param(1,1) = x0;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of x0 as text
%        str2double(get(hObject,'String')) returns contents of x0 as a double

% --- Executes during object creation, after setting all properties.
function x0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when panel_dispersion is resized.
function panel_dispersion_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to panel_dispersion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function fmin_Callback(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
fmin=(str2double(get(hObject,'String')));
param(1,2) = fmin;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of fmin as text
%        str2double(get(hObject,'String')) returns contents of fmin as a double


% --- Executes during object creation, after setting all properties.
function fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmax_Callback(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
fmax=(str2double(get(hObject,'String')));
param(2,2) = fmax;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of fmax as text
%        str2double(get(hObject,'String')) returns contents of fmax as a double


% --- Executes during object creation, after setting all properties.
function fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vrmin_Callback(hObject, eventdata, handles)
% hObject    handle to vrmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
vrmin=(str2double(get(hObject,'String')));
param(3,2) = vrmin;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of vrmin as text
%        str2double(get(hObject,'String')) returns contents of vrmin as a double


% --- Executes during object creation, after setting all properties.
function vrmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vrmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vrmax_Callback(hObject, eventdata, handles)
% hObject    handle to vrmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
vrmax=(str2double(get(hObject,'String')));
param(4,2) = vrmax;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of vrmax as text
%        str2double(get(hObject,'String')) returns contents of vrmax as a double


% --- Executes during object creation, after setting all properties.
function vrmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vrmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function nama_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nama_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function big_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to big_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



function inc_Callback(hObject, eventdata, handles)
% hObject    handle to inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
vrmax=(str2double(get(hObject,'String')));
param(5,2) = vrmax;
% save the string data to file
global filename
if isempty(filename)==1;
    disp('OPEN FILE FIRST')
end
% Hints: get(hObject,'String') returns contents of inc as text
%        str2double(get(hObject,'String')) returns contents of inc as a double


% --- Executes during object creation, after setting all properties.
function inc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in export_parameter.
function export_parameter_Callback(hObject, eventdata, handles)
% hObject    handle to export_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
%[filename, pathname] = uiputfile('param.mat', 'Export Parameter');
uisave('param','parameter.mat');


% --- Executes on button press in import_parameter.
function import_parameter_Callback(hObject, eventdata, handles)
% hObject    handle to import_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global param
[fileparam, pathparam] = uigetfile('*.mat', 'Select Parameter');
if isequal(fileparam,0)
    disp('User selected Cancel')
else
    disp('Parameter Imported')
    param=importdata(fileparam);
    set(handles.x0,'String',param(1,1))
    set(handles.dx,'String',param(2,1))
    set(handles.dt,'String',param(3,1))
    set(handles.fmin,'String',param(1,2))
    set(handles.fmax,'String',param(2,2))
    set(handles.vrmin,'String',param(3,2))
    set(handles.vrmax,'String',param(4,2))
    set(handles.inc,'String',param(5,2))
end
