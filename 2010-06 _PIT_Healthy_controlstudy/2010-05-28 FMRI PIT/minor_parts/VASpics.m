% Use this as VAS for received drinks. Give Ss 3 drops of first the nasty,
% then the nice juice. Nasty first to avoid the bad aftertaste
% =========================================================================


% % =========================================================================
% % UNCOMMENT WHEN USING AS STANDALONE. DON'T FORGET THE LAST 'CLOSE
% % SCREEN' BIT.
% 
% % Use when in debugging mode
% % wd      = Screen('OpenWindow', 0, [0 0 0], [0 0 1000 800]);
% % Use when in run mode
% wd = Screen('OpenWindow', 0, [0 0 0], []);
% HideCursor;     
% 
% % get the size of the screen
% prep.draw.font      = 'Arial';
% prep.draw.txtsize   = 25;
% prep.lang           = 'eng';
% prep.draw.Ncol      = [160 160 160];
% prep.draw.Sqcol     = [150 0 255];
% prep.draw.dropcol   = [0 0 255];
% barcol   = [255 200 0];
% prep.comP           = 0;
% Screen('Preference','Verbosity',0);
% Screen(wd,'TextStyle',1); % Bold
% Screen(wd,'TextFont',prep.draw.font);
% Screen(wd,'TextSize',prep.draw.txtsize);
% prep.left   = 65;
% prep.right  = 83;
% prep.confirm= 68;
% VASrep      = 1;
% %=========================================================================

% spacing     = 2; % distance between lines, in multiples of textsize
% [wdw, wdh]  = [widthwindowRect,heightwindowRect] ;
scalecol    = [160 160 160];
barcol      = [255 200 0];
slider      = [0 0 10 50];
stepsize    = 16; %stepsize of the slider
% position of the VAS scale
xaxis       = [0.1*wdw 0.9*wdw; 0.7*wdh 0.7*wdh];
yleft       = [0.1*wdw 0.1*wdw; 0.65*wdh 0.75*wdh];
ymid        = [0.5*wdw 0.5*wdw; 0.65*wdh 0.75*wdh];
yright      = [0.9*wdw 0.9*wdw; 0.65*wdh 0.75*wdh];
top         = wdh/12; 

% present black screen for sec before starting
Screen('FillRect',wd,bgcol(1));
Screen('Flip', wd);
WaitSecs(0.2);

% =========================================================================
% Display instructions

if dutch==1
    text{1} = {'SMAAK BEOORDELEN'};
    text{2} = {'Je gaat nu eerst de smaak van de sappen beoordelen.'};
    text{3} = {'Je proeft dadelijk eerst een beetje van het bittere sap.',...
        'Vervolgens kan je met de slider op een scorebalk',...
        'aangeven hoe lekker je dit drankje vond.',...
        'Daarna krijg je het zoete sap te proeven',...
        'dan beoordeel je die ook.'};
    text{4} = {'Het scoren doe je door een cursor met de drukknoppen','naar links en rechts te bewegen.'};
elseif english==1
    text{1} = {'TASTE RATING'};
    text{2} = {'You will first receive the bitter and sweet juices','to rate their taste.'};
    text{3} = {'First you receive the bitter juice. You then indicate',... 
        'on a rating scale how you liked this drink.',...
        'Next you will receive the sweet juice to taste, ','which you then also rate.'};
    text{4} = {'The ratings are done by moving the cursor,', 'using the left and right buttons.'};    
end

for t = 1:4
    displaytext(text{t},wd,wdw,wdh,orange,0,0);
    waitsecs(0.2);
    mygetclicks;
end

