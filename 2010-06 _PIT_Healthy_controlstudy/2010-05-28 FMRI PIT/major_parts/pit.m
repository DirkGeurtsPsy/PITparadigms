ff.R=0;  
ff.T=0; 
ff.S=0;       
   t1=0;
   a=0;
tt=0;
TimeBP = [];
pixelpersec = windowRect(4)/durationInSeconds;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if start==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Track=O(8,nt); %Pick which side wall appears.
t=GetSecs;

if Bitsion==1
bitsi.sendTrigger(nt-Tr.Tot2+100);
end

T.PIT.Trstart(nt)=GetSecs-T.fmristart.PIT(block);
O(21,nt)=t;
%............. DRAW STIMULI 
% draw blue box 
tdr = drm; 
tdr(:,[2 4]) = tdr(:,[2,4]);
%draw rect in middle of screen:
tmp = [tdr(2,[1 3 3 1]); tdr(2,[2 2 4 4])];
redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
% draw mushroom 
tdr = drms; 
tdr(:,[2 4]) = tdr(:,[2,4]);

if O(24,nt)>0;
PsychPortAudio('Start', soundhandle(1),sounddur,0,1);
R=1;
elseif O(24,nt)==0;
PsychPortAudio('Start', soundhandle(3),sounddur,0,1);
R=3;
elseif O(24,nt)<0;
PsychPortAudio('Start', soundhandle(5),sounddur,0,1); 
R=5;
end

Screen('DrawTexture',wd,bgshape(1,O(23,nt)),[],bgr);
Screen('Flip',wd,[],1);
T.PIT.Cson(nt)=GetSecs-T.fmristart.PIT(block);
WaitSecs(0.24);

Screen('DrawTexture',wd,bgshape(1,O(23,nt)),[],bgr);
Screen('DrawTexture',wd,msh(1,O(3,nt)),[],hok);

% draw BW
if O(2,nt)==1
    if Track==1;
    xy=[0.65*widthwindowRect 0.65*widthwindowRect; 0 windowRect(4)];
    Screen('DrawLines',wd,xy,2,blue)%draw line right of field
    BW=1;
    mxf=0.35*widthwindowRect;
    else
    xy=[0.35*widthwindowRect 0.35*widthwindowRect; 0 windowRect(4)];
    Screen('DrawLines',wd,xy,2,blue) %draw line left of field
    BW=2;
    mxf=0.65*widthwindowRect;
    end
elseif O(2,nt)==2
    Track=3;
    if O(8,nt)==1
        xy=[0.65*widthwindowRect 0.65*widthwindowRect; 0 windowRect(4)];
        Screen('DrawLines',wd,xy,2,blue)%draw line right of field 
        BW=1;
        mxf=0.35*widthwindowRect;
    elseif O(8,nt)==2
            xy=[0.35*widthwindowRect 0.35*widthwindowRect; 0 windowRect(4)];
        Screen('DrawLines',wd,xy,2,blue) %draw line left of field
        BW=2;
        mxf=0.65*widthwindowRect;
    end
end

Screen('Flip',wd,[],1);
T.PIT.Ison(nt)=GetSecs-T.fmristart.PIT(block);
t0=GetSecs;
O(17,nt)=t0;
t=t0;
mx0=windowRect(3)*strtpnt(Track);
mx=mx0;

