cit = np/Z.cpmod;	 % count the number of queries 

% draw Pavlovian stimulus 1 
Screen('DrawTexture',wd,shape(cppres(1,cit)),[],dr(1,:));

Screen('DrawTexture',wd,shape(cppres(2,cit)),[],dr(2,:));
Screen('Flip',wd,[],1);

% need this or the buffer screws up and at times doesn't present
% red box around chosen stimulus
WaitSecs(.01);

t=GetSecs;

%.............. GET INPUT

chq(cit)=NaN;wrong=0;buttons=[0 0 0 0];
% wait until mouse click (no timeout)
while isnan(chq(cit)) ;%& wrong<10;;
	% Get input / identify chosen slot machine 
	mygetclicks;
	t0=GetSecs;
	
	f1=find(x>dr(1:2,1) & x<=dr(1:2,3));
	f2=find(y>dr(1:2:end,2) & y<=dr(1:2:end,4));
	if ~isempty(f1) & ~isempty(f2)
		chq(cit)=f1+(f2-1)*2;
	else chq(cit)=NaN;
	end
	% Make sure one of the available machines was chosen 
	if isnan(chq(cit)) % | ~isempty(setdiff(ch,slm));
		wrong=wrong+1;
		chq(cit)=NaN;
        if dutch
            text='Kiest u aub een van de stimuli.';
        else
            text='Bitte waehlen Sie einen der Stimuli.';
        end
		[wt]=Screen(wd,'TextBounds',text);
		Screen('Fillrect',wd,[150],[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
		Screen('Drawtext',wd,text,wdw/2-wt(3)/2,wdh-y0/2,red);
		Screen('Flip', wd,[],1);
		t=GetSecs;
	end
	if wrong>0 & ~isnan(chq(cit));
		Screen('Fillrect',wd,bgcol(1),[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
		Screen('Flip', wd,[],1);
	end
	checkabort; % Allow for abortion of experiment
end
pavreact(cit)=t0-t;

% draw a red square around chosen stimulus
tmp = [dr(chq(cit),[1 3 3 1]); dr(chq(cit),[2 2 4 4])];	 
redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
Screen('DrawLines',wd,redbox,2,red);
Screen('Flip',wd);
WaitSecs(.5);

Screen('FillRect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);
WaitSecs(.5);

% Correct? 

if ~isnan(chq(cit));
	if cppres(chq(cit),cit)<=cppres(3-chq(cit),cit);
		crm(cit) = 1;
	elseif cppres(chq(cit),cit)>cppres(3-chq(cit),cit);
		crm(cit) = 0;
	end
else 
	crm(cit)=NaN;
end


checkabort; % Allow for abortion of experiment
