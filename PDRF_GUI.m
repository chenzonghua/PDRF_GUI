function varargout = PDRF_GUI(varargin)
% PDRF_GUI MATLAB code for PDRF_GUI.fig
%      PDRF_GUI, by itself, creates a new PDRF_GUI or raises the existing
%      singleton*.
%
%      H = PDRF_GUI returns the handle to a new PDRF_GUI or the handle to
%      the existing singleton*.
%
%      PDRF_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PDRF_GUI.M with the given input arguments.
%
%      PDRF_GUI('Property','Value',...) creates a new PDRF_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PDRF_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PDRF_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PDRF_GUI

% Last Modified by GUIDE v2.5 23-Sep-2019 00:30:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PDRF_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PDRF_GUI_OutputFcn, ...
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


% --- Executes just before PDRF_GUI is made visible.
function PDRF_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PDRF_GUI (see VARARGIN)

% Choose default command line output for PDRF_GUI
handles.output = hObject;

clc;
% global s qs ms ns0 vs0x vs0y vs0z csz2 csp2 epsnx epsny rhos0 Q0 ...
%     J0x J0y J0z nu B0 c2 mu0 epsilon0 gammaTs Psz Psp ...
%     betasz betasp Deltas vA;

fieldname={'qs','ms','ns','vsx','vsy','vsz','csz','csp','epsnjx','epsnjy'};
fieldval={-1,1,4,0,0,0,0,0,0,0;
           1,4,4,0,0,0,0,0,0,0};
handles.fieldname=fieldname;
par=cell2struct(fieldval,fieldname,2);
[s, col]=size(par);
set(handles.s,'String',num2str(s));
set(handles.k,'String',0.1);
set(handles.dk,'String',0.1);
set(handles.kmin,'String',0);
set(handles.kmax,'String',10);
set(handles.theta,'String','pi/4');
set(handles.rel0,'Value',1);
set(handles.rel1,'Value',0);
set(handles.method,'Value',2);
gammaTs=0.*[par.qs]+1.0; % adiabatic coefficients, modify here for para/perp
set(handles.gamma,'UserData',gammaTs);
handles.nu=zeros(s,s);
for k=1:s
    RN{k}=['v',num2str(k),'j'];
    CN{k}=['vi',num2str(k)];
end
set(handles.uit,'RowName',RN,'ColumnName',CN);
set(handles.uit,'Units','normalized','FontSize',12,'ColumnEditable',true);
set(handles.uit,'Data',handles.nu,'Visible','Off');
str = '';
for ii = 1:s
  str = [str;sprintf('粒子种类.%2d',ii)];
end
set(handles.Nos,'String',str);
set(handles.qs,'String',num2str(par(1).qs));
set(handles.ms,'String',num2str(par(1).ms));
set(handles.ns,'String',num2str(par(1).ns));
set(handles.vsx,'String',num2str(par(1).vsx));
set(handles.vsy,'String',num2str(par(1).vsy));
set(handles.vsz,'String',num2str(par(1).vsz));
set(handles.csz,'String',num2str(par(1).csz));
set(handles.csp,'String',num2str(par(1).csp));
set(handles.epsnjx,'String',num2str(par(1).epsnjx));
set(handles.epsnjy,'String',num2str(par(1).epsnjy));

set(handles.ok,'Visible','Off');



handles.par=par;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PDRF_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PDRF_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function kmin_Callback(hObject, eventdata, handles)
% hObject    handle to kmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmin as text
%        str2double(get(hObject,'String')) returns contents of kmin as a double


% --- Executes during object creation, after setting all properties.
function kmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmax_Callback(hObject, eventdata, handles)
% hObject    handle to kmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmax as text
%        str2double(get(hObject,'String')) returns contents of kmax as a double


% --- Executes during object creation, after setting all properties.
function kmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B0_Callback(hObject, eventdata, handles)
% hObject    handle to B0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B0 as text
%        str2double(get(hObject,'String')) returns contents of B0 as a double


