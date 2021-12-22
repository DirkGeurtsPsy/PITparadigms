%----------------------------------------------------------------------------
%        MAIN FILE TO EDIT
%
%        This is the only file that should demand any changes!!!
%
%----------------------------------------------------------------------------
fprintf('............ Setting basic parameters according to \n')
fprintf('............            MODIFYME.M\n'); fprintf('............ \n')
clear all;     % Tabula rasa


%----------------------------------------------------------------------------
%        To save or not to save
%        This should ALWAYS be set to 1 when doing experiments obviously
%----------------------------------------------------------------------------
doinstr=1;
dosave=1;
payment=1;	% is this subject being paid? NO for patients

%----------------------------------------------------------------------------
%        Patient or Control? 
%----------------------------------------------------------------------------
%type = 'P'; 		% patient 
type = 'C'; 		% control

%----------------------------------------------------------------------------
%        Subject's first name
%        NB: in single quotes!
%----------------------------------------------------------------------------
name = 'ATD_02_pieput';

%----------------------------------------------------------------------------
%        SUBJECT NUMBER
%       NB: in single quotes!
% 			all subjects starting from 1000... difference btw ctrls and patients
% 			explicitly above 
%----------------------------------------------------------------------------
subjn = '1001';	
%----------------------------------------------------------------------------
%        EXPERIMENTAL PARAMETERS
%----------------------------------------------------------------------------

Z.Npit=200; 	        	% Number of PIT trials PER BLOCK 
Z.Npav(1)=60;				% Number of Pavlovian presentations, block 1
Z.Npav(2)=30;				% Number of Pavlovian presentations, block 2
Z.Ninst = 3;				% Number of Instrumental stimuli per value (max 5)
Z.Ntrain = 120;             % Number of instrumental training trials
Z.Nav = 8;					% Number of go responses for average RT 
Z.P=[1 1];					% Valenced outcome probabilities for Pavlovian stimuli 
Z.Pavout=[100 10 0 -10 -100];% Pavlovian outcomes 
Z.Pi=[.75];					% Probability of correct instrumental training feedback 
Z.cpmod=5;					% Frequency of query trials 
nogodelay = 1.5;			% Delay before call it nogo [in seconds]
sounddur = .7;				% max duration of sound [in seconds]
breaklength = 120;          % length of break [in seconds]
english=0;					% 1=english, 0=deutsch
dutch=1;

%----------------------------------------------------------------------------
%        IMAGE
%        Resolution: Should use min 50 for experiment, otherwise 
%        images are low quality. However, might need to adjust this... 
%        Color: Use anything you like 
%----------------------------------------------------------------------------
txtsize=40;            % Size of text in pixels; this needs adjustment when
							  % screen size changes. For a screen that's 1024x767, use
							  % 40, for a large 1900x2100 screen use up to 65
