%----------------------------------------------------------------------------
%        MAIN FILE TO EDIT
%
%        This is the only file that should demand any changes!!!
%
%----------------------------------------------------------------------------
fprintf('............ Setting basic parameters according to \n')
fprintf('............            MODIFYME.M\n'); fprintf('............ \n')



%----------------------------------------------------------------------------
%        To save or not to save
%        This should ALWAYS be set to 1 when doing experiments obviously
%----------------------------------------------------------------------------

%% debug or real?
DBmode=input('Debugmode?(1 if true, 0 if not true)');
doinstr=1;
dosave=1;
payment=1;	% is this subject being paid? NO for patients
Vas=1;
Cal=1;

if DBmode==1
    Cal     =   input('Do you want to run callibration? 1=yes 0=no');
    Vas     =   input('Do you want to run vas? 1=yes 0=no');
    dosave  =   input('Do you want to save? 1=yes 0=no');
    doinstr =   input('Do you want to run instructions? (1=yes, 0=no)');
end

%----------------------------------------------------------------------------
%        Patient or Control? 
%----------------------------------------------------------------------------
%type = 'P'; 		% patient 
type = input('type? (C=control PS=pilotsubjct P=patient)'); 		% control

%----------------------------------------------------------------------------
%        Subject's first name
%        NB: in single quotes!
%----------------------------------------------------------------------------
name = input('subjectname? (answer between'')');

%----------------------------------------------------------------------------
%        SUBJECT NUMBER
%       NB: in single quotes!
% 			all subjects starting from 1000... difference btw ctrls and patients
% 			explicitly above 
%----------------------------------------------------------------------------
subjn = input('subjectnumber? (answer between '')');	

%----------------------------------------------------------------------------
%        EXPERIMENTAL PARAMETERS
%----------------------------------------------------------------------------


%comparison trials 
% trial number
% take this into account: 
                % The total instrumental training trials and total PIT trials
                %   have to be an even numer (because of the two conditions: wihtdrawal and approach).
                % The total of instrumental training trials must be a multiplication of the total of instrumental
                %   stimuli.
                % The total of Pavlovian trials must be a multiplication of
                %   the number of pavlovian stimuli (because we want to present
                %   the different stimuli equally often)
                % The total number of PIT trials must be a multiplication
                %   of as well the total number of Instrumental Stimuli as
                %   well as the total of pavlovian stimuli, because we want
                %   to present each instrumental stimulus equally often on
                %   the foreground for each Pavlovian stimulus.
                % When the totsal number of Instr trial as wel as PIT trials 
                %   are divided by the number of trials per instrumental
                %   miniblock it should result in an even, natural number. 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
%       #ST    Instr   PIT     MB                                   %
%       12      24      36      6/12/(8 if PIT=72)                  %
%       10      20      120     5/10                                %
%       8       16      24      8( if PIT=48) 4/3                   %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

if DBmode==1;
% In debugging mode
Tr.TotInst=16;          % total instrumental training trials
Tr.TotPav=6;            % total Pavlovian trials
Tr.TotPIT=48;           % total of PIT trials
Tr.InstMB=8;            % number of trials per instrumental mini block
Tr.PITMB=Tr.InstMB;     % number of trials per PIt mini block
Comp=3;                 % pavlovian stimulus/comparisontrial

elseif DBmode==0;
Tr.TotInst=80;            % total instrumental training trials
Tr.TotPav=60;             % total Pavlovian trials
Tr.TotPIT=96;             % total of PIT trials
Tr.InstMB=8;              % number of trials per instrumental mini block
Tr.PITMB=Tr.InstMB;       % number of trials per PIt mini block
Comp=10;                  % pavlovian stimulus/comparisontrial
end

                Tr.Tot1=Tr.TotInst;
                Tr.Tot2=Tr.TotInst+Tr.TotPav;
                Tr.Tot3=Tr.TotInst+Tr.TotPav+Tr.TotPIT;
%number of stimuli
St.Inst.N=8;              % number of instrumental stimuli
St.Pav.N=3;               % number of pavlovian stimuli
             

% value of stimuli
St.Pav.V= [-500 0 500];
St.Inst.V= [-100 100];

% feedbackprobabilities
St.Pav.F    =   0.5;            % in how many of the trials feedback is given
St.Inst.F   =   0.8;           % in what percentage of the trials the 'right' reward/punihsment is given.

%Outcome pavlovian trial
juice=1;                    % if juicy then 1
money=0;                    % if monetary then 1
sounddur = 3;				% max duration of sound [in seconds]

% treshold for response frequency, at what percentage a Go will be made:
Tresh.bp=1;                 % percentage of maximum frequency from callibration should be reached to make a valid go.

% when you hold the button to long
push2long=0.2;

%Monitor
RefreshRate=65;             %refreshrate of monitor in Hz


nogodelay = 2.5;			% Delay before call it nogo [in seconds]
breaklength = 60;          % length of break [in seconds]
german=0;					% 1 if text in german
english=0;                  % 1 if text in english
dutch=1;                    % 1 if text in dutch

    spotRadius        = 25;      % The radius of the spot.
    durationInSeconds = 2.5;       %Duration of spotmovement from bottom of screen to top.
    strtpnt           = [1/5  4/5 1/2];
    div               = 1.05;     %the distance the spot moves form starting x-coordinate will be divided by div (the bigger the lesser the spot will move horizontally.
    mltp              = 10;      %the random number of pixels the spot is moved horizontally on keypress is multiplied by mltp.
    choiceduration    = 2;       % seconds participants have to make a choice.

%--------------------------------------------------------------------------
%
%Pumpsettings
%
%--------------------------------------------------------------------------

pump.runDuration   = 2000;     % duration of delivery
pump.flowRate      = 100;      % flowrate in % of maximum
pump.tubeLength    = input('Tubelength? (10=if patient is in scanner; 1000=to run it through)');     % in cm
pump.tubeDiam      = 2.54/32;  % in cm
pump.tubeVol       = pump.tubeDiam^2*pi*pump.tubeLength; % in ml
    
%----------------------------------------------------------------------------
%        IMAGE
%        Resolution: Should use min 50 for experiment, otherwise 
%        images are low quality. However, might need to adjust this... 
%        Color: Use anything you like 
%----------------------------------------------------------------------------
txtsize=20;            % Size of text in pixels; this needs adjustment when
							  % screen size changes. For a screen that's 1024x767, use
							  % 40, for a large 1900x2100 screen use up to 65

%--------------------------------------------------------------------------
%
%Scannersettings
%
%--------------------------------------------------------------------------

dummyStart=30;
dummyStop=6;
fmri=input('Do you want to use the fmri scanner? 1=yes 0=no');
Trigger='5%';
Triggernr=53;
