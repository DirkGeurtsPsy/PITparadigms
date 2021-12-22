% % draw blue box 
tdr=drm; 


%draw rect in middle of screen:
tmp = [tdr(2,[1 3 3 1]); tdr(2,[2 2 4 4])];

%draw BW
xy=[tmp(1,1) tmp(1,1); tmp(2,1)  windowRect(4)];
Screen('DrawLines',wd,xy,2,blue) %draw line left of field
BW=2;

t0=GetSecs;t=t0;
mx0=windowRect(3)*strtpnt(3);
mx=mx0;
pixelpersec       = windowRect(4)/durationInSeconds;
    while t-t0<=durationInSeconds
        t=GetSecs;
        mx=(mx-mx0)/div+mx0;                        %to get dot back to the middle of the screen
        duration=t-t0;
        dist=randn*mltp;
        my=windowRect(4)-duration*pixelpersec;      %moving along y-axis
        mx=mx+dist;
        bottomspotRect=CenterRectOnPoint(spotRect,mx,my);
        if IsInRect(mx,my,drms(2,:)); % evaluate if dot is in Rect
           tmp.S=1;
        end
        if start==1
        Screen('DrawTexture',wd,trn(1,2),[],tdr(2,:));
        elseif start==0
        Screen('DrawTexture',wd,trns(1,2),[],tdr(2,:));
        end
        Screen('FillOval', wd, [0 0 127], bottomspotRect);
        Screen('DrawLines',wd,xy,2,blue)
        Screen('Flip', wd);

    end

return