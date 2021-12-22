% ............... present square in middle to initiate next trial 
centermouseclick;

%............. DRAW STIMULI 





% draw blue box 
tdr = drm; 
tdr(:,[2 4]) = tdr(:,[2,4]);
if approach
	tmp = [tdr(lrt(nt),[1 3 3 1]); tdr(lrt(nt),[2 2 4 4])];	 

else
	tmp = [tdr(4-lrt(nt),[1 3 3 1]); tdr(4-lrt(nt),[2 2 4 4])];	 
	
end
redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
Screen('DrawLines',wd,redbox,2,blue);

% draw mushroom 
tdr = drms; 
tdr(:,[2 4]) = tdr(:,[2,4]);
Screen('DrawTexture',wd,msh(mprest(nt)),[],tdr(lrt(nt),:));

% need this or the buffer screws up and at times doesn't present
% red box around chosen stimulus
WaitSecs(.01);	
Screen('Flip',wd,[],1);
WaitSecs(.01);	
Screen('Flip',wd,[],1);

t0=GetSecs;t=t0;

%.............. GET MOUSE INPUT

cht(nt)=NaN;buttons=[0 0 0 0];
% wait at most nogodelay seconds
while (t-t0 < nogodelay) & ~any(buttons);
	[x,y,buttons]=GetMouse;
	t=GetSecs;
end
treact(nt)=t0-t;

% need this or the buffer screws up and at times doesn't present
% red box around chosen stimulus
WaitSecs(.01);	

if ~any(buttons)	
	cht(nt) = 0;	% record nogo 
else		% if button was pressed 
	f1=find(x>drm(1:end,1) & x<=drm(1:end,3));	% find which box was clicked
	f2=find(y>drm(1,2) & y<=drm(1,4));	% assume only one row of stimuli!!!
	if ~isempty(f1) & ~isempty(f2);
		cht(nt)=f1+(f2-1)*2;
	else cht(nt)=NaN;							% if outside boxes, record NaN
	end

	% draw a red square around chosen stimulus, if clicked inside the box 
	if ~isnan(cht(nt)) & (approach & (cht(nt)==lrt(nt)) | ~approach & (cht(nt)==4-lrt(nt)) )
		Screen('DrawLines',wd,redbox,3,red);
		Screen('Flip',wd,[],1);
		WaitSecs(.01);
		Screen('Flip',wd);
		WaitSecs(.5);
	else
		cht(nt)=NaN;
		Screen('FillRect',wd,ones(1,3)*bgcol(1));
		if english
			txt={'Only click inside the blue box.'};
        elseif dutch
            txt={'Alleen in het blauwe vierkant klikken.'};
		else
			txt={'Nur in die blaue Box klicken.'};
		end
		displaytext(txt,wd,wdw,wdh,orange,0,1);
		WaitSecs(.7);
	end
end


%............ CORRECT? 


Screen('Fillrect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);

if ~isnan(cht(nt)) 
	if approach 
		if ainst(nt)==1; 	% go instruction 
			if     cht(nt)==lrt(nt); crt(nt) = 1;% correct approach go 
			elseif cht(nt)==0 ;      crt(nt) = 0;% incorrect approach nogo 
			end
		elseif ainst(nt)==2;	% nogo instruction 
			if     cht(nt)==0;       crt(nt) = 1;% correct approach nogo 
			elseif cht(nt)==lrt(nt); crt(nt) = 0;% incorrect approach go 
			end
		end
	elseif ~approach;	 % withdrawal
		if ainst(nt)==1; 	% go instruction 
			if     cht(nt)==4-lrt(nt);      crt(nt) = 1; % correct withdrawal go 
			elseif cht(nt)==0;       crt(nt) = 0; % incorrect nogo 
			end
		elseif ainst(nt)==2; 	% nogo instruction 
			if     cht(nt)==0;       crt(nt) = 1; % correct nogo 
			elseif cht(nt)==4-lrt(nt);      crt(nt) = 0; % incorrect withdrawal go 
			end
		end
	end
else
	crt(nt)=NaN;
end


%............ GIVE FEEDBACK 

if ~isnan(crt(nt))
	if crt(nt)==crtfb(nt);%(crt(nt) & crtfb(nt)) | (~crt(nt) & ~crtfb(nt))
		r(nt) = 1;	 % store rewards in vector r
		txt = {'+ 20 cent'};
		displaytext(txt,wd,wdw,wdh,green,0,0);
	else 
		r(nt) = -1;	 % store rewards in vector r
		txt = {'- 20 cent'};
		displaytext(txt,wd,wdw,wdh,red,0,0);
	end
else
	if english; txt = {'Invalid.'};
    elseif dutch; txt= {'Ongeldig.'};
	else;       txt = {'Ungueltig.'};
	end
	displaytext(txt,wd,wdw,wdh,red,0,0);
end


WaitSecs(.8);		% Delay before feedback switched off and we move on to little square to initiate next trial

checkabort; 		% Allow for abortion of experiment






