function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 30-Nov-2016 13:39:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
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
global img;
global key;
X = uigetfile('*.jpg;*.tiff;*.ppm;*.pgm;*.png');
img = imread(X);
  axes(handles.axes2)
  imshow(img);
  
[n m k] = size(img);
  key = keyGen(n*m);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img ;
global encImg; 
global key;
encImg = imageProcess(img, key);
%set(handles.text2, 'String', 'Encryption Process Complete!!');
dispMsg = msgbox('Encryption Process Complete!!','Success','modal');
uiwait(dispMsg);
axes(handles.axes3)
imshow(encImg);
imwrite(encImg,'Encrypted.jpg','jpg');
guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cover;
X = uigetfile('*.jpg;*.tiff;*.ppm;*.pgm;*.png');
cover = imread(X);
  axes(handles.axes4)
  imshow(cover);
  imwrite(cover,'Cover.jpg','jpg');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
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
% output = flow(s_index, t_index, list_1, list_2, img_size, subimg_size);
% len = length(output);
% [msgnew, embedimg] = embed(result, output);
% [exmsg,img] = extract(embedimg, msgnew, len);
% info = info_extract(img, subimg_size, exmsg);
% recover_list = color_retrans(info, img, subimg_size);
% recovery(result, subimg_size, recover_list, s_index);
info = info_extract( result,subimg_size,output );
recover_list = color_retrans( info,result,subimg_size );
recovery( result,subimg_size,recover_list,s_index );
%set(handles.text2, 'String', 'Recovery of Hidden Image Complete!!');
dispMsg = msgbox('Recovery of Encrypted Image Complete!!','Success','modal');
uiwait(dispMsg);
recover = imread('Recovered.jpg');
axes(handles.axes5);
imshow(recover);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global decImg;
global encImg;
global key;
steg = imread('Recovered.jpg');
decImg = imageProcess(steg, key);
%set(handles.text2, 'String', 'Secret Image Recovered!!');
dispMsg = msgbox('Decryption Complete! Secret Image Recovered!','Success','modal');
uiwait(dispMsg);
%DecImg
axes(handles.axes6);
imshow(decImg);
imwrite(decImg,'Decrypted.jpg','jpg');
guidata(hObject, handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global encImg;
global cover;
global s_index;
global t_index;
global list_1;
global list_2;
global subimg_size;
global img_size;
global result;
global output;

img_size = [512,512];
subimg_size = 2;
%list_1 = split('Encrypted.jpg', subimg_size);
list_1 = split(encImg, subimg_size);
%list_2 = split('Cover.jpg', subimg_size);
list_2 = split(cover, subimg_size);
[s_list, s_index] = img_sort(list_1);
[t_list, t_index] = img_sort(list_2);
[list, output] = color_transfer(s_index, t_index, list_1, list_2, img_size, subimg_size );
result = substitute(t_index, subimg_size, list);
%set(handles.text2, 'String', 'Image Hiding Process Complete!!');
dispMsg = msgbox('Image Hiding Process Complete!!','Success','modal');
uiwait(dispMsg);
imshow(result);
imwrite(result, 'Steg.jpg','jpg');
guidata(hObject, handles);
