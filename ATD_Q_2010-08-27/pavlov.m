% draw the Pavlovian stimulus 

Screen('DrawTexture',wd,shape(pavpres(np)),[],dr(posp(np),:));
Screen('Flip',wd,[],1);
PsychPortAudio('Start', soundhandle(pavpres(np)),1,0,1);

% show outcome 

total = total + pavout(np);
if pavout(np)>0;
	tcol=blue;
    if dutch
    txt={'Door dit plaatje','wint u: ',['+ ' num2str(pavout(np)) ' cent']};
	sound = soundhandle(1);
    else
	txt={'Dieses Bild fuehrt','zu Gewinn: ',['+ ' num2str(pavout(np)) ' cent']};
	sound = soundhandle(1);
    end
elseif pavout(np)<0;
	tcol=red;
	if dutch
    txt={'Door dit plaatje','verliest u: ',['- ' num2str(abs(pavout(np))) ' cent']};
	sound = soundhandle(2);
    else
    txt={'Dieses Bild fuehrt','zu Verlust: ',['- ' num2str(abs(pavout(np))) ' cent']};
	sound = soundhandle(2);
    end
elseif pavout(np)==0;
	tcol=white;
	txt={'0'};
end


% print text for outcome 
Screen('TextSize',wd,txtsize+10);
nrow=length(txt);
for k=1:nrow
	[wt]=Screen(wd,'TextBounds',txt{k});

	% print it in the second square on the screen 
	xpos=(.4*dr(3-posp(np),1)+.6*dr(3-posp(np),3))-wt(3)/2;
	ypos=wdh/2+2*(k-.8-nrow/2)*wt(4);

	Screen('Drawtext',wd,txt{k},xpos,ypos,tcol);
end
Screen('TextSize',wd,txtsize)	;

WaitSecs( 1); Screen('Flip',wd,[],1);
% need this to make sure PTB doesn't miss stuff
WaitSecs(.5); Screen('Flip',wd);

WaitSecs(1.5);
PsychPortAudio('Stop', soundhandle(pavpres(np)));
Screen('FillRect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);
WaitSecs(.5);

% Allow for abortion of experiment
checkabort;
