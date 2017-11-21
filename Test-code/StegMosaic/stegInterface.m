function varargout = stegInterface(varargin)
% STEGINTERFACE MATLAB code for stegInterface.fig
%      STEGINTERFACE, by itself, creates a new STEGINTERFACE or raises the existing
%      singleton*.
%
%      H = STEGINTERFACE returns the handle to a new STEGINTERFACE or the handle to
%      the existing singleton*.
%
%      STEGINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGINTERFACE.M with the given input arguments.
%
%      STEGINTERFACE('Property','Value',...) creates a new STEGINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stegInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stegInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stegInterface

% Last Modified by GUIDE v2.5 04-Dec-2016 15:01:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stegInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @stegInterface_OutputFcn, ...
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
% End initialization code - D\O NOT EDIT


% --- Executes just before stegInterface is made visible.
function stegInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stegInterface (see VARARGIN)

% Choose default command line output for stegInterface
handles.output = hObject;

axes(handles.axes5)
BackGr = imread('bg6.jpg');
  imshow(BackGr);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stegInterface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stegInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global secret
X = uigetfile('*.jpg;*.tiff;*.ppm;*.pgm;*.png');
secret = imread(X);
  axes(handles.axes1)
  imshow(secret);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cover;
X = uigetfile('*.jpg;*.tiff;*.ppm;*.pgm;*.png');
cover = imread(X);
  axes(handles.axes2)
  imshow(cover);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s_index;
global t_index;
global list_1;
global list_2;
global subimg_size;
global img_size;
global result;
global output;
global secret;
global cover;
img_size = [512,512];
subimg_size = 64;
% set(handles.text2, 'String', 'Hiding Image...');
list_1 = split(secret, subimg_size);
list_2 = split(cover, subimg_size);
[s_list, s_index] = img_sort(list_1);
[t_list, t_index] = img_sort(list_2);
[list, output] = color_transfer(s_index, t_index, list_1, list_2, img_size, subimg_size );
result = substitute(t_index, subimg_size, list);
%set(handles.text2, 'String', 'Image Hiding Process Complete!!');
dispMsg = msgbox('Image Hiding Process Complete!!','Success','modal');
% set(dispMsg, 'position', [100 300 400 120]);
% ah = get( dispMsg, 'CurrentAxes' );
% ch = get( ah, 'Children' );
% set( ch, 'FontSize', 15 );    
uiwait(dispMsg);
axes(handles.axes3);
imshow(result);
imwrite(result, 'Steg.jpg','jpg');
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s_index;
global subimg_size;
global result;
global output;
%set(handles.text2, 'String', 'Recovering Image...');
info = info_extract( result,subimg_size,output );
recover_list = color_retrans( info,result,subimg_size );
recovery( result,subimg_size,recover_list,s_index );
%set(handles.text2, 'String', 'Recovery of Hidden Image Complete!!');
dispMsg = msgbox('Recovery of Hidden Image Complete!!','Success','modal');
% set(dispMsg, 'position', [100 300 400 120]);
% ah = get( dispMsg, 'CurrentAxes' );
% ch = get( ah, 'Children' );
% set( ch, 'FontSize', 15 );
uiwait(dispMsg);
recover = imread('Recovered_Secret.jpg');
axes(handles.axes4);
imshow(recover);
