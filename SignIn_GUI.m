% UCSD ECE5 Attendance GUI
% Created by Camille Lee, modified by Scott Zhao and Quoc-Zuy Do
% Last Modified 9/30/18 (see changelog)
function varargout = SignIn_GUI(varargin)
% SIGNIN_GUI MATLAB code for SignIn_GUI.fig
%      SIGNIN_GUI, by itself, create3s a new SIGNIN_GUI or raises the existing
%      singleton*.
%
%      H = SIGNIN_GUI returns 21822055367447
% the handle to a new SIGNIN_GUI or the handle to
%      the existing singleton*.
%
%      SIGNIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNIN_GUI.M with the given input arguments.
%
%      SIGNIN_GUI('Property','Value',...) creates a new SIGNIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SignIn_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SignIn_GUI_OpeningFcn via varargin.
%r
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SignIn_GUI

% Last Modified by GUIDE v2.5 30-Sep-2018 23:37:41

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SignIn_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SignIn_GUI_OutputFcn, ...
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


% --- Executes just before SignIn_GUI is made visible.
function SignIn_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SignIn_GUI (see VARARGIN)

% Choose default command line output for SignIn_GUI

% Save the previous signedIn.mat

handles.output = hObject;

% Setting the lines in the guide
set(handles.EDIT_BarcodeInput, 'String', ''); %handles.id = get(handles.EDIT_BarcodeInput, 'String');

% Initialize Program Variables
global studsHere signedIn xlsPathName
studsHere = 0;
signedIn = {};
handles.date = clock;
xlsPathName = ['Attendance_', num2str(handles.date(2)),'_', num2str(handles.date(3)), '_',num2str(handles.date(1))];

% Loading class roster with info
global classinfo classSize
load('classinfo.mat');
if(exist('classinfo', 'var'))
    roster = size(classinfo);
    classSize = roster(1);	% obtains number of students
    set(handles.TEXT_LOG, 'String', sprintf('Database Updated: %d Students Loaded.', classSize))
    
else
    set(handles.TEXT_LOG, 'String', 'Database signedin.mat Error! Please manually scan their barcode and process later')
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SignIn_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SignIn_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function EDIT_BarcodeInput_Callback(hObject, eventdata, handles)
%handles.id = get(hObject, 'String');
%display(handles.id);
guidata(hObject, handles);
PB_Signin_Callback(hObject, eventdata, handles) % Automatically call pushbutton to sign in when scanned number / hit enter



% --- Executes during object creation, after setting all properties.
function EDIT_BarcodeInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EDIT_BarcodeInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.21822055393187

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_Signin.
function PB_Signin_Callback(hObject, eventdata, handles)
global xlsPathName classinfo classSize

barcodeInput = get(handles.EDIT_BarcodeInput, 'String');
if(length(barcodeInput) == 0)   % If input empty skip processing
    return
end
found = 0;
disp('-------------------')
% Identifying if input is a PID or barcode
tf = barcodeInput(1);
if tf == 'a' | tf == 'u' | tf == 'A' | tf == 'U'    % it's a pid
    id = str2num(barcodeInput(2:end));
else
    id = str2num(barcodeInput);	% it's barcode number
    
end

global studsHere
global k
global signedIn


% Finding matching PID or barcode
for k = 1:classSize
    
    %fprintf("pid %d, ssid %d\n", classinfo{k,3}, classinfo{k,5})
    % display(classinfo{k,4});
    pid = classinfo{k,4};
    if (id == classinfo{k,5} | id == str2num(pid(2:end)))
       found = 1;
       % saving the list of students here
       studsHere = studsHere + 1;
       display(studsHere);
       signedIn{studsHere, 1} = classinfo{k,1}; % saving last name
       display(num2str(signedIn{studsHere, 1}));
       signedIn{studsHere, 2} = classinfo{k,2}; % saving first name
       display(num2str(signedIn{studsHere, 2}));
       
       fprintf('Thank you, for signin in %s %s.\n', classinfo{k,2}, classinfo{k,1});
       set(handles.TEXT_BGROUND,'BackgroundColor',[0 0.65 0]);
       set(handles.TEXT_Title,'BackgroundColor',[0 0.65 0]);
       set(handles.TEXT_SignedIn, 'BackgroundColor',[0 0.65 0]);
       set(handles.TEXT_LOG, 'BackgroundColor',[0 0.65 0]);
       thankYouMessage = sprintf('Number of Students Signed In: %d \n\nThank you, %s %s.\n', studsHere, classinfo{k,2}, classinfo{k,1});
       set(handles.TEXT_SignedIn, 'String', thankYouMessage);
       set(handles.EDIT_BarcodeInput, 'String', '');  % Clear ID input box
       set(handles.TEXT_LOG, 'String', ''); % Clear Log box
%        beep;                       % Play sound for successful signIn
       uicontrol(handles.EDIT_BarcodeInput);          % Put cursor back to barcodeInput edit
       
       
       % saves to the list
       %save signedIn.mat signedIn
       
       break
    end
end

% list with all the names
%save signedIn.mat signedIn

% no matching ID is found
if (found ~= 1)
    set(handles.TEXT_BGROUND,'BackgroundColor',[0.5 0 0]);
    set(handles.TEXT_Title,'BackgroundColor',[0.5 0 0]);
    set(handles.TEXT_SignedIn,'BackgroundColor',[0.5 0 0]);
    set(handles.TEXT_LOG, 'BackgroundColor',[0.5 0 0]);
    set(handles.TEXT_SignedIn, 'String', 'ID not found.');
    set(handles.EDIT_BarcodeInput, 'String', '');  % Clear ID input box
%     sound(randn(4096, 1), 8192)     % Play alert sound
    uicontrol(handles.EDIT_BarcodeInput);          % Put cursor back to barcodeInput edit
end


% saves the list of student's names to excel file
display(signedIn)
cell2csv(strcat(xlsPathName, '.csv'), signedIn);

function TEXT_SignedIn_CreateFcn(hObject, eventdata, handles)
