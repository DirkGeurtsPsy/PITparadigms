%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if start==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% count the number of queries 
T.comp.start=GetSecs-T.fmristart.pav(block);
% draw Pavlovian stimulus 1 
Screen('DrawTexture',wd,shape(1,Co(2,Q)),[],dr(1,:));
Screen('DrawTexture',wd,shape(1,Co(3,Q)),[],dr(2,:));



if dutch==1
text{1}='Kies het beste plaatje met de linker of rechter toets';
elseif english==1
text{1}='Choose the best picture with the left or right button'; 
end

[wt]=Screen(wd,'TextBounds',text{1});
Screen('Fillrect',wd,150,[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,wdh-y0/2,red);
Screen('Flip',wd,[]);
T.comp.drwscrn=GetSecs-T.fmristart.pav(block);;

WaitSecs(0.3)

t0=GetSecs;
tx=t0;

wrong=0;

while (tx-t0)<choiceduration
    tx=GetSecs;
    ty=tx;
    [keyIsDown, timeSecs, keyCode ] = KbCheck;
        while (keyIsDown==0)&&(ty-tx<=0.013)
            ty=GetSecs;
            WaitSecs(0.0005);
        [keyIsDown, timeSecs, keyCode ] = KbCheck;
        end
        if keyCode(leftKey)||keyCode(button49)
        Co(4,Q)=1;
        T.Comp2.react(np)=timeSecs;
        tmp = [dr(Co(4,Q),[1 3 3 1]); dr(Co(4,Q),[2 2 4 4])];	 
        Screen('DrawTexture',wd,shape(1,Co(2,Q)),[],dr(1,:));
        Screen('DrawTexture',wd,shape(1,Co(3,Q)),[],dr(2,:));
        redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
        Screen('DrawLines',wd,redbox,2,red);
        Screen('Flip',wd,[],1);
        end
    if keyCode(rightKey)||keyCode(button50)
        Co(4,Q)=2;
        T.Comp2.react(np)=timeSecs;
        tmp = [dr(Co(4,Q),[1 3 3 1]); dr(Co(4,Q),[2 2 4 4])];	 
        Screen('DrawTexture',wd,shape(1,Co(2,Q)),[],dr(1,:));
        Screen('DrawTexture',wd,shape(1,Co(3,Q)),[],dr(2,:));
        redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
        Screen('DrawLines',wd,redbox,2,red);
        Screen('Flip',wd,[],1);
    end
    
    
% 	% Make sure one of the available machines was chosen 
% 	if isnan(Co(4,Q)) % | ~isempty(setdiff(ch,slm));
% 		if dutch==1
%         text='Kies het beste plaatje met de linker of rechter toets';
%         elseif english==1
%         text='Choose the best picture with the left or right button'; 
%         end
% 		[wt]=Screen(wd,'TextBounds',text);
% 		Screen('Fillrect',wd,[150],[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
% 		Screen('Drawtext',wd,text,wdw/2-wt(3)/2,wdh-y0/2,red);
% 		Screen('Flip', wd,[],1);
% 		t=GetSecs;
% 	end
% 	if ~isnan(Co(4,Q));
% 		Screen('Fillrect',wd,bgcol(1),[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
% 		Screen('Flip', wd,[],1);
% 	end
	checkabort; % Allow for abortion of experiment
end

T.comp.FB=GetSecs-T.fmristart.pav(block);;

WaitSecs(0.5);

Screen('FillRect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);
WaitSecs(1);

T.comp.end=GetSecs-T.fmristart.pav(block);;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif start==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% count the number of queries 
T.comp2.start=GetSecs-T.fmristart.pav(block);;
% draw Pavlovian stimulus 1 
Screen('DrawTexture',wd,shape(2,Co2(2,Q)),[],dr(1,:));
Screen('DrawTexture',wd,shape(2,Co2(3,Q)),[],dr(2,:));



if dutch==1
text{1}='Kies het beste plaatje met de linker of rechter toets';
elseif english==1
text{1}='Choose the best picture with the left or right button'; 
end

[wt]=Screen(wd,'TextBounds',text{1});
Screen('Fillrect',wd,150,[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,wdh-y0/2,red);
Screen('Flip',wd,[]);
T.comp2.drwscrn(np)=GetSecs-T.fmristart.pav(block);

WaitSecs(0.3)

t0=GetSecs;
tx=t0;

wrong=0;

while (tx-t0)<choiceduration
    tx=GetSecs;
    ty=tx;
    [keyIsDown, timeSecs, keyCode ] = KbCheck;
        while (keyIsDown==0)&&(ty-tx<=0.013)
            ty=GetSecs;
            WaitSecs(0.0005);
        [keyIsDown, timeSecs, keyCode ] = KbCheck;
        end
        if keyCode(leftKey)||keyCode(button49)
        Co2(4,Q)=1;
        T.Comp2.react(np)=timeSecs;
        tmp = [dr(Co2(4,Q),[1 3 3 1]); dr(Co2(4,Q),[2 2 4 4])];	 
        Screen('DrawTexture',wd,shape(2,Co2(2,Q)),[],dr(1,:));
        Screen('DrawTexture',wd,shape(2,Co2(3,Q)),[],dr(2,:));
        redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
        Screen('DrawLines',wd,redbox,2,red);
        Screen('Flip',wd,[],1);
        end
    if keyCode(rightKey)||keyCode(button50)
        Co2(4,Q)=2;
        T.Comp2.react(np)=timeSecs;
        tmp = [dr(Co2(4,Q),[1 3 3 1]); dr(Co2(4,Q),[2 2 4 4])];	 
        Screen('DrawTexture',wd,shape(2,Co2(2,Q)),[],dr(1,:));
        Screen('DrawTexture',wd,shape(2,Co2(3,Q)),[],dr(2,:));
        redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
        Screen('DrawLines',wd,redbox,2,red);
        Screen('Flip',wd,[],1);
    end
    
    
% 	% Make sure one of the available machines was chosen 
% 	if isnan(Co(4,Q)) % | ~isempty(setdiff(ch,slm));
% 		if dutch==1
%         text='Kies het beste plaatje met de linker of rechter toets';
%         elseif english==1
%         text='Choose the best picture with the left or right button'; 
%         end
% 		[wt]=Screen(wd,'TextBounds',text);
% 		Screen('Fillrect',wd,[150],[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
% 		Screen('Drawtext',wd,text,wdw/2-wt(3)/2,wdh-y0/2,red);
% 		Screen('Flip', wd,[],1);
% 		t=GetSecs;
% 	end
% 	if ~isnan(Co(4,Q));
% 		Screen('Fillrect',wd,bgcol(1),[wdw/2-wt(3) wdh-y0/2-3/5*wt(2) wdw/2+wt(3) wdh-y0/2+wt(4)+wt(4)]);
% 		Screen('Flip', wd,[],1);
% 	end
	checkabort; % Allow for abortion of experiment
end

T.comp2.FB(np)=GetSecs-T.fmristart.pav(block);;

WaitSecs(.5);

Screen('FillRect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);
WaitSecs(1);

T.comp2.end(np)=GetSecs-T.fmristart.pav(block);;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

checkabort; % Allow for abortion of experiment