% --- Executes during object creation, after setting all properties.
function B0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gamma_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nu_Callback(hObject, eventdata, handles)
% hObject    handle to nu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nu as text
%        str2double(get(hObject,'String')) returns contents of nu as a double
par=handles.par;
[s,~]=size(par);
for k=1:s
    RN{k}=['v',num2str(k),'j'];
    CN{k}=['vi',num2str(k)];
end
set(handles.uit,'RowName',RN,'ColumnName',CN);
set(handles.uit,'Units','normalized','FontSize',12,'ColumnEditable',true);

set(handles.uit,'Data',handles.nu);
set(handles.uit,'Visible','On');
set(handles.ok,'Visible','On');
set(handles.uit,'ColumnEditable',true);
set(handles.paruipanel,'Visible','Off');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function nu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_Callback(hObject, eventdata, handles)
% hObject    handle to s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s as text
%        str2double(get(hObject,'String')) returns contents of s as a double
% svae previous parameters for species
par=handles.par;
nsold=length(par);
s = fix(str2double(get(handles.s,'String')));
str = '';
for ii = 1:s
    str = [str;sprintf('粒子种类.%2d',ii)];
end
set(handles.Nos,'String',str);
if s <= 0
    errordlg('输入的粒子种类不能为负数');
    return;
elseif s>0 && s<nsold
    par(s+1:nsold)=[];
elseif s == nsold
    return;
elseif s > nsold
    % create new species
    for ii = (nsold+1):s
        par(ii).qs=par(ii-1).qs;
        par(ii).ms=par(ii-1).ms;
        par(ii).ns=par(ii-1).ns;
        par(ii).vsx=par(ii-1).vsx;
        par(ii).vsy=par(ii-1).vsy;
        par(ii).vsz=par(ii-1).vsz;
        par(ii).csz=par(ii-1).csz;
        par(ii).csp=par(ii-1).csp;
        par(ii).epsnjx=par(ii-1).epsnjx;
        par(ii).epsnjy=par(ii-1).epsnjy;
    end
end
handles.par=par;
guidata(hObject, handles);
return;



% --- Executes during object creation, after setting all properties.
function s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Nos.
function Nos_Callback(hObject, eventdata, handles)
% hObject    handle to Nos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Nos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Nos
ii=get(hObject,'Value');
par=handles.par;
set(handles.qs,'String',num2str(par(ii).qs));
set(handles.ms,'String',num2str(par(ii).ms));
set(handles.ns,'String',num2str(par(ii).ns));
set(handles.vsx,'String',num2str(par(ii).vsx));
set(handles.vsy,'String',num2str(par(ii).vsy));
set(handles.vsz,'String',num2str(par(ii).vsz));
set(handles.csz,'String',num2str(par(ii).csz));
set(handles.csp,'String',num2str(par(ii).csp));
set(handles.epsnjx,'String',num2str(par(ii).epsnjx));
set(handles.epsnjy,'String',num2str(par(ii).epsnjy));

% --- Executes during object creation, after setting all properties.
function Nos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function qs_Callback(hObject, eventdata, handles)
% hObject    handle to qs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of qs as text
%        str2double(get(hObject,'String')) returns contents of qs as a double
ii=get(handles.Nos,'Value');
handles.par(ii).qs=str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function qs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to qs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ms_Callback(hObject, eventdata, handles)
% hObject    handle to ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ms as text
%        str2double(get(hObject,'String')) returns contents of ms as a double
ii=get(handles.Nos,'Value');
handles.par(ii).ms=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vsx_Callback(hObject, eventdata, handles)
% hObject    handle to vsx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vsx as text
%        str2double(get(hObject,'String')) returns contents of vsx as a double
ii=get(handles.Nos,'Value');
handles.par(ii).vsx=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function vsx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vsx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ns_Callback(hObject, eventdata, handles)
% hObject    handle to ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ns as text
%        str2double(get(hObject,'String')) returns contents of ns as a double
ii=get(handles.Nos,'Value');
handles.par(ii).ns=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vsy_Callback(hObject, eventdata, handles)
% hObject    handle to vsy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vsy as text
%        str2double(get(hObject,'String')) returns contents of vsy as a double
ii=get(handles.Nos,'Value');
handles.par(ii).vsy=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function vsy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vsy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function csz_Callback(hObject, eventdata, handles)
% hObject    handle to csz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of csz as text
%        str2double(get(hObject,'String')) returns contents of csz as a double
ii=get(handles.Nos,'Value');
handles.par(ii).csz=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function csz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to csz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vsz_Callback(hObject, eventdata, handles)
% hObject    handle to vsz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vsz as text
%        str2double(get(hObject,'String')) returns contents of vsz as a double
ii=get(handles.Nos,'Value');
handles.par(ii).vsz=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function vsz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vsz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in preview.
function preview_Callback(hObject, eventdata, handles)
% hObject    handle to preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
par=handles.par;
fieldname=handles.fieldname
[s,~]=size(par);
ss=length(fieldname);
for ii=1:ss
    CN{ii}=fieldname{ii};
