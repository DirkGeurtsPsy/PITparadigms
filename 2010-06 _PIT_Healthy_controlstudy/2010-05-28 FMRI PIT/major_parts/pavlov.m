%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if start==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% draw the Pavlovian stimulus 
Screen('DrawTexture',wd,bgshape(1,O(3,np)),[],bgr);
Screen('Flip',wd,[],1);

T.Pav.start(np)=GetSecs-T.fmristart.pav(block);

if Bitsion==1
bitsi.sendTrigger(np-Tr.TotInst);
end

if O(4,np)>0;
PsychPortAudio('Start', soundhandle(1),sounddur,0,1);
R=1;
elseif O(4,np)==0;
PsychPortAudio('Start', soundhandle(3),sounddur,0,1);
R=3;
elseif O(4,np)<0;
PsychPortAudio('Start', soundhandle(5),sounddur,0,1); 
R=5;
end

T.Pav.aftsnd(np)=GetSecs-T.fmristart.pav(block);

wt=0.5-T.Pav.aftsnd(np);
WaitSecs(wt); 
wait=rand;
WaitSecs(wait);


T.Pav.aftwt(np)=GetSecs-T.fmristart.pav(block);

if money==1;
    if O(4,np)>0;
    text={'U WINT 1.00 euro!'};
    X=red;
    O(13,np)=1;
    elseif O(4,np)==0;
    text={'Uw saldo blijft GELIJK.'};
    X=red;
    O(13,np)=0;
    elseif O(4,np)<0;
    text={'U VERLIEST 1.00 euro!'};
    X=red;
    O(13,np)=-1;
    end
[wt]=Screen(wd,'TextBounds',text{1});
xpos=wdw/2-wt(3)/2;
ypos=wdh/2;
Screen('DrawTexture',wd,bgshape(1,O(3,np)),[],bgr);
Screen('Drawtext',wd,text{1},xpos,ypos,X);
Screen('Flip',wd,[]);

T.Pav.afttext(np)=GetSecs-T.fmristart.pav(block);

elseif juice==1;
    if O(7,np)==1 & O(4,np)>0;
        fprintf('............. LEKKER\n')
          if COM~=0;
            stepdos.runPump(1);
          end
    elseif O(7,np)==1 & O(4,np)<0;
        fprintf('............. VIES\n')
          if COM~=0;
            stepdos.runPump(2);
          end
    elseif O(7,np)==1 & O(4,np)==0;
         fprintf('............. IK PROEF NIETS!\n')
          if COM~=0;
            stepdos.runPump(3);
          end
    elseif O(7,np)==0;
        fprintf('............. GELUKKIG IK KRIJG NIETS!\n')
    end
end
T.Pav.aftjuice(np)=GetSecs-T.fmristart.pav(block);

WaitSecs(4-wait);

T.Pav.aft4wt(np)=GetSecs-T.fmristart.pav(block);

t1=GetSecs;
PsychPortAudio('Stop', soundhandle(R),2);
Screen('FillRect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);
t2=GetSecs;
ws=1-(t2-t1);
WaitSecs(ws);

T.Pav.end(np)=GetSecs-T.fmristart.pav(block);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif start==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% draw the Pavlovian stimulus 
Screen('DrawTexture',wd,bgshape(2,O2(3,np)),[],bgr);
Screen('Flip',wd,[],1);

T.Pav2.start(np)=GetSecs-T.fmristart.pav(block);

if Bitsion==1
bitsi.sendTrigger(np-Tr.TotInst);
end

if O2(4,np)>0;
PsychPortAudio('Start', soundhandle(2),sounddur,0,1);
R=2;
elseif O2(4,np)==0;
PsychPortAudio('Start', soundhandle(4),sounddur,0,1);
R=4;
elseif O2(4,np)<0;
PsychPortAudio('Start', soundhandle(6),sounddur,0,1); 
R=6;
end

T.Pav2.aftsnd(np)=GetSecs-T.fmristart.pav(block);

wt=0.5-T.Pav2.aftsnd(np);
WaitSecs(wt); 
wait=rand;
WaitSecs(wait);
    
T.Pav2.aftwt(np)=GetSecs-T.fmristart.pav(block);

if money==1;
    if O2(4,np)>0;
    text={'U WINT 1.00 euro!'};
    X=red;
    O2(13,np)=1;
    elseif O2(4,np)==0;
    text={'Uw saldo blijft GELIJK.'};
    X=red;
    O2(13,np)=0;
    elseif O2(4,np)<0;
    text={'U VERLIEST 1.00 euro!'};
    X=red;
    O2(13,np)=-1;
    end
[wt]=Screen(wd,'TextBounds',text{1});
xpos=wdw/2-wt(3)/2;
ypos=wdh/2;
Screen('DrawTexture',wd,bgshape(2,O2(3,np)),[],bgr);
Screen('Drawtext',wd,text{1},xpos,ypos,X);
Screen('Flip',wd,[]);


elseif juice==1;
    if O2(7,np)==1 & O2(4,np)>0;
        fprintf('............. LEKKER\n')
        if COM~=0;
            stepdos.runPump(1);
        end
    elseif O2(7,np)==1 & O2(4,np)<0;
        fprintf('............. VIES\n')
        if COM~=0;
            stepdos.runPump(2);
        end
    elseif O2(7,np)==1 & O2(4,np)==0;
         fprintf('............. IK PROEF NIETS!\n')
        if COM~=0;
            stepdos.runPump(3);
        end
    elseif O2(7,np)==0;
        fprintf('............. GELUKKIG IK KRIJG NIETS!\n')
    end
end
T.Pav2.aftjuice(np)=GetSecs-T.fmristart.pav(block);

WaitSecs(4-wait);

T.Pav2.aft4wt(np)=GetSecs-T.fmristart.pav(block);

t1=GetSecs;
PsychPortAudio('Stop', soundhandle(R),2);
Screen('FillRect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);
t2=GetSecs;
ws=1-(t2-t1);
WaitSecs(ws);

T.Pav2.end(np)=GetSecs-T.fmristart.pav(block);

end
% Allow for abortion of experiment
checkabort;
