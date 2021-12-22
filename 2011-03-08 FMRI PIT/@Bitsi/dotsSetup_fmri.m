%fr                  = 60; % refresh rate of the screen

%Setup of basic parameters

Priority            = 2;
background          = [0 0 0];      % background color = black
dim                 = [150 150];    % dimension of the two square dot patterns [100 100]

preFrame            = 40; 
ndots               = 600;          % nr of dots [200]
lifetime            = 40;
step                = 1;          % speed of dots [0.5]
totframes           = 400; 
Mag                 = 1;            % magnifize the stimulus on the screen [2]
squaresep           = 200;          % distance between the squares [200]
fixvhdim            = 12;           % hoogte/breedte fixatie kruis [12]
linewidth           = 2;            % lijndikte fixatie kruis [1]
color               = 150;          % standard color fixation cross [150]
%ScreenNumber        = 1;


%randomize the coherence of novel trials
[coherence_novel,coherence_novel_transform] = coherences_novel(coherence_threshold,nrofnovel);
%randomize the coherence of all repeat trials
[coherence_repeat,coherence_range,coherence_repeat_transform] = coherences_repeat(coherence_threshold,nroftrials);
%randomizes the number of correct repeat trials before a novel trial
[nrcorrectrepeattrials] = repeattrials(nrofnovel);
%randomizes the time between repeat trials
[switch_target] = repeat_switch_target(nroftrials);
%randomizes the direction on repeat trials
[directions_repeat] = direction_repeat(nroftrials);
%randomizes the direction on novel trials
[directions_novel] = direction_novel(nrofnovel);


screenNumber = max(Screen('Screens'));
%[w,screenRect]   = Screen('OpenWindow', screenNumber, [0 0 0], [100 100 1024 768]); %debug mode
[w,screenRect] = Screen(screenNumber,'OpenWindow');
Screen('FillRect',w,background);
Screen('Flip', w);
HideCursor;



b = Bitsi('com6');
b2 = Bitsi('com7');
KbName('UnifyKeyNames');
Buttonup          =  KbName('f');
Buttondown         =  KbName('v');
begintekst     ='Druk op een willekeurige toets om te beginnen';
scannertekst   = 'Wachten tot de scanner begint..';
pauzetekst     ='Pauze - Druk op een willekeurige toets om verder te gaan';
eindtekst      ='Einde van het experiment. Bedankt voor je deelname!';



s_r = [0 0 dim(1) dim(2)];
dst = CenterRect(s_r.*Mag,screenRect);
left = dst - [squaresep 0 squaresep 0];
right = dst + [squaresep 0 squaresep 0];

% initialise log file and put some info at the start
logfile     = fopen([sID '_log'],'w+');
fprintf(logfile, 'Date:\t\t\t%s \n', today);
fprintf(logfile, 'Time:\t\t\t%s\n', startexp);
fprintf(logfile, 'Subject ID:\t\t%s\n', sID);

fprintf(logfile, 'Trialnr\t');
fprintf(logfile, 'Switchnr\t');
fprintf(logfile, 'Pause\t');
fprintf(logfile, 'Novel\t');
fprintf(logfile, 'Switch\t');
fprintf(logfile, 'Nonswitch\t');
fprintf(logfile, 'Attended side\t');
fprintf(logfile, 'Direction attended side\t');
fprintf(logfile, 'Coherence attended side\t');
fprintf(logfile, 'Direction unattended side\t');
fprintf(logfile, 'Coherence unattended side\t');
fprintf(logfile, 'Response\t');
fprintf(logfile, 'Start trial\t');
fprintf(logfile, 'Start stimulus\t');
fprintf(logfile, 'Start response\t');
fprintf(logfile, 'Response time\t');
fprintf(logfile, 'Feedback\t');
fprintf(logfile, 'Nr of correct responses\t');
fprintf(logfile, 'Criterion correct responses\t');
fprintf(logfile, 'Time switch target\t');
fprintf(logfile, '\n');