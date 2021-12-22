fprintf('............ Setting up the screen   \n');

%................... colours in RBG coordinates 
bgcol(1)=80;
bgcol(2)=200;
white=[200 200 200]; 
orange=[255 100 50]; 
red=[255 20 20]; 
blue=[100 100 255]; 
green=[100 255 100]; 

%................... open a screen
Screen('Preference','Verbosity',0);
wd=Screen('OpenWindow',0,bgcol(1));			% Get Screen. This is always size of the display. 
Screen('TextSize',wd,txtsize);				% Set size of text

%---------------------------------------------------------------------------
%                    SOUND 
%---------------------------------------------------------------------------
nrchannels = 1; % One channel only -> Mono sound.
freq = round(440*2*pi);
rat=[2.5 2 1.5 .67 .5 .4];
for k=1:Z.Nps
	rawsound(k,:)=sin((0:(sounddur*440*2*pi))*rat(k));	% high tone
end

% Perform basic initialization of the sound driver:
InitializePsychSound;

% Open the default audio device [], with default mode [] (==Only playback),
% and a required latencyclass of zero 0 == no low-latency mode, as well as
% a frequency of freq and nrchannels sound channels.
% This returns a handle to the audio device:
% Fill the audio playback buffer with the audio data 'wavedata':
for k=1:Z.Nps
	soundhandle(k) = PsychPortAudio('Open', [], [], 0, freq, 1);
	PsychPortAudio('FillBuffer', soundhandle(k), rawsound(k,:));
end

%---------------------------------------------------------------------------
%                    SCREEN LAYOUT
%---------------------------------------------------------------------------
[wdw, wdh]=Screen('WindowSize', wd);	% Get screen size 

%................... Presentation coordinates 
% coordinates for mushrooms
xfrac=.7; yfrac=.5; yfrrew=.7;
xl0=xfrac*wdw; 
yl0=yfrac*wdh; 
zl0=yfrrew*wdh;
x0=(1-xfrac)/2*wdw; 
y0=(1-yfrac)*5/9*wdh;
z0=(1-yfrrew)/2*wdh;
xl2=xl0/2; 
drawregion=round([x0 y0 x0+xl0 y0+yl0]); % region within which all is drawn

% 2 boxes to present the Pavlovian stimuli on their own / with outcomes and
% squares stimuli 
for j=1:2
	dr(j,:)=round([x0+(j-1+.1)*xl2 y0 x0+(j-.1)*xl2 y0+yl0-.1*yl0]);
end

Nsqx=3;
xls=xl0/Nsqx;
for j=1:Nsqx
	% 3 boxes to present instrumentalstimuli on each sie of a central (invisible) box
	drms(j,:)=round([x0+((j-1)+.1)*xls y0+.25*yl0 x0+(j-.2)*xls y0+.75*yl0]);
	% 3 frames around those boxes 
	drm(j,:)=round([x0+((j-1))*xls y0+.15*yl0 x0+(j-.1)*xls y0+.85*yl0]);		 
end

% tiling background 
xlb = drms(1,3)-drms(1,1);
ylb = drms(1,4)-drms(1,2);
nxb = floor(wdw/xlb);
nyb = floor(wdh/ylb);
x0b = round((wdw - nxb*xlb)/2);
y0b = 0;

% box for tiling background
bgr = [x0b y0b nxb*xlb nyb*ylb];

%---------------------------------------------------------------------------
%		Preload images so we have good presntation time control 
%---------------------------------------------------------------------------

% Load mushroom images 
Nmsh = 4*Z.Ninst;			% How many different mushroom (instrumental) stimuli
[foo,mshind] = sort(rand(1,Nmsh));							 % randomize mushrooms 
for k=1:Nmsh/2
	% load image into matlab 
	eval(['tmp=imread(''shrooms/shroom_' num2str(k) '.jpg'');'])
	% load it into Screen, with index msh(1,mshind(k))
	% randomize which mushrooms are good and bad
	msh(1,mshind(k))=Screen('MakeTexture',wd,tmp);

	eval(['tmp=imread(''shrooms/shroom_' num2str(k) '.png'');'])
	% load it into Screen, with index msh(1,mshind(k+Nmsh/2))
	% randomize which mushrooms are good and bad
	msh(1,mshind(k+Nmsh/2))=Screen('MakeTexture',wd,tmp);
end

% Load Pavlovian stimuli 
[foo,ind] = sort(rand(Z.Nps,1));						% randomize Pavlovian stimuli
for k=1:Z.Nps
	%eval(['tmp=imread(''stimuli/shape' num2str(k) '.png'');'])
	eval(['tmp=imread(''stimuli/fractal' num2str(k) '.jpg'');'])
	shape(1,ind(k))=Screen('MakeTexture',wd,tmp);

	% tile the Pavlovian stimuli all over background for the PIT stage
	clear Tmp;
	for j=1:3
		Tmp(:,:,j) = repmat(tmp(1:nyb:end,1:nxb:end,j),nyb,nxb);
	end
	bgshape(1,ind(k))=Screen('MakeTexture',wd,Tmp);

	text = {'Experimentaufbau',num2str(Z.Nps-k)};
	displaytext(text,wd,wdw,wdh,orange,0,0);

	checkabort;
end

graysquare = Screen('Maketexture',wd,bgcol(1)*ones(10,10,3));

if dosave; eval(['save ' namestring '.mat']);end