%Move dot upwards
    while t-t0<=durationInSeconds
        t=GetSecs;
        mx=mx-(mx-mx0)*movkey*Tresh.bp*Frq.Max/(RefreshRate*abs(mxf-mx0)); %to get dot back to the middle of the screen
        duration=t-t0;
        dist=randn*mltp;
        my=windowRect(4)-duration*pixelpersec;      %moving along y-axis
        tx=GetSecs;
        ty=tx;
        [ keyIsDown, timeSecs, keyCode ] = KbCheck; 
        if duration<(durationInSeconds-0.012)
        while (keyIsDown==0)&&(ty-tx<=0.013)
            ty=GetSecs;
            WaitSecs(0.0005);
        [keyIsDown, timeSecs, keyCode ] = KbCheck;
        end
        end
        t=GetSecs;
        if keyIsDown &&~keyCode(Trigger)         % adjustment by keypress
            ff.T=ff.T+1;
            TimeBP(ff.T)= GetSecs-T.fmristart.PIT(block);
            O(16,nt)=t;
            T.PIT.LBP(nt)=GetSecs-T.fmristart.PIT(block);
            if ff.R==0                                % record reaction time
                O(15,nt)=ty;
                O(9,nt)=ty-t0;
                t1=ty;
                ff.R=1;
            end
            if (O(2,nt)==1 & BW==2)|(O(2,nt)~=1 & BW==1)
                dist=dist-movkey;
            elseif (O(2,nt)==1 & BW==1)|(O(2,nt)~=1 & BW==2)
                dist=dist+movkey;
            end
            while KbCheck;                              % make sure that subject doesn't hold key, else invalid
                if (GetSecs-t)>=0.5;
                    a=1;
                    break
                end
            end
                if a==1                              %here pushing too long becomes invalid
                    break
                end 
        end
        mx=mx+dist; %x coordinate of spot is set.
   
        % Don't let spot move further than BW.
        if O(2,nt)==1
            if (Track==1) & (mx>=(xy(1,1)-spotRadius));
               mx=xy(1,1)-spotRadius;%don't let spot move further than line right of field
            elseif (Track==2) & (mx<=(xy(1,1)+spotRadius));
               mx=xy(1,1)+spotRadius;%don't let spot move further than line left of field
            end
        elseif O(2,nt)~=1
            if (BW==1) & (mx>=(xy(1,1)-spotRadius));
            mx=xy(1,1)-spotRadius; %don't let spot move further than line right of field 
            elseif (BW==2) & (mx<=(xy(1,1)+spotRadius));
            mx=xy(1,1)+spotRadius; %don't let spot move further than left of field
            end
        end
        % Don't let spot move outside the screen
        if mx<=0;
            mx=0+spotDiameter;
        end
        if mx>=wdw;
            mx=wdw-spotDiameter;
        end
        % set Dot in new position
        bottomspotRect=CenterRectOnPoint(spotRect,mx,my); %set spot to new coordinates.
        % evaluate position of dot
        if O(2,nt)==1
           if my<=0.1*windowRect(4) & IsInRect(mx,my,hok); % evaluate if dot is in Rect at the end
           ff.S=1;
           end
        elseif O(2,nt)==2
            if IsInRect(mx,my,[hok(1,1) hok(1,2) hok(1,3) 0.25*hok(1,4)]); % evaluate if spot is/has been in Rect in avoidance trial.
            ff.S=1;
            end
        end
        
        Screen('DrawTexture',wd,bgshape(1,O(23,nt)),[],bgr);
        Screen('DrawTexture',wd,msh(1,O(3,nt)),[],hok);
        Screen('FillOval', wd, [0 0 127], bottomspotRect);
        Screen('DrawLines',wd,xy,2,blue)
        Screen('Flip', wd);
        t=GetSecs;
        
    end
    
O(28,nt)=mx;
O(18,nt)=t;
O(14,nt)=ff.T;
O(10,nt)=ff.T/(t-t1);
T.PIT.Idone(nt)=GetSecs-T.fmristart.PIT(block);
test1=t;

Screen('Fillrect',wd,ones(1,3)*bgcol(1));
if dutch==1
txt = {'Uw saldo wordt bijgehouden.'};
elseif english==1
    txt={'Your account has been updated.'};
end
displaytext(txt,wd,wdw,wdh,black,0,0);


PsychPortAudio('Stop', soundhandle(R),2);



T.PIT.stopped(nt)=GetSecs-T.fmristart.PIT(block);

if ff.T==0
    O(11,nt)=0; %record nogo
elseif a==1 & ff.T~=0
    O(11,nt)=3;
elseif O(2,nt)==1 & ff.T~=0;% if button was pressed
    f1=ff.S;
    if f1==1 & a~=1 & ff.T~=0; 
        O(11,nt)=1;
    else O(11,nt)=2; %if pressed but approach did not reach box record NaN
    end
elseif O(2,nt)==2 & ff.T~=0; 
    f1=ff.S;
    if f1==1 & a~=1;
        O(11,nt)=2;
    else
        O(11,nt)=1;
    end
end


%% evaluation
if O(11,nt)==3;
       O(12,nt)= 3; % pushed button to long
elseif O(2,nt)==1 %If approach
        if O(4,nt)>=0; 	% positive value (=good stimulus)
			if     O(11,nt)==1;      O(12,nt)= 1;       % correct approach go 
			elseif O(11,nt)==0;      O(12,nt)= -1;      % incorrect approach nogo
            elseif O(11,nt)==2;      O(12,nt)= 1.5;     % correct approach, but ended to early.
			end
		elseif O(4,nt)<=0;	% negative value (=bad stimulus) 
			if     O(11,nt)==0;      O(12,nt) = 1;      % correct approach nogo 
			elseif O(11,nt)==1;      O(12,nt) = -1;     % incorrect approach go
            elseif O(11,nt)==2;      O(12,nt) = -1.5;   % incorrect approach, but ended early.
            end
		end