% Give subject First the nasty, then the nice one. In this order so they
% don't have to sit around with the disgusting taste in their mouth for too
% long.
for s=1:2
    bottomslider=CenterRectOnPoint(slider,0.5*wdw,0.6*wdh); % starting position slider
    xpos          = 0.5*wdw;
    
    if dutch==1
        text{1}={'Je krijgt nu het bittere sapje tweemaal toegediend',...
            '(met korte tussenpozen)','Proef het goed.'};
        text{2}={'Je krijgt nu het zoete sapje tweemaal toegediend',...
            '(met korte tussenpozen)','Proef het goed.'};
    elseif english==1
        text{1}={'You will now receive the bitter juice two times',...
            '(with short breaks in between).','Taste it well.'};
        text{2}={'You will now receive the sweet juice two times',...
            '(with short breaks in between).','Taste it well.'};
    end
    
    displaytext(text{s},wd,wdw,wdh,orange,0,0);
    waitsecs(0.2);
    mygetclicks;
    for i=1:2
        if s==1; fprintf('............. NASTY\n');
        elseif s==2; fprintf('............. NICE\n');
        end
        if COM~=0;
            stepdos.runPump(abs(s-3)); %run first pump 2, then pump 1
            WaitSecs(3);
        end
    end
    
    % Let the subject evaluate the juice by moving the slider
    while true
        if dutch==1
            txt1 = {'Verplaats de balk met de linker (wijsvinger)',...
                'en rechter (middelvinger) druktoetsen',...
                'naar de plek die je vindt passen bij de smaak',... 
                'van het sapje.'...
                'Druk dan op bevestigingstoets (ringvinger)'};
            txt2 = {'Heel vies','Neutraal','Heel lekker'};
                txt3 = {'Druk nogmaals om te bevestigen,'...
                'of links of rechts om de balk te verplaatsen'};
            
        elseif english==1
        end
            nrow=length(txt1);
        for k=1:nrow
            [wt]=Screen(wd,'TextBounds',txt1{k});
            xpos1=wdw/2-wt(3)/2;
            ypos1=0.1*wdh+2*k*wt(4);
            Screen('Drawtext',wd,txt1{k},xpos1,ypos1,orange);
        end
        
        Screen('DrawText',wd,txt2{1},0.1*wdw,0.8*wdh,barcol);
        [wt] = Screen(wd,'TextBounds',txt2{2});
        Screen('DrawText',wd,txt2{2},0.5*wdw-wt(3)/2,0.8*wdh,barcol);
        [wt] = Screen(wd,'TextBounds',txt2{3});
        Screen('DrawText',wd,txt2{3},0.9*wdw-wt(3),0.8*wdh,barcol);
        
        Screen('DrawLines',wd,xaxis,2,scalecol);%draw scale
        Screen('Drawlines',wd,yleft,2,scalecol);
        Screen('Drawlines',wd,ymid,2,scalecol);
        Screen('Drawlines',wd,yright,2,scalecol);
        
        Screen('FillRect', wd, barcol, bottomslider);
        Screen('Flip', wd,[],1);
        
        % check whether they've pressed a key
        % if they did, move the slider.
        KbWait;
        [ keyIsDown, timeSecs, keyCode ] = KbCheck;
        if keyCode(leftKey)|keyCode(button49)
            xpos=xpos-stepsize;
            %     dd   sssssssssdd  slightly silly bit of trick code needed because the previous
            % flip doesn't remove the background so I can add the
            % confirmation question...
            txt = {' '};
            Screen('DrawText',wd,txt{1},wdw/2,0.4*wdh,orange);
            Screen('Flip', wd);
            
        elseif keyCode(rightKey)|keyCode(button50);
            xpos=xpos+stepsize;
            txt = {' '};
            Screen('DrawText',wd,txt{1},wdw/2,0.4*wdh,orange);
            Screen('Flip', wd);
            
        elseif keyCode(choiceKey)|keyCode(button51);
            nr=length(txt3);
            for k=1:nr   
                [wt] = Screen(wd,'TextBounds',txt3{k});
                xtxt = round(wdw/2-wt(3)/2);
                ytxt = round(wdh-(top+txtsize)+ k*wt(4));
                Screen('Drawtext',wd,txt3{k},xtxt,ytxt,orange);
               
            end
            Screen('Flip', wd);
            Waitsecs(0.2)%wait to make sure we don't use the same kbcheck twice
            KbWait; %wait for confirmation or continuation
            [ keyIsDown, timeSecs, keyCode ] = KbCheck;
            if keyCode(choiceKey)|keyCode(button51);
                break; % break out of the loop if they think they sorted it out
            end
        end
        
        % Don't let spot move outside VASslider
        if xpos<=0.1*wdw;
            xpos=0.1*wdw;
        end
        if xpos>=0.9*wdw;
            xpos=0.9*wdw;
        end
        % calculate new position slider 
        bottomslider=CenterRectOnPoint(slider,xpos,0.6*wdh);
        
    end
    OVas(vasn,s)=(xpos-0.1*wdw)/(0.9*wdw-0.1*wdw); %sla percentage van balk op in vector.
    
    if dutch==1
        text={'Dankjewel!'};
    elseif english==1
        text={'Thank you!'};
    end
    displaytext(text,wd,wdw,wdh,orange,0,0);
    mygetclicks;
    
    
end

if dutch==1
    text{1} = {'Plaatjes BEOORDELEN'};
    text{2} = {'Je gaat nu een zestal plaatjes beoordelen.'};
    text{3} = {'Je krijgt telkens een plaatje te zien',...
        'Vervolgens kan je met de slider op een scorebalk',...
        'aangeven hoe leuk je dit plaatje vond.',...
        'Daarna krijg je weer een ander plaatje te zien',...
        'dan beoordeel je die ook.'};
    text{4} = {'Het scoren doe je door een cursor met de drukknoppen','naar links en rechts te bewegen.'};
elseif english==1
end

for t = 1:4
    displaytext(text{t},wd,wdw,wdh,orange,0,0);
    waitsecs(0.2);
    mygetclicks;
