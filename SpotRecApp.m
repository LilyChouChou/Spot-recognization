 function varargout = figure_pjimage(varargin)
% figure_pjimage MATLAB code for figure_pjimage.fig
%      figure_pjimage, by itself, creates a new figure_pjimage or raises the existing
%      singleton*.
%
%      H = figure_pjimage returns the handle to a new figure_pjimage or the handle to
%      the existing singleton*.
%
%      figure_pjimage('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in figure_pjimage.M with the given input arguments.
%
%      figure_pjimage('Property','Value',...) creates a new figure_pjimage or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before figure_pjimage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to figure_pjimage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figure_pjimage

% Last Modified by GUIDE v2.5 07-Aug-2017 14:35:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @figure_pjimage_OpeningFcn, ...
                   'gui_OutputFcn',  @figure_pjimage_OutputFcn, ...
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
pji

% --- Executes just before figure_pjimage is made visible.
function figure_pjimage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figure_pjimage (see VARARGIN)

% Choose default command line output for figure_pjimage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
setappdata(handles.figure_pjimage,'img_src',0);  

% UIWAIT makes figure_pjimage wait for user response (see UIRESUME)
% uiwait(handles.figure_pjimage);


% --- Outputs from this function are returned to the command line.
function varargout = figure_pjimage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_open_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile( ...  
{'*.bmp;*.jpg;*.png;*.jpeg', 'Image Files (*.bmp, *.jpg, *.png, *.jpeg)'; ...  
'*.*', 'All Files (*.*)'}, ...  
'Pick an image');
axes(handles.axes_src);%用axes命令设定当前操作的坐标轴是axes_src  
fpath=[pathname filename];%将文件名和目录名组合成一个完整的路径  
img_src=imread(fpath);
imshow(img_src);  %用imread读入图片，并用imshow在axes_src上显示
setappdata(handles.figure_pjimage,'img_src',img_src);  
% hObject    handle to m_file_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_file_save_Callback(hObject, eventdata, handles)
[filename, pathname] = uiputfile({'*.bmp','BMP files';'*.jpg;','JPG files'}, 'Pick an Image');  
if isequal(filename,0) || isequal(pathname,0)  
return;%如果点了“取消”  
else  
fpath=fullfile(pathname, filename);%获得全路径的另一种方法  
end  
img_src=getappdata(handles.figure_pjimage,'img_src');%取得打开图  片的数据  
imwrite(img_src,fpath);%保存图片  
% hObject    handle to m_file_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function m_file_run_Callback(hObject, eventdata, handles)
axes(handles.axes_dst)
img_src=getappdata(handles.figure_pjimage,'img_src');
run(img_src);


% --- Executes on selection change in numcraters.
function numcraters_Callback(hObject, eventdata, handles)
% hObject    handle to numcraters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns numcraters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from numcraters


% --- Executes during object creation, after setting all properties.
function numcraters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numcraters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
