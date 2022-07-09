function varargout = B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC(varargin)
%
% This gui demonstrates the conversion from particle velocity to strain rate
%
%
% ***********************************************************************************************************
% MIT License
% 
% Copyright (c) 2022 Mark E. Willis
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% ***********************************************************************************************************

% B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC MATLAB code for B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC.fig
%      B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC, by itself, creates a new B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC or raises the existing
%      singleton*.
%
%      H = B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC returns the handle to a new B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC or the handle to
%      the existing singleton*.
%
%      B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC.M with the given input arguments.
%
%      B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC('Property','Value',...) creates a new B_VZ_TO_STRAIN_RATE_MARKEWILLIS_SEG_DISC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC

% Last Modified by GUIDE v2.5 09-Jul-2022 16:29:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC_OpeningFcn, ...
                   'gui_OutputFcn',  @B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC_OutputFcn, ...
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


% --- Executes just before B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC is made visible.
function B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC (see VARARGIN)

% Choose default command line output for B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global SRfromVzparams

SRfromVzparams.f0       = 70;
SRfromVzparams.gl       = 15;
SRfromVzparams.velocity = 2000;


% --- Outputs from this function are returned to the command line.
function varargout = B_Vz_to_Strain_Rate_MarkEWillis_SEG_DISC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_run.
function pushbutton_run_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global SRfromVzparams

model.velocity = SRfromVzparams.velocity;
model.z0       = SRfromVzparams.velocity;
model.f0       = SRfromVzparams.f0;
model.GL       = SRfromVzparams.gl;

model.dt       = 0.0001;
model.nsamples = 20000;
model.time     = (1:model.nsamples)*model.dt;
model.amps     = 1;

sim          = createSimulations(model);

lw = 2;

period = 1.0/SRfromVzparams.f0 * 2;
trange = [-1 1]*period + 1.;

% plot out the strain rate data
plot(handles.axes_input,sim.time,sim.Vz,'k','linewidth',lw)
title('Strain Rate (5m)','fontsize',16,'fontweight','bold')
set(handles.axes_input,'fontsize',16,'fontweight','bold')
xlim(handles.axes_input,trange)
xlabel(handles.axes_input,'Time (s)')
title(handles.axes_input,'Particle Velocity','fontsize',16,'fontweight','bold')
maxV = max(abs(sim.Vz));
ylim(handles.axes_input,[-1 1]*maxV)


plot(handles.axes_output,sim.time,sim.strainRate,'k','linewidth',lw)
title(handles.axes_output,'Strain Rate','fontsize',16,'fontweight','bold')
set(handles.axes_output,'fontsize',16,'fontweight','bold')
xlim(handles.axes_output,trange)
xlabel(handles.axes_output,'Time (s)')
maxV = max(abs(sim.strainRate));
ylim(handles.axes_output,[-1 1]*maxV)


function edit_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_velocity as a double

global SRfromVzparams

value = str2double(get(hObject,'String'));

if isnan(value) || value < 100 || value > 50000
    % not a number or out of range return to default value
    set(hObject,'String',num2str(SRfromVzparams.velocity))
    return
end

SRfromVzparams.velocity = value;

% --- Executes during object creation, after setting all properties.
function edit_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f0 as text
%        str2double(get(hObject,'String')) returns contents of edit_f0 as a double

global SRfromVzparams

value = str2double(get(hObject,'String'));

if isnan(value) || value < .01 || value > 500
    % not a number or out of range return to default value
    set(hObject,'String',num2str(SRfromVzparams.f0))
    return
end

SRfromVzparams.f0 = value;

% --- Executes during object creation, after setting all properties.
function edit_f0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gl as text
%        str2double(get(hObject,'String')) returns contents of edit_gl as a double

global SRfromVzparams

value = str2double(get(hObject,'String'));

if isnan(value) || value < .01 || value > 500
    % not a number or out of range return to default value
    set(hObject,'String',num2str(SRfromVzparams.gl))
    return
end

SRfromVzparams.gl = value;

% --- Executes during object creation, after setting all properties.
function edit_gl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
