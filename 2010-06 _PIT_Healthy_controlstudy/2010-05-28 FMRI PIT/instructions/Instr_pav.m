%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if block==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if dutch==1
text{1}={'We vragen u nu iets anders te doen.','(Druk op een toets om verder te gaan)'};
text{2}={'U krijgt plaatjes te zien, zoals deze:'};
text{3}={'Of zoals deze: '};
text{4}={'Of zoals deze: '};
text{5}={'Bij ieder plaatje krijgt u:','(1) een lekker sapje,','(2) niks', '(3) of een vies sapje.'};
text{6}={'Kijk goed naar de plaatjes','en probeer te onthouden','wat goede, wat neutrale en wat slechte','plaatjes zijn.'};
text{7}={'Soms wordt u gevraagd tussen','twee beelden te kiezen.'};
text{8}={'Dit is telkens zo wanneer er twee beelden verschijnen:'};
text{9}={'Kies het beste (=lekkerste) plaatje','door snel op de linker of rechter knop','te drukken.','Doe dit zo snel mogelijk!','De tijd wordt bijgehouden!'};
text{10}={'Tot slot:','bij de plaatjes krijgt u ook','verschillende geluiden te horen.'};
text{11}={'Succes met het ontvangen van de sapjes!'};
elseif english==1
end

for r=1:11
    if r==2
       	texts=text{r};
        [wt]=Screen(wd,'TextBounds',texts{1});
        Screen('Drawtext',wd,texts{1},wdw/2-wt(3)/2,y0/2,orange);
        if start==1
            Screen('DrawTexture',wd,shape(1,Ap(1,1)),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
        elseif start==0
            Screen('DrawTexture',wd,shape(2,Ap(1,4)),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
        end
        Screen('Flip', wd);
        mygetclicks;
    elseif r==3
               	texts=text{r};
        [wt]=Screen(wd,'TextBounds',texts{1});
        Screen('Drawtext',wd,texts{1},wdw/2-wt(3)/2,y0/2,orange);
        if start==1
            Screen('DrawTexture',wd,shape(1,Ap(1,2)),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
        elseif start==0
            Screen('DrawTexture',wd,shape(2,Ap(1,5)),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
        end
        Screen('Flip', wd);
        mygetclicks;
    elseif r==4
               	texts=text{r};
        [wt]=Screen(wd,'TextBounds',texts{1});
        Screen('Drawtext',wd,texts{1},wdw/2-wt(3)/2,y0/2,orange);
        if start==1
            Screen('DrawTexture',wd,shape(1,Ap(1,3)),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
        elseif start==0
            Screen('DrawTexture',wd,shape(2,Ap(1,6)),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
        end
        Screen('Flip', wd);
        mygetclicks;
    elseif r==8
        texts=text{r};
        [wt]=Screen(wd,'TextBounds',texts{1});
    	Screen('Drawtext',wd,texts{1},wdw/2-wt(3)/2,y0/2,orange);
        if start==1
            Screen('DrawTexture',wd,shape(1,Ap(1,1)),[],dr(1,:));
            Screen('DrawTexture',wd,shape(1,Ap(1,2)),[],dr(2,:));
        elseif start==0
            Screen('DrawTexture',wd,shape(2,Ap(1,4)),[],dr(1,:));
            Screen('DrawTexture',wd,shape(2,Ap(1,5)),[],dr(2,:));
        end
        Screen('Flip', wd);
        mygetclicks;

    elseif r~=2||r~=3||r~=4||r~=8
        displaytext(text{r},wd,wdw,wdh,orange,1,0);
    end 
end
  
fprintf('.........done\n')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif block==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if dutch==1
text{1}={'We vragen u wederom naar plaatjes te kijken.','en sap te ontvangen.','(Druk op een toets om verder te gaan)'};
text{2}={'Probeer weer te onthouden','wat goede, wat neutrale en wat slechte','plaatjes zijn.'};
text{3}={'U wordt weer gevraagd soms te kiezen:','kies het beste (=lekkerste) plaatje','door snel op de linker of rechter knop','te drukken.','Doe dit zo snel mogelijk!','De tijd wordt bijgehouden!'};
text{4}={'Succes met het ontvangen van de sapjes!'};
elseif english==1
end

for r=1:4
 displaytext(text{r},wd,wdw,wdh,orange,1,0);
 end
  
fprintf('.........done\n')
end 
