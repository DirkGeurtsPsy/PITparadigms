Callibrationtime=2.5;

% displaytext
    if dutch==1
    text={'Druk op de drukknop','om door de instructies','heen te lopen.','(Druk op een toets om verder te gaan)'};
    elseif english==1
    text={'Push a button to','walk through the instructions','(Push a button to proceeed)'};    
    end
	displaytext(text,wd,wdw,wdh,orange,1,0);
    
    if dutch==1   
    text={'Ik zou u willen vragen','een stip zo snel mogelijk ','naar rechts te bewegen.','(Druk op een toets om verder te gaan)'};
    elseif english==1
    text={'I will ask you to move a spot','as far to the right as you can.','(Push a button to proceed)'};    
    end
	displaytext(text,wd,wdw,wdh,orange,1,0);
    
    if dutch==1
    text={'Dit doet u,','door zo snel mogelijk op de knop','te drukken.','(Druk op een toets om verder te gaan)'};
    elseif english==1
    text={'You can do this','by pressing as fast as possible','on the button.','(Push a button to proceed)'};    
    end
	displaytext(text,wd,wdw,wdh,orange,1,0);
    
    if dutch==1
    text={'Wij gaan meten','hoe snel u dit kan.','Druk op een toets om te beginnen.'};
    elseif english==1
    text={'After the break the second part','of the experiment will start.','(Push a button to sproceed)'};    
    end
	displaytext(text,wd,wdw,wdh,orange,1,0);   
    
    if dutch==1
    text={'Klaar voor de start!'};
    elseif english==1
    text={'ready to go!'};    
    end
    
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
    mx0=windowRect(3)/2;
    mx=mx0;
    bottomspotRect=CenterRectOnPoint(spotRect,mx,0.5*wdh); %set spot to new coordinates.
    Screen('FillOval', wd, [0 0 127], bottomspotRect);
Screen('Flip', wd);
WaitSecs(1)

for R=1:3;
  if dutch==1
    text={'Start!'};
    elseif english==1
    text={'GO!'};    
  end
    
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
    bottomspotRect=CenterRectOnPoint(spotRect,mx,0.5*wdh); %set spot to new coordinates.
    Screen('FillOval', wd, [0 0 127], bottomspotRect);
Screen('Flip', wd);
  
% start callibration after first button press
ff.P=0;
KbWait;
t0=GetSecs;
t=t0;
a=0;    

while t-t0<=(Callibrationtime+1)
        WaitSecs(1/RefreshRate);
        t=GetSecs;
        mx=(mx-mx0)/1.25*div+mx0;                        %to get dot back to the middle of the screen
        duration=t-t0;
        dist=randn*mltp;
        my=0.5*windowRect(4);      %moving along y-axis
        tx=GetSecs;
        ty=tx;
        [ keyIsDown, timeSecs, keyCode ] = KbCheck; 
        while (keyIsDown==0)&&(ty-tx<=0.013)
            ty=GetSecs;
            WaitSecs(0.0005);
        [keyIsDown, timeSecs, keyCode ] = KbCheck;
        end
        if keyIsDown                                  % adjustment by keypress
            mx=mx+movkey;
            if t-t0>=1
            ff.P=ff.P+1;
            Tijd(R,ff.P) = GetSecs;
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
   
        % Don't let spot move outside the screen
        if mx<=0;
            mx=0+spotRadius;
        end
        if mx>=wdw;
            mx=wdw-spotRadius;
        end

        % set Dot in new position
        bottomspotRect=CenterRectOnPoint(spotRect,mx,0.5*wdh); %set spot to new coordinates.
        Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
        Screen('FillOval', wd, [0 0 127], bottomspotRect);
        Screen('Flip', wd);
end

Frq.fr(R)=ff.P/Callibrationtime;
mx=mx0;
Frq.Max=max(Frq.fr);

if R==1
    if dutch==1
    text={'Zeer goed!','Dit doen we nog tweemaal.','Druk op een knop','om weer te beginnen'};
    elseif english==1
    text={'Good job!','We will do this another two times.','Push the button to start again'};    
    end
    displaytext(text,wd,wdw,wdh,orange,1,0);
WaitSecs(1);
KbWait;
end

if R==2
    if dutch==1
    text={'Zeer goed!','Dit doen we nog eenmaal.','Druk op een knop','om weer te beginnen'};
    elseif english==1
    text={'Good job!','We will do this one other time again.','Push the button to start again'};    
    end
	displaytext(text,wd,wdw,wdh,orange,1,0);
WaitSecs(1);
KbWait;
end

if R==3
    if dutch==1
    text={'Dank u wel!','We gaan nu door','met de rest','van het experiment','(Druk op een toets om verder te gaan)'};
    elseif english==1
    text={'Thank you!','We can continue now','with the rest of the experiment.','(Push a button to sproceed)'};    
    end
	displaytext(text,wd,wdw,wdh,orange,1,0);
WaitSecs(1);
KbWait;
end

if Frq.Max>=7
    Frq.Max=7;
end

end



return