end

 for s=1:6
    bottomslider=CenterRectOnPoint(slider,0.5*wdw,0.6*wdh); % starting position slider
    xpos          = 0.5*wdw;
    
    if dutch==1
        text{1}={'Je krijgt nu 3 seconden een plaatje te zien',...
            'Bekijk het goed.'};
    elseif english==1
     end
    
    displaytext(text{1},wd,wdw,wdh,orange,0,0);
    waitsecs(0.2);
    mygetclicks;
    
    if s<4
    Screen('DrawTexture',wd,bgshape(1,Ap(1,s)),[],bgr);
    else
    Screen('DrawTexture',wd,bgshape(2,Ap(1,s)),[],bgr);
    end
    
    Screen('Flip', wd);
    WaitSecs(3);
    
    % Let the subject evaluate the picture by moving the slider
    while true
        if dutch==1
            txt1 = {'Verplaats de balk met de linker (wijsvinger)',...
                'en rechter (middelvinger) druktoetsen',...
                'naar de plek die je vindt passen bij het plaatje',... 
                'Druk dan op bevestigingstoets (ringvinger)'};
            txt2 = {'Helemaal niet leuk','Neutraal','Heel leuk'};
            txt3 = {'Druk nogmaals om te bevestigen,'...
                'of links of rechts om de balk te verplaatsen'};
            
        elseif english==1
        end
            nrow=length(txt1);
        for k=1:nrow
            [wt]=Screen(wd,'TextBounds',txt1{k});
            xpos1=wdw/2-wt(3)/2;
            ypos1=0.1*wdh+2*k*wt(4);
            Screen('Drawtext',wd,txt1{k},xpos1,ypos1,orange);
        end
        
        Screen('DrawText',wd,txt2{1},0.1*wdw,0.8*wdh,barcol);
        [wt] = Screen(wd,'TextBounds',txt2{2});
        Screen('DrawText',wd,txt2{2},0.5*wdw-wt(3)/2,0.8*wdh,barcol);
        [wt] = Screen(wd,'TextBounds',txt2{3});
        Screen('DrawText',wd,txt2{3},0.9*wdw-wt(3),0.8*wdh,barcol);
        
        Screen('DrawLines',wd,xaxis,2,scalecol);%draw scale
        Screen('Drawlines',wd,yleft,2,scalecol);
        Screen('Drawlines',wd,ymid,2,scalecol);
        Screen('Drawlines',wd,yright,2,scalecol);
        
        Screen('FillRect', wd, barcol, bottomslider);
        Screen('Flip', wd,[],1);
        
        % check whether they've pressed a key
        % if they did, move the slider.
        KbWait;
        [ keyIsDown, timeSecs, keyCode ] = KbCheck;
        if keyCode(leftKey)|keyCode(button49)
            xpos=xpos-stepsize;
            %     dd   sssssssssdd  slightly silly bit of trick code needed because the previous
            % flip doesn't remove the background so I can add the
            % confirmation question...
            txt = {' '};
            Screen('DrawText',wd,txt{1},wdw/2,0.4*wdh,orange);
            Screen('Flip', wd);
            
        elseif keyCode(rightKey)|keyCode(button50);
            xpos=xpos+stepsize;
            txt = {' '};
            Screen('DrawText',wd,txt{1},wdw/2,0.4*wdh,orange);
            Screen('Flip', wd);
            
        elseif keyCode(choiceKey)|keyCode(button51);
            nr=length(txt3);
            for k=1:nr   
                [wt] = Screen(wd,'TextBounds',txt3{k});
                xtxt = round(wdw/2-wt(3)/2);
                ytxt = round(wdh-(top+txtsize)+ k*wt(4));
                Screen('Drawtext',wd,txt3{k},xtxt,ytxt,orange);
               
            end
            Screen('Flip', wd);
            Waitsecs(0.2)%wait to make sure we don't use the same kbcheck twice
            KbWait; %wait for confirmation or continuation
            [ keyIsDown, timeSecs, keyCode ] = KbCheck;
            if keyCode(choiceKey)|keyCode(button51);
                break; % break out of the loop if they think they sorted it out
            end
        end
        
        % Don't let spot move outside VASslider
        if xpos<=0.1*wdw;
            xpos=0.1*wdw;
        end
        if xpos>=0.9*wdw;
            xpos=0.9*wdw;
        end
        % calculate new position slider 
        bottomslider=CenterRectOnPoint(slider,xpos,0.6*wdh);
        
    end
    OVaspic(vasn,s)=(xpos-0.1*wdw)/(0.9*wdw-0.1*wdw); %sla percentage van balk op in vector.
    
    if dutch==1
        text={'Dankjewel!'};
    elseif english==1
        text={'Thank you!'};
    end
    displaytext(text,wd,wdw,wdh,orange,0,0);
    mygetclicks;
    
    
end
% % comment out when not standalone
% Screen('CloseAll');
% clear Screen

