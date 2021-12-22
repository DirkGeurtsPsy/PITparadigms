fprintf('............ Setting up the screen   \n');

%................... colours in RBG coordinates
bgcol(1) = 80;
bgcol(2) = 200;
white = [200 200 200];
orange = [255 100 50];
red = [255 20 20];
blue = [100 100 255];
green = [100 255 100];
black = [0 0 0];


    mjp = pwd;
    
    if ~strcmp(mjp((end-10):end),'major_parts')
        fprintf(' ******************************************\n')
        fprintf(' ****      STARTED FROM WRONG PATH     ****\n')
        fprintf(' **** Start from path [..]/major_parts ****\n')
        fprintf(' ******************************************\n')
        
        WaitSec(3);
    end
        
    
    homedirect = mjp(1:end-11); % substract major_parts ( = 11 charact from string)


%................... open a screen
Screen('Preference','Verbosity',0);

if DBmode~= 1

    [wd, windowRect] = Screen('OpenWindow',0,bgcol(1));			% Get Screen. This is always size of the display.
    [widthwindowRect,heightwindowRect] = RectSize(windowRect);

elseif DBmode == 1

    % Use when in debugging mode
    [wd, windowRect] = Screen('OpenWindow', 0, [0 0 0], [0 0 600 600]);
    [widthwindowRect,heightwindowRect] = RectSize(windowRect);

end 

Screen('TextSize',wd,txtsize);				% Set size of text
%---------------------------------------------------------------------------
%                    SCREEN LAYOUT
%---------------------------------------------------------------------------
[wdw, wdh] = Screen('WindowSize', wd);	% Get screen size

%................... Presentation coordinates
% coordinates for mushrooms
xfrac = .7; yfrac = .5; yfrrew = .7;
xl0 = xfrac*wdw;
yl0 = yfrac*wdh;
zl0 = yfrrew*wdh;
x0 = (1-xfrac)/2*wdw;
y0 = (1-yfrac)*5/9*wdh;
z0 = (1-yfrrew)/2*wdh;
xl2 = xl0/2;
drawregion = round([x0 y0 x0+xl0 y0+yl0]); % region within which all is drawn

% 2 boxes to present the Pavlovian stimuli on their own / with outcomes and
% squares stimuli
for j = 1:2

    dr(j,:) = round([x0+(j-1+.1)*xl2 y0 x0+(j-.1)*xl2 y0+yl0-.1*yl0]);

end

% 1 box to present the Pavlovian stimuli on their own.
dr1 = round([x0+(j-1+.1)*xl2 y0 x0+(j-.1)*xl2 y0+yl0-.1*yl0]);
dr1 = CenterRectOnPoint(dr1,wdw/2,wdh/2);

Nsqx = 3;
xls = xl0/Nsqx;

for j = 1:Nsqx

    % 3 boxes to present instrumentalstimuli on each sie of a central (invisible) box
    % 	drms(j,:) = round([x0+((j-1)+.1)*xls y0+.25*yl0 x0+(j-.2)*xls y0+.75*yl0]);
    drms(j,:) = round([x0+((j-1)+.1)*xls ((y0+.25*yl0)-(y0+.15*yl0)) x0+(j-.2)*xls (y0+.75*yl0-(y0+.15*yl0))]);
    % 3 frames around those boxes
    % 	drm(j,:) = round([x0+((j-1))*xls y0+.15*yl0 x0+(j-.1)*xls y0+.85*yl0]);
    drm(j,:) = round([x0+((j-1))*xls 0 x0+(j-.1)*xls y0+.85*yl0-(y0+.15*yl0)]);

end

%draw a line which will function as fence in avoidance trials.


%box for spot in instrumental task
spotDiameter = spotRadius * 2;
spotRect = [0 0 spotDiameter spotDiameter];
bottomspotRect = CenterRectOnPoint(spotRect, windowRect(3)/2, windowRect(4)); % Put spot at bottom center of screen ( = startpoint)

% tiling background
xlb = drms(1,3)-drms(1,1);
ylb = drms(1,4)-drms(1,2);
nxb = floor(wdw/xlb);
nyb = floor(wdh/ylb);
x0b = round((wdw - nxb*xlb)/2);
y0b = 0;

% box for tiling background
bgr  = windowRect;
hok  = [0.35*widthwindowRect 0.05*heightwindowRect 0.65*widthwindowRect 0.3*heightwindowRect];
%---------------------------------------------------------------------------
%		Setup keyboard
%---------------------------------------------------------------------------