elseif O(2,nt)==2;	 % withdrawal
		if O(4,nt)<=0; 	% negative value (=bad stimulus)
			if     O(11,nt)==1;      O(12,nt) = 2;      % correct withdrawal go 
			elseif O(11,nt)==0;      O(12,nt) = -2;     % incorrect nogo
            elseif O(11,nt)==2;      O(12,nt) = 2.5;    % correct withdrawal, but ended early.
			end
		elseif O(4,nt)>=0;	% positive value (=good stimulus)
			if     O(11,nt)==0;      O(12,nt) = 2;      % correct nogo 
			elseif O(11,nt)==1;      O(12,nt) = -2;     % incorrect withdrawal go 
            elseif O(11,nt)==2;      O(12,nt) = -2.5;   % incorrect withdrawal, but ended early.
			end
        end
end

T.PIT.FBon(nt)=GetSecs-T.fmristart.PIT(block);

if O(11,nt)==1; %if person made go
    if O(5,nt)==1; % get reward feedback from Outcome matrix
  		O(13,nt) = 1;	 % feedback;
    elseif O(5,nt)==-1; % get reward feedback from Outcome matrix
		O(13,nt) = -1; % store rewards in O
	end
elseif O(11,nt)==0; %if person made nogo
	if  O(6,nt)==1; % get reward feedback from Outcome matrix
  		O(13,nt) = 1;	 % store rewards O
    elseif O(6,nt)==-1; % get reward feedback from Outcome matrix
		O(13,nt) = -1; % store rewards in O
    end
elseif O(11,nt)==2;
    O(13,nt)=0;
elseif O(11,nt)==3
    O(13,nt)=0;
end
T.PIT.evaluated(nt)=GetSecs-T.fmristart.PIT(block);

test2=GetSecs;
ws=0.74-(test2-test1);
WaitSecs(ws);		% Delay before feedback switched off and we move on to little square to initiate next trial
Screen('Flip', wd)
T.PIT.FBoff(nt)=GetSecs-T.fmristart.PIT(block);

t=GetSecs;
O(20,nt)=t;

WaitSecs(1);
t=GetSecs;
O(22,nt)=t;
T.PIT.End(nt)=GetSecs-T.fmristart.PIT(block);


BP{nt}=TimeBP;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif start==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Track=O2(8,nt); %Pick which side wall appears.
t=GetSecs;

if Bitsion==1
bitsi.sendTrigger(nt-Tr.Tot2+100);
end

T.PIT2.Trstart(nt)=GetSecs-T.fmristart.PIT(block);
O2(21,nt)=t;
%............. DRAW STIMULI 
% draw blue box 
tdr = drm; 
tdr(:,[2 4]) = tdr(:,[2,4]);
tmp = [tdr(2,[1 3 3 1]); tdr(2,[2 2 4 4])];
redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
% draw mushroom 
tdr = drms; 
tdr(:,[2 4]) = tdr(:,[2,4]);

if O2(24,nt)>0;
PsychPortAudio('Start', soundhandle(2),sounddur,0,1);
R=2;
elseif O2(24,nt)==0;
PsychPortAudio('Start', soundhandle(4),sounddur,0,1);
R=4;
elseif O2(24,nt)<0;
PsychPortAudio('Start', soundhandle(6),sounddur,0,1); 
R=6;
end

Screen('DrawTexture',wd,bgshape(2,O2(23,nt)),[],bgr);
Screen('Flip',wd,[],1);
T.PIT2.Cson2(nt)=GetSecs-T.fmristart.PIT(block);
WaitSecs(0.24);

Screen('DrawTexture',wd,bgshape(2,O2(23,nt)),[],bgr);
Screen('DrawTexture',wd,shll(1,O2(3,nt)),[],hok);

% draw BW
if O2(2,nt)==1
    if Track==1;
    xy=[0.65*widthwindowRect 0.65*widthwindowRect; 0 windowRect(4)];
    Screen('DrawLines',wd,xy,2,blue)%draw line right of field
    BW=1;
    mxf=0.35*widthwindowRect;
    else
    xy=[0.35*widthwindowRect 0.35*widthwindowRect; 0 windowRect(4)];
    Screen('DrawLines',wd,xy,2,blue) %draw line left of field
    BW=2;
    mxf=0.65*widthwindowRect;
    end