end
for ii=1:s
    RN{ii}=ii;
end
set(handles.uit,'ColumnName',CN,'RowName',RN);
set(handles.uit,'Units','normalized','FontSize',12);
pData=cell2mat(struct2cell(par))

set(handles.uit,'Data',pData');
set(handles.uit,'Visible','On');
set(handles.ok,'Visible','On');
set(handles.paruipanel,'Visible','Off');


function epsnjx_Callback(hObject, eventdata, handles)
% hObject    handle to epsnjx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsnjx as text
%        str2double(get(hObject,'String')) returns contents of epsnjx as a double
ii=get(handles.Nos,'Value');
handles.par(ii).epsnjx=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function epsnjx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsnjx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epsnjy_Callback(hObject, eventdata, handles)
% hObject    handle to epsnjy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsnjy as text
%        str2double(get(hObject,'String')) returns contents of epsnjy as a double
ii=get(handles.Nos,'Value');
handles.par(ii).epsnjy=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function epsnjy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsnjy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global par
[filename, pathname] = uigetfile({'=.mat;*.m;*.dat','所有表格数据';'*.*','所有文件'}, ...
    '加载初始参数','parameters_in.mat');
if filename
    input_filename = [pathname,filename];
    load(input_filename);
else
    msgbox('您未选择初始参数文件','提示');
end
handles.par=par;
guidata(hObject, handles);
return

function setdata





% --- Executes on button press in savedata.
function savedata_Callback(hObject, eventdata, handles)
% hObject    handle to savedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile('*.mat','保存数据','par_in.mat');
filename=[path,file]
par=handles.par;
save(filename,'par','-append') 

% --- Executes on button press in parameters.
function parameters_Callback(hObject, eventdata, handles)
% hObject    handle to parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = imread('paramlist.png');
imgsize = size(img);
hfig = figure;
set(hfig,'menu','none');
% set(hfig,'WindowStyle','modal');
set(hfig,'resize','off');
scnsize = get(0,'ScreenSize');
set(hfig,'Position',[scnsize(3)*3/8 scnsize(4)/10 imgsize(2) imgsize(1)]);
himag = image(img);
set(gca,'position',[0,0,1,1]);
axis off;
drawnow
return

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global s qs ms ns0 vs0x vs0y vs0z csz2 csp2 epsnx epsny rhos0 Q0 ...
    J0x J0y J0z nu B0 c2 mu0 epsilon0 gammaTs Psz Psp ...
    betasz betasp Deltas vA;
par=handles.par;
[s, col]=size(par);
for j=1:s
    qs(j)=par(j).qs;
    ms(j)=par(j).ms;
    ns0(j)=par(j).ns;
    vs0x(j)=par(j).vsx;
    vs0y(j)=par(j).vsy;
    vs0z(j)=par(j).vsz;
    csz2(j)=(par(j).csz)^2;
    csp2(j)=(par(j).csp)^2;
    epsnx(j)=par(j).epsnjx;
    epsny(j)=par(j).epsnjy;
end

B0=str2double(get(handles.B0,'String'));
rel=str2double(get(handles.rel1,'String'));% rel=1, relativistic; else non-relativistic.
method=get(handles.method,'Value'); % 1: single k; 2: w(k); 3: w(theta); 4: w(kx,kz);
k=str2double(get(handles.k,'String'));
kmin=str2double(get(handles.kmin,'String'));
kmax=str2double(get(handles.kmax,'String'));
dk=str2double(get(handles.dk,'String'));
theta=eval(get(handles.theta,'String'));
gamma=str2double(get(handles.gamma,'String'));
gammaTs=0.*qs+gamma; % adiabatic coefficients, modify here for para/perp 
nu=handles.nu;
dtheta=pi/100;
c2=1; epsilon0=1; mu0=1/(c2*epsilon0);
for j=1:s
    qs(j)=par(j).qs;
    ms(j)=par(j).ms;
    ns0(j)=par(j).ns;
    vs0x(j)=par(j).vsx;
    vs0y(j)=par(j).vsy;
    vs0z(j)=par(j).vsz;
    csz2(j)=(par(j).csz)^2;
    csp2(j)=(par(j).csp)^2;
    epsnx(j)=par(j).epsnjx;
    epsny(j)=par(j).epsnjy;
end
rhos0=ns0.*ms;
Q0=sum(qs.*ns0);
J0x=sum(qs.*ns0.*vs0x);
J0y=sum(qs.*ns0.*vs0y);
J0z=sum(qs.*ns0.*vs0z);
if(Q0~=0)
    disp('非中性条件 !!!');
    return
end
Psz=csz2.*rhos0./gammaTs;
Psp=csp2.*rhos0./gammaTs;
if (B0~=0)
    betasz=2*mu0.*Psz./B0^2;
    betasp=2*mu0.*Psp./B0^2;
    vA=B0./sqrt(mu0.*rhos0); %
    Deltas=-(Psp-Psz)/B0;
else
    Deltas=0.*qs;
end
if (method>=2)
    h=figure('unit','normalized','Position',[0.01 0.27 0.6 0.5]);
    set(gcf,'DefaultAxesFontSize',15);
end
if(method==2)
    kk=kmin:dk:kmax;
    nk=length(kk);
    ww=zeros(nk,4*s+6); ww1=ww; ww2=ww;
    for ik=1:nk
        kx=kk(ik)*sin(theta);
        kz=kk(ik)*cos(theta);
        [M,A,w1,w2]=pdrfsolver(kx,kz,rel);
        ww1(ik,:)=w1;
        ww2(ik,:)=w2;
    end
    ns=2*s+1;
    %         ns=4*s+6;
    for is=1:ns
        clr=colormap(lines);
        clr=clr(floor(is/ns*length(clr)),:);
        subplot(121);
        plot(kk,real(ww1(:,is)),'Color',clr,'LineWidth',2);
        hold on; xlabel('kc/\omega_{ce}'); ylabel('\omega_r/\omega_{ce}');
        title(['(a) \omega_r vs k, \theta=',...
            num2str(theta*180/pi),'^{\circ}']);
        subplot(122);
        plot(kk,imag(ww2(:,is)),'.','Color',clr,'LineWidth',2);
        hold on; xlabel('kc/\omega_{ce}'); ylabel('\omega_i/\omega_{ce}');
        title(['(b) \omega_i vs k, m_i/m_e=',num2str(ms(2)/ms(1))]);
    end
elseif(method==3)
    tt=0:dtheta:pi/2;
    nt=length(tt);
    ww=zeros(nt,4*s+6); ww1=ww; ww2=ww;
    for it=1:nt
        kx=k*sin(tt(it));
        kz=k*cos(tt(it));
        [M,A,w1,w2]=pdrfsolver(kx,kz,rel);
        ww1(it,:)=w1;
        ww2(it,:)=w2;
    end
    ns=2*s+1;
    for is=1:ns
        clr=colormap(lines);
        clr=clr(floor(is/ns*length(clr)),:);
        subplot(121);
        plot(tt,real(ww1(:,is)),'Color',clr,'LineWidth',2);
        hold on; xlabel('\theta'); ylabel('\omega_r/\omega_{ce}');
        title(['(c) \omega_r vs \theta, kc/\omega_{ce}=',num2str(k)]);
        xlim([min(tt),max(tt)]);
        subplot(122);
        plot(tt,imag(ww2(:,is)),'.','Color',clr,'LineWidth',2);
        hold on; xlabel('\theta'); ylabel('\omega_i/\omega_{ce}');
        xlim([min(tt),max(tt)]);
        title('(d) \omega_i vs \theta');
    end
elseif(method==4)
    [kkx,kkz]=meshgrid(0.01:0.4*dk:0.3*kmax,0.01:0.4*dk:0.2*kmax);
    [row,col]=size(kkx);
    ww=zeros(row,col,4*s+6);
    ww1=ww;
    ww2=ww;
    for ir=1:row
        for ic=1:col
            kx=kkx(ir,ic);
            kz=kkz(ir,ic);
            [M,A,w1,w2]=pdrfsolver(kx,kz,rel);
            ww1(ir,ic,:)=w1;
            ww2(ir,ic,:)=w2;
        end
    end
    ns=4*s+6;
    subplot(121);
    for is=1:ns
        surf(kkx,kkz,real(ww1(:,:,is))); hold on;
    end
    xlabel('k_xc/\omega_{ce}'); ylabel('k_zc/\omega_{ce}');
    zlabel('\omega_r/\omega_{ce}');
    subplot(122);
    for is=1:ns
        surf(kkx,kkz,imag(ww2(:,:,is))); hold on;
    end
    xlabel('k_xc/\omega_{ce}'); ylabel('k_zc/\omega_{ce}');
    zlabel('\omega_i/\omega_{ce}');
else % single k, note: k can also be complex number
    kx=k*sin(theta); kz=k*cos(theta);
    %         kx=0.2; kz=0.01;
    [M,A,w1,w2]=pdrfsolver(kx,kz,rel);
    w=w1  % output
end


function [M,A,w1,w2,X1,X2]=pdrfsolver(kx,kz,rel)
% main solver of pdrf, call as
%  (1). [M,A,w1,w2,X1,X2]=pdrfsolver(kx,kz,rel)
%          for both eigenvalues and polarizations
%  (2). [M,A,w1,w2]=pdrfsolver(kx,kz,rel)
%          for just eigenvalues
% (1) requires more run time than (2)

global s qs ms ns0 vs0x vs0y vs0z csz2 csp2 epsnx epsny rhos0 Q0 ...
    J0x J0y J0z nu B0 c2 mu0 epsilon0 gammaTs Psz Psp ...
    betasz betasp Deltas vA;

% eigen matrix
M=zeros(4*s+6,4*s+6);
A=eye(4*s+6,4*s+6);

wcs=qs.*B0./ms;
ind2=4*s;
for j=1:s
    ind=(j-1)*4;
    
    % dn~n
    M(1+ind,1+ind)=-1i*(kx*vs0x(j)+kz*vs0z(j));
    % dn~v
    M(1+ind,2+ind)=-1i*kx*ns0(j)-epsnx(j)*ns0(j);
    M(1+ind,3+ind)=-epsny(j)*ns0(j);
    M(1+ind,4+ind)=-1i*kz*ns0(j);
    
    ajpq=eye(3); % ajpq for A
    if(rel==1)
        vj0=sqrt(vs0x(j)^2+vs0y(j)^2+vs0z(j)^2);
        gammaj0=1/sqrt(1-vj0^2/c2);
        ajpq(1,1)=gammaj0+gammaj0^3*vs0x(j)^2/c2;
        ajpq(1,2)=gammaj0^3*vs0x(j)*vs0y(j)/c2;
        ajpq(1,3)=gammaj0^3*vs0x(j)*vs0z(j)/c2;
        ajpq(2,1)=gammaj0^3*vs0x(j)*vs0y(j)/c2;
        ajpq(2,2)=gammaj0+gammaj0^3*vs0y(j)^2/c2;
        ajpq(2,3)=gammaj0^3*vs0y(j)*vs0z(j)/c2;
        ajpq(3,1)=gammaj0^3*vs0x(j)*vs0z(j)/c2;
        ajpq(3,2)=gammaj0^3*vs0z(j)*vs0y(j)/c2;
        ajpq(3,3)=gammaj0+gammaj0^3*vs0z(j)^2/c2;
    end
    A((2:4)+ind,(2:4)+ind)=ajpq;
    
    bjpq=-1i*(kx*vs0x(j)+kz*vs0z(j)).*ajpq; % bjpq for M, nu(j,j) below
    M((2:4)+ind,(2:4)+ind)=bjpq;
    
    % dv ~ n & v
    %         M(2+ind,1+ind)=-1i*kx*csp2(j)/rhos0(j); % wrong
    %         M(4+ind,1+ind)=-1i*kz*csz2(j)/rhos0(j);
    M(2+ind,1+ind)=-1i*kx*csp2(j)/ns0(j); % 16-04-13 12:34, bug fixed
    M(4+ind,1+ind)=-1i*kz*csz2(j)/ns0(j);
    
    M(2+ind,3+ind)=M(2+ind,3+ind)+wcs(j);
    M(3+ind,2+ind)=M(3+ind,2+ind)-wcs(j);
    
    % dv~E
    M(2+ind,1+ind2)=qs(j)/ms(j);
    M(3+ind,2+ind2)=qs(j)/ms(j);
    M(4+ind,3+ind2)=qs(j)/ms(j);
    % dv~B
    M(2+ind,5+ind2)=-qs(j)/ms(j)*vs0z(j);
    M(2+ind,6+ind2)=qs(j)/ms(j)*vs0y(j);
    M(3+ind,4+ind2)=qs(j)/ms(j)*vs0z(j);
    M(3+ind,6+ind2)=-qs(j)/ms(j)*vs0x(j);
    M(4+ind,4+ind2)=-qs(j)/ms(j)*vs0y(j);
    M(4+ind,5+ind2)=qs(j)/ms(j)*vs0x(j);
    
    M(2+ind,4+ind2)=-1i*kz*Deltas(j)/rhos0(j);
    M(3+ind,5+ind2)=-1i*kz*Deltas(j)/rhos0(j);
    %         M(4+ind,4+ind2)=M(4+ind,4+ind2)-...
    %             1i*kx*1*Deltas(j)/rhos0(j); % without factor "2" correction
    M(4+ind,4+ind2)=M(4+ind,4+ind2)-...
        1i*kx*2*Deltas(j)/rhos0(j); % with "2" correction, mirror mode
    
    % dE~n
    M(1+ind2,1+ind)=-qs(j)*vs0x(j)/epsilon0;
    M(2+ind2,1+ind)=-qs(j)*vs0y(j)/epsilon0;
    M(3+ind2,1+ind)=-qs(j)*vs0z(j)/epsilon0;
    
    % dE~v
    M(1+ind2,2+ind)=-qs(j)*ns0(j)/epsilon0;
    M(2+ind2,3+ind)=-qs(j)*ns0(j)/epsilon0;
    M(3+ind2,4+ind)=-qs(j)*ns0(j)/epsilon0;
    
end

% dE~B
M(1+ind2,5+ind2)=-1i*kz*c2;
M(2+ind2,4+ind2)=1i*kz*c2;
M(2+ind2,6+ind2)=-1i*kx*c2;
M(3+ind2,5+ind2)=1i*kx*c2;

% dB~E
M(4+ind2,2+ind2)=1i*kz;
M(5+ind2,1+ind2)=-1i*kz;
M(5+ind2,3+ind2)=1i*kx;
M(6+ind2,2+ind2)=-1i*kx;

% set collision nu(i,j) terms to M
for i=1:s
    for j=1:s
        col=(i-1)*4;
        row=(j-1)*4;
        M(2+row,2+col)=M(2+row,2+col)+nu(i,j);
        M(3+row,3+col)=M(3+row,3+col)+nu(i,j);
        M(4+row,4+col)=M(4+row,4+col)+nu(i,j);
    end
end

% solution
oldmethod=2; % default oldmethod=2, less roundoff error
% oldmethod=1; faster, but may less accurate
if(nargout==6) % give also eigenvector, for polarizations
    if(oldmethod==1)
        [V,D]=eig(M,A);
        d=diag(D);
    else % to keep all eigenvalue be accurate to digits(n)
        MA=A\M;
        [V0,D0]=eig(vpa(MA,16));  % sym format calculation, less roundoff error
        V=double(V0); d0=diag(D0);
        d=double(d0); % convert sym format to double
    end
else
    if(oldmethod==1)
        d=eig(M,A); % eigenvalue, i.e., dispersion relation solutions
    else % better for max(M_ij)/min(M_ij)>10^16,  16-04-12 20:41
        % to keep all eigenvalue be accurate to digits(n)
        MA=A\M; % A^{-1}*M, i.e., M*X=lambda*A*X -> A^{-1}*M*X=lambda*X
        d0=vpa(eig(MA),16);  % sym format calculation, less roundoff error
        %             d0=eig(vpa(MA,16)); % seems slow
        d=double(d0); % convert sym format to double
    end
end

wtmp=1i*d;
[wr,inw1]=sort(real(wtmp),'descend');
[wi,inw2]=sort(imag(wtmp),'descend');
w1=wtmp(inw1); % sort by real part
w2=wtmp(inw2); % sort by imag part

if(nargout==6)
    X1=V(:,inw1); % sort by real part
    X2=V(:,inw2); % sort by imag part
end
return




% --- Executes on button press in rel0.
function rel0_Callback(hObject, eventdata, handles)
% hObject    handle to rel0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rel0


% --- Executes on button press in rel1.
function rel1_Callback(hObject, eventdata, handles)
% hObject    handle to rel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rel1



function dk_Callback(hObject, eventdata, handles)
% hObject    handle to dk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dk as text
%        str2double(get(hObject,'String')) returns contents of dk as a double


% --- Executes during object creation, after setting all properties.
function dk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_Callback(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k as text
%        str2double(get(hObject,'String')) returns contents of k as a double


% --- Executes during object creation, after setting all properties.
function k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2



function theta_Callback(hObject, eventdata, handles)
% hObject    handle to theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta as text
%        str2double(get(hObject,'String')) returns contents of theta as a double


% --- Executes during object creation, after setting all properties.
function theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function csp_Callback(hObject, eventdata, handles)
% hObject    handle to csp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of csp as text
%        str2double(get(hObject,'String')) returns contents of csp as a double
ii=get(handles.Nos,'Value');
handles.par(ii).csp=str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function csp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to csp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
delete(gcf)
return;

% --- Executes on button press in about.
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = imread('about.png');
imgsize = size(img);
hfig = figure;
set(hfig,'menu','none');
% set(hfig,'WindowStyle','modal');
set(hfig,'resize','off');
scnsize = get(0,'ScreenSize');
set(hfig,'Position',[scnsize(3)*3/8 scnsize(4)/8 imgsize(2) imgsize(1)]);
himag = image(img);
set(gca,'position',[0,0,1,1]);
axis off;
drawnow
return


% --- Executes when selected cell(s) is changed in uit.
function uit_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f1=get(handles.uit,'ColumnName')';
f2=handles.fieldname;
if ~strcmp(f1{1,1},f2{1,1})
    nu=get(handles.uit,'Data');    
    nu=(nu+nu')/2;% 输入的矩阵关于对角线对称，如果不关于对角线对称，则取两边的平均值
    handles.nu=nu;
end
set(handles.uit,'Visible','Off');
set(handles.ok,'Visible','Off');
set(handles.paruipanel,'Visible','On');
guidata(hObject,handles);
