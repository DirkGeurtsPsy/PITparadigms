if R==1
Track=1; %Pick which side wall appears.
elseif R==2
Track=2;
elseif R==3||R==4
    Track=3;
end

TimeBP=[];
pixelpersec = windowRect(4)/durationInSeconds;
ff.R=0;  
ff.T=0;
ff.F=0;       
ff.S=0;       
   t1=0;
   a=0;
D=[];
G=0;


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

if start==1
Screen('DrawTexture',wd,trn(1,R),[],hok);
elseif start==0
Screen('DrawTexture',wd,trns(1,R),[],hok); 
end

if Track==1;
    xy=[0.65*widthwindowRect 0.65*widthwindowRect; 0 windowRect(4)];
    Screen('DrawLines',wd,xy,2,blue)%draw line right of field
    BW=1;
    mxf=0.35*widthwindowRect;
elseif Track==2;
    xy=[0.35*widthwindowRect 0.35*widthwindowRect; 0 windowRect(4)];
    Screen('DrawLines',wd,xy,2,blue) %draw line left of field
    BW=2;
    mxf=0.65*widthwindowRect;
end
if    Track==3;
    if R==3;
        xy=[0.65*widthwindowRect 0.65*widthwindowRect; 0 windowRect(4)];
        Screen('DrawLines',wd,xy,2,blue)%draw line right of field 
        BW=1;
        mxf=0.35*widthwindowRect;
    elseif R==4;
            xy=[0.35*widthwindowRect 0.35*widthwindowRect; 0 windowRect(4)];
        Screen('DrawLines',wd,xy,2,blue) %draw line left of field
        BW=2;
        mxf=0.65*widthwindowRect;
    end
end

Screen('Flip',wd,[],1);
t0=GetSecs;
t=t0;
mx0=windowRect(3)*strtpnt(Track);
mx=mx0;

       while t-t0<=durationInSeconds
        t=GetSecs;
        mx=mx-(mx-mx0)*movkey*Tresh.bp*Frq.Max/(RefreshRate*abs(mxf-mx0)); %to get dot back to the middle of the screen
        duration=t-t0;
        dist=randn*mltp;
        my=windowRect(4)-duration*pixelpersec;      %moving along y-axis
        tx=GetSecs;
        ty=tx;
        [ keyIsDown, timeSecs, keyCode ] = KbCheck; 
        if duration<(durationInSeconds-0.013)
        while (keyIsDown==0)&&(ty-tx<=0.013)
            ty=GetSecs;
            WaitSecs(0.0005);
        [keyIsDown, timeSecs, keyCode ] = KbCheck;
        end
        end
        t=GetSecs;
        if keyIsDown                                  % adjustment by keypress
            ff.T=ff.T+1;
        if (Track==3 && BW==1)||(Track~=3&&BW==2)
                dist=dist-movkey;
            elseif (Track==3 && BW==2)||(Track~=3 && BW==1)
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
        if R==1||R==2
            if (Track==1) && (mx>=(xy(1,1)-spotRadius));
               mx=xy(1,1)-spotDiameter;%don't let spot move further than line right of field
            elseif (Track==2) && (mx<=(xy(1,1)+spotRadius));
               mx=xy(1,1)+spotDiameter;%don't let spot move further than line left of field
            end
        elseif R==3||R==4
            if (BW==1) && (mx>=(xy(1,1)-spotRadius));
            mx=xy(1,1)-spotRadius; %don't let spot move further than line right of field 
            elseif (BW==2) && (mx<=(xy(1,1)+spotRadius));
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
         if R==1||R==2
           if my<=0.1*windowRect(4) && IsInRect(mx,my,drm(2,:)); % evaluate if dot is in Rect at the end
           ff.S=1;
           end
        elseif R==3||R==4
            if IsInRect(mx,my,[drm(2,[1 2 3]) drm(2,4)/2]); % evaluate if spot is/has been in Rect in avoidance trial.
            ff.S=1;
            end
        end
        
        if start==1
            Screen('DrawTexture',wd,trn(1,R),[],hok);
        elseif start==0
            Screen('DrawTexture',wd,trns(1,R),[],hok); 
        end
        Screen('FillOval', wd, [0 0 127], bottomspotRect);
        Screen('DrawLines',wd,xy,2,blue)
        Screen('Flip', wd);
        t=GetSecs;
        
       end

Screen('Fillrect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);

%............ GIVE FEEDBACK 
txt = {'U krijgt geen feedback','u bent aan het oefenen.'};
displaytext(txt,wd,wdw,wdh,red,0,0);

WaitSecs(0.98);		% Delay before feedback switched off and we move on to little square to initiate next trial
Screen('Flip', wd)
WaitSecs(1);
checkabort; 		% Allow for abortion of experiment