elseif O2(2,nt)==2
    Track=3;
    if O2(8,nt)==1
        xy=[0.65*widthwindowRect 0.65*widthwindowRect; 0 windowRect(4)];
        Screen('DrawLines',wd,xy,2,blue)%draw line right of field 
        BW=1;
        mxf=0.35*widthwindowRect;
    elseif O2(8,nt)==2
            xy=[0.35*widthwindowRect 0.35*widthwindowRect; 0 windowRect(4)];
        Screen('DrawLines',wd,xy,2,blue) %draw line left of field
        BW=2;
        mxf=0.65*widthwindowRect;
    end
end

Screen('Flip',wd,[],1);
T.PIT2.Ison(nt)=GetSecs-T.fmristart.PIT(block);
t0=GetSecs;
O2(17,nt)=t0;
t=t0;
mx0=windowRect(3)*strtpnt(Track);
mx=mx0;

%Move dot upwards
    while t-t0<=durationInSeconds
        t=GetSecs;
        mx=mx-(mx-mx0)*movkey*Tresh.bp*Frq.Max/(RefreshRate*abs(mxf-mx0)); %to get dot back to the middle of the screen
        duration=t-t0;
        dist=randn*mltp;
        my=windowRect(4)-duration*pixelpersec;      %moving along y-axis
        tx=GetSecs;
        ty=tx;
        [ keyIsDown, timeSecs, keyCode ] = KbCheck; 
        if duration<(durationInSeconds-0.012)
        while (keyIsDown==0)&&(ty-tx<=0.013)
            ty=GetSecs;
            WaitSecs(0.0005);
        [keyIsDown, timeSecs, keyCode ] = KbCheck;
        end
        end
        t=GetSecs;
        if keyIsDown &&~keyCode(Trigger)                                   % adjustment by keypress
            ff.T=ff.T+1;
            TimeBP(ff.T)= GetSecs-T.fmristart.PIT(block);
            O2(16,nt)=t;
            T.PIT2.LBP(nt)=GetSecs-T.fmristart.PIT(block);
            if ff.R==0                                % record reaction time
                O2(15,nt)=ty;
                O2(9,nt)=ty-t0;
                t1=ty;
                ff.R=1;
            end
            if (O2(2,nt)==1 & BW==2)|(O2(2,nt)~=1 & BW==1)
                dist=dist-movkey;
            elseif (O2(2,nt)==1 & BW==1)|(O2(2,nt)~=1 & BW==2)
                dist=dist+movkey;
            end
            while KbCheck;                              % make sure that subject doesn't hold key, else invalid
                if (GetSecs-t)>=0.5;
                    a=1;
                    break
                end
            end
                if a==1                              %here pushing too long becomes invalid
                    break
                end 
        end
        mx=mx+dist; %x coordinate of spot is set.
   
        % Don't let spot move further than BW.
        if O2(2,nt)==1
            if (Track==1) & (mx>=(xy(1,1)-spotRadius));
               mx=xy(1,1)-spotRadius;%don't let spot move further than line right of field
            elseif (Track==2) & (mx<=(xy(1,1)+spotRadius));
               mx=xy(1,1)+spotRadius;%don't let spot move further than line left of field
            end
        elseif O2(2,nt)~=1
            if (BW==1) & (mx>=(xy(1,1)-spotRadius));
            mx=xy(1,1)-spotRadius; %don't let spot move further than line right of field 
            elseif (BW==2) & (mx<=(xy(1,1)+spotRadius));
            mx=xy(1,1)+spotRadius; %don't let spot move further than left of field
            end
        end
        % Don't let spot move outside the screen
        if mx<=0;
            mx=0+spotDiameter;
        end
        if mx>=wdw;
            mx=wdw-spotDiameter;
        end
        % set Dot in new position
        bottomspotRect=CenterRectOnPoint(spotRect,mx,my); %set spot to new coordinates.
        % evaluate position of dot
        if O(2,nt)==1
           if my<=0.1*windowRect(4) & IsInRect(mx,my,hok); % evaluate if dot is in Rect at the end
           ff.S=1;
           end
        elseif O(2,nt)==2
            if IsInRect(mx,my,[hok(1,1) hok(1,2) hok(1,3) 0.25*hok(1,4)]); % evaluate if spot is/has been in Rect in avoidance trial.
            ff.S=1;
            end
        end
        
        Screen('DrawTexture',wd,bgshape(2,O2(23,nt)),[],bgr);
        Screen('DrawTexture',wd,shll(1,O2(3,nt)),[],hok);
        Screen('FillOval', wd, [0 0 127], bottomspotRect);
        Screen('DrawLines',wd,xy,2,blue)
        Screen('Flip', wd);
        t=GetSecs;
        
    end
    