KbName('UnifyKeyNames'); % Enable unified mode of KbName, so KbName accepts identical key names on all operating systems:
rightKey = KbName('RightArrow');  % Set keys.
leftKey = KbName('LeftArrow'); % Set keys.
choiceKey =  KbName('DownArrow');
Trigger = KbName('5%');
%     button52 = KbName('4$');
button51 = KbName('3#');
button50 = KbName('2@');  % Set keys.
button49 = KbName('1!'); % Set keys.
downKey = KbName('DownArrow');
escapeKey = KbName('ESCAPE'); % Set keys.
F12 = KbName('f12');
enter = KbName('return');
movkey = windowRect(3)/15;

%---------------------------------------------------------------------------
%		Preload images so we have good presntation time control
%---------------------------------------------------------------------------
% Load images for training
for R = 1:4;

    [imagename map alpha] = imread(eval(['''',homedirect,'shrooms/trainingmshr_' num2str(R) '.png''']));
    imagename(:,:,4) = alpha(:,:);
    Screen('BlendFunction', wd, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    trn(1,R) = Screen('MakeTexture',wd,imagename);

end

for R = 1:4;

    [imagename map alpha] = imread(eval(['''',homedirect,'shrooms/trainingshll_' num2str(R) '.png''']));
    imagename(:,:,4) = alpha(:,:);
    Screen('BlendFunction', wd, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    trns(1,R) = Screen('MakeTexture',wd,imagename);

end

% Load mushroom images for O
for R = 1:St.Inst.N;

    [imagename map alpha] = imread(eval(['''',homedirect,'shrooms/shroom_' num2str(R) '.png''']));
    imagename(:,:,4) = alpha(:,:);
    Screen('BlendFunction', wd, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    msh(1,R) = Screen('MakeTexture',wd,imagename);

end

% Load pav shapes
for R = Ap(1,1:St.Pav.N);

    pic = imread(eval(['''',homedirect,'stimuli/fractal' num2str(R) '.jpg''']));
    shape(1,R) = Screen('MakeTexture',wd,pic);
    % tile the Pavlovian stimuli all over background for the PIT stage
    clear Tmp;
    
    for j = 1:3
    
        Tmp(:,:,j) = repmat(pic(1:nyb:end,1:nxb:end,j),nyb,nxb);
    
    end
    
    bgshape(1,R) = Screen('MakeTexture',wd,Tmp);
    
    checkabort;

end

% Load shell images for O2
for R = 1:St.Inst.N;

    [imagename map alpha] = imread(eval(['''',homedirect,'shrooms/shell_' num2str(R) '.png''']));
    imagename(:,:,4) = alpha(:,:);
    Screen('BlendFunction', wd, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    shll(1,R) = Screen('MakeTexture',wd,imagename);

end

% Load pav shapes
for R = Ap(1,St.Pav.N+1:2*St.Pav.N);

    pic = imread(eval(['''',homedirect,'stimuli/fractal' num2str(R) '.jpg''']));
    shape(2,R) = Screen('MakeTexture',wd,pic);
    % tile the Pavlovian stimuli all over background for the PIT stage
    clear Tmp;
    
    for j = 1:3
    
        Tmp(:,:,j) = repmat(pic(1:nyb:end,1:nxb:end,j),nyb,nxb);
    
    end
    
    bgshape(2,R) = Screen('MakeTexture',wd,Tmp);
    checkabort;

end

%---------------------------------------------------------------------------
%                    SOUND
%---------------------------------------------------------------------------
nrchannels = 1; % One channel only -> Mono sound.
freq = round(440*2*pi);
snd = round(rand(1));

if snd == 1

    rat = [.4 .5 .6 .7 .8 .9];

elseif snd~= 1

    rat = [.9 .8 .7 .6 .5 .4];

end

for R = 1:(2*St.Pav.N);

    rawsound(R,:) = sin((0:(sounddur*440*2*pi))*rat(R));	% high tone

end

% Perform basic initialization of the sound driver:
InitializePsychSound;

% Open the default audio device [], with default mode [] ( == Only playback),
% and a required latencyclass of zero 0 ==  no low-latency mode, as well as
% a frequency of freq and nrchannels sound channels.
% This returns a handle to the audio device:
% Fill the audio playback buffer with the audio data 'wavedata':
for R = 1:(2*St.Pav.N);

    soundhandle(R) = PsychPortAudio('Open', [], [], 0, freq, 1);
    PsychPortAudio('FillBuffer', soundhandle(R), rawsound(R,:));

end

%Set movkey
movkey = wdw/15;


graysquare = Screen('Maketexture',wd,bgcol(1)*ones(10,10,3));


if dosave; eval(['save ' namestring '.mat']);end

