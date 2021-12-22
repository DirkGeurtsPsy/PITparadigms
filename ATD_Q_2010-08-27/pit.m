% ............... present square in middle to initiate next trial 
centermouseclick;

%.............. DRAW STIMULI 

% fill the screen background with the Pavlovian stimulus 
Screen('DrawTexture',wd,bgshape(mpresp(npit)),[],bgr);
PsychPortAudio('Start', soundhandle(mpresp(npit)),1,0,1);

% draw a gray scquare (over the background) and a blue box around the stimulus 
tdr = drm; 
tdr(:,[2 4]) = tdr(:,[2,4])+80;
if approach	% then draw it around the stimulus itself 
	tmp = [tdr(lr(npit),[1 3 3 1]); tdr(lr(npit),[2 2 4 4])];	 
	Screen('DrawTexture',wd,graysquare,[],tdr(lr(npit),:));
else			% draw it on the other side of the screen 
	tmp = [tdr(4-lr(npit),[1 3 3 1]); tdr(4-lr(npit),[2 2 4 4])];	 
	Screen('DrawTexture',wd,graysquare,[],tdr(4-lr(npit),:));
end
redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
Screen('DrawLines',wd,redbox,2,blue);

% now draw the mushroom 
tdr = drms; 
tdr(:,[2 4]) = tdr(:,[2,4])+80;
Screen('DrawTexture',wd,msh(mpres(npit)),[],tdr(lr(npit),:));

% need this or the buffer screws up and at times doesn't present
% red box around chosen stimulus
WaitSecs(.01);	
Screen('Flip',wd,[],1);
WaitSecs(.01);	
Screen('Flip',wd,[],1);

t0=GetSecs;t=t0;

%.............. GET MOUSE INPUT

ch(npit)=NaN;buttons=[0 0 0 0];
% wait at most nogodelay seconds
while (t-t0 < nogodelay) && ~any(buttons)
	[x,y,buttons]=GetMouse;
	t=GetSecs;
end
pitreact(npit)=t-t0;

% need this or the buffer screws up and at times doesn't present
% red box around chosen stimulus
WaitSecs(.01);	

if ~any(buttons)	
	ch(npit) = 0;	% record nogo 
else		% if button was pressed 
	f1=find(x>drm(1:end,1) & x<=drm(1:end,3));	% find which box was clicked
	f2=find(y>drm(1,2) & y<=drm(1,4));	% assume only one row of stimuli!!!
	if ~isempty(f1) & ~isempty(f2)			
		ch(npit)=f1+(f2-1)*2;
	else ch(npit)=NaN;							% if outside boxes, record NaN
	end

	% draw a red square around chosen stimulus, if clicked inside the box 
	if ~isnan(ch(npit)) & (approach & (ch(npit)==lr(npit)) | ~approach & (ch(npit)==4-lr(npit)) )
		Screen('DrawLines',wd,redbox,3,red);
		Screen('Flip',wd,[],1);
		WaitSecs(.01);	
		Screen('Flip',wd);
		WaitSecs(.5);
	else
		ch(npit)=NaN;
		Screen('FillRect',wd,ones(1,3)*bgcol(1));
		if english
			txt={'Only click inside the blue box.'};
        elseif dutch
            txt={'Klik alleen in het blauwe vierkant.'};
		else
			txt={'Nur in die blaue Box klicken.'};
		end
		displaytext(txt,wd,wdw,wdh,orange,0,0);
		WaitSecs(.7);
	end
end


%............ CORRECT? 

PsychPortAudio('Stop', soundhandle(mpresp(npit)));
Screen('FillRect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);

if ~isnan(ch(npit));
	if approach 
		if ains(npit)==1; % go instruction (good mushroom)
			if     ch(npit)==lr(npit); cr(npit) = 1; % correct approach go 
			elseif ch(npit)==0         cr(npit) = 0; % incorrect approach nogo 
			end
		elseif ains(npit)==2; % nogo instructions 
			if     ch(npit)==0;        cr(npit) = 1; % correct approach nogo 
			elseif ch(npit)==lr(npit); cr(npit) = 0; % incorrect approach go 
			end
		end
	elseif ~approach % withdrawal 
		if ains(npit)==1; % go instruction 
			if     ch(npit)==4-lr(npit); cr(npit) = 1; % correct withdrawal go 
			elseif ch(npit)== 0; cr(npit) = 0; % incorrect nogo 
			end
		elseif ains(npit)==2; % nogo instructions 
			if     ch(npit)== 0; cr(npit) = 1; % correct nogo 
			elseif ch(npit)==4-lr(npit); cr(npit) = 0; % incorrect withdrawal go 
			end
		end
	end
else
	cr(npit) = NaN;		% response outside target area
end


% check for abort
checkabort;