O2(28,nt)=mx;
O2(18,nt)=t;
O2(14,nt)=ff.T;
O2(10,nt)=ff.T/(t-t1);
T.PIT2.Idone(nt)=GetSecs-T.fmristart.PIT(block);
test1=t;

Screen('Fillrect',wd,ones(1,3)*bgcol(1));
if dutch==1
txt = {'Uw saldo wordt bijgehouden.'};
elseif english==1
    txt={'Your account has been updated.'};
end
displaytext(txt,wd,wdw,wdh,black,0,0);


PsychPortAudio('Stop', soundhandle(R),2);

T.PIT2.stopped(nt)=GetSecs-T.fmristart.PIT(block);

if ff.T==0
    O2(11,nt)=0; %record nogo
elseif a==1 & ff.T~=0
    O2(11,nt)=3;
elseif O2(2,nt)==1 & ff.T~=0;% if button was pressed
    f1=ff.S;
    if f1==1 & a~=1 & ff.T~=0; 
        O2(11,nt)=1;
    else O2(11,nt)=2; %if pressed but approach did not reach box record NaN
    end
elseif O2(2,nt)==2 & ff.T~=0; 
    f1=ff.S;
    if f1==1 & a~=1;
        O2(11,nt)=2;
    else
        O2(11,nt)=1;
    end
end

%% evaluation
if O2(11,nt)==3;
       O2(12,nt)= 3; % pushed button to long
elseif O2(2,nt)==1 %If approach
        if O2(4,nt)>=0; 	% positive value (=good stimulus)
			if     O2(11,nt)==1;      O2(12,nt)= 1;       % correct approach go 
			elseif O2(11,nt)==0;      O2(12,nt)= -1;      % incorrect approach nogo
            elseif O2(11,nt)==2;      O2(12,nt)= 1.5;     % correct approach, but ended to early.
			end
		elseif O2(4,nt)<=0;	% negative value (=bad stimulus) 
			if     O2(11,nt)==0;      O2(12,nt) = 1;      % correct approach nogo 
			elseif O2(11,nt)==1;      O2(12,nt) = -1;     % incorrect approach go
            elseif O2(11,nt)==2;      O2(12,nt) = -1.5;   % incorrect approach, but ended early.
            end
		end
elseif O2(2,nt)==2;	 % withdrawal
		if O2(4,nt)<=0; 	% negative value (=bad stimulus)
			if     O2(11,nt)==1;      O2(12,nt) = 2;      % correct withdrawal go 
			elseif O2(11,nt)==0;      O2(12,nt) = -2;     % incorrect nogo
            elseif O2(11,nt)==2;      O2(12,nt) = 2.5;    % correct withdrawal, but ended early.
			end
		elseif O2(4,nt)>=0;	% positive value (=good stimulus)
			if     O2(11,nt)==0;      O2(12,nt) = 2;      % correct nogo 
			elseif O2(11,nt)==1;      O2(12,nt) = -2;     % incorrect withdrawal go 
            elseif O2(11,nt)==2;      O2(12,nt) = -2.5;   % incorrect withdrawal, but ended early.
			end
        end
end

T.PIT2.FBon(nt)=GetSecs-T.fmristart.PIT(block);

if O2(11,nt)==1; %if person made go
    if O2(5,nt)==1; % get reward feedback from Outcome matrix
  		O2(13,nt) = 1;	 % feedback;
    elseif O2(5,nt)==-1; % get reward feedback from Outcome matrix
		O2(13,nt) = -1; % store rewards in O
	end
elseif O2(11,nt)==0; %if person made nogo
	if  O2(6,nt)==1; % get reward feedback from Outcome matrix
  		O2(13,nt) = 1;	 % store rewards O
    elseif O2(6,nt)==-1; % get reward feedback from Outcome matrix
		O2(13,nt) = -1; % store rewards in O
    end
elseif O2(11,nt)==2;
    O2(13,nt)=0;
elseif O2(11,nt)==3
    O2(13,nt)=0;
end

test2=GetSecs;
ws=0.74-(test2-test1);
WaitSecs(ws);		% Delay before feedback switched off and we move on to little square to initiate next trial
Screen('Flip', wd)
T.PIT2.FBoff(nt)=GetSecs-T.fmristart.PIT(block);

t=GetSecs;
O2(20,nt)=t;

WaitSecs(1);
t=GetSecs;
O2(22,nt)=t;


T.PIT2.End(nt)=GetSecs-T.fmristart.PIT(block);

BP2{nt}=TimeBP;
end

checkabort; 		% Allow for abortion of experiment