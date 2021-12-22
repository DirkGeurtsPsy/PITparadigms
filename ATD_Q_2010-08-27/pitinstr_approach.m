fprintf('............ Displaying instructions ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~exist('nt')
    if dutch==1
        text={'Het experiment staat klaar.','Klikt u op de muis om te beginnen.'};
        displaytext(text,wd,wdw,wdh,orange,1,0);
        % Start clock when subject presses mouse for the first time
        T(5)=GetSecs;
    else
        text={'Experiment steht bereit','Klicken Sie die Maus, um zu beginnen.'};
        displaytext(text,wd,wdw,wdh,orange,1,0);
        % Start clock when subject presses mouse for the first time
        T(5)=GetSecs;
    end
end

if dutch==1
    text={'Stelt u zich voor, dat u','paddenstoelen gaat verzamelen.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Stellen Sie sich vor, Sie seien dabei,','Pilze zu sammeln.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
        text={'Wij laten u paddenstoelen zien.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Wir werden Ihnen Pilze zeigen.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
    text={'Daartussen zitten zowel goede,','als ook slechte paddenstoelen.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Darunter sind sowohl gute,','als auch schlechte Pilze.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
    text={'U bepaalt of u een paddenstoel','wilt verzamelen of wilt laten staan.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Sie entscheiden, ob Sie einen Pilz','einsammeln oder stehen lassen.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
    text={'Beslissingen leiden of','tot 20 cent winst,','of tot 20 cent verlies.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Entscheidungen fuehren entweder','zu 20 cent Gewinn,','oder zu 20 cent Verlust.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
    text={'Goede paddenstoelen leiden vaker','(maar niet altijd)','naar winst,','als ze verzameld worden.'}
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Gute Pilze fuehren oefters','(aber nicht immer)','zu Gewinn,','wenn sie eingesammelt werden.'}
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
        text={'Slechte paddenstoelen leiden vaker','(maar niet altijd)','tot verlies,','als ze verzameld worden.'}
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Schlechte Pilze fuehren oefters','(aber nicht immer)','zu Verlust,','wenn sie eingesammelt werden.'}
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
    text={'Om paddenstoelen te verzamelen,','klikt u binnen het blauwe vierkant om de paddenstoel.'};
    [wt]=Screen(wd,'TextBounds',text{1});
    Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
    [wt]=Screen(wd,'TextBounds',text{2});
    Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
else
    text={'Um Pilze einzusammeln,','klicken Sie in das blaue Kaestchen um den Pilz.'};
    [wt]=Screen(wd,'TextBounds',text{1});
    Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
    [wt]=Screen(wd,'TextBounds',text{2});
    Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
end

tdr = drm;
tdr(:,[2 4]) = tdr(:,[2,4])+80;
tmp = [tdr(1,[1 3 3 1]); tdr(1,[2 2 4 4])];
redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
Screen('DrawLines',wd,redbox,2,blue);

tdr = drms;
tdr(:,[2 4]) = tdr(:,[2,4])+80;
Screen('DrawTexture',wd,msh(1),[],tdr(1,:));

WaitSecs(.01);
Screen('Flip',wd,[],1);
WaitSecs(.01);
Screen('Flip', wd);
mygetclicks;
checkabort;

if dutch==1
    text={'Om paddenstoelen','te laten staan,','doet u niets.','Wacht gewoon.'};
    [wt]=Screen(wd,'TextBounds',text{1});
    Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
    [wt]=Screen(wd,'TextBounds',text{2});
    Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
    [wt]=Screen(wd,'TextBounds',text{3});
    Screen('Drawtext',wd,text{3},wdw/2-wt(3)/2,y0/2+3*txtsize,orange);
else
    text={'Um Pilze','stehen zu lassen,','tun Sie nichts.','Warten Sie einfach.'};
    [wt]=Screen(wd,'TextBounds',text{1});
    Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
    [wt]=Screen(wd,'TextBounds',text{2});
    Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
    [wt]=Screen(wd,'TextBounds',text{3});
    Screen('Drawtext',wd,text{3},wdw/2-wt(3)/2,y0/2+3*txtsize,orange);
end

tdr = drm;
tdr(:,[2 4]) = tdr(:,[2,4])+80;
tmp = [tdr(3,[1 3 3 1]); tdr(3,[2 2 4 4])];
redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
Screen('DrawLines',wd,redbox,2,blue);

tdr = drms;
tdr(:,[2 4]) = tdr(:,[2,4])+80;
Screen('DrawTexture',wd,msh(2*Z.Ninst),[],tdr(3,:));

WaitSecs(.01);
Screen('Flip',wd,[],1);
WaitSecs(.01);
Screen('Flip', wd);
WaitSecs(4)
checkabort;

if dutch==1
    text={['Als u binnen ' num2str(nogodelay) ' secondes'],'niet in het vierkant hebt geklikt,','gaan wij er van uit dat u de paddestoel','wil laten staan.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={['Wenn Sie innert ' num2str(nogodelay) ' Sekunden'],'nicht in das Kaestchen geklickt haben','nehmen wir an, dass Sie den Pilz','stehen lassen wollen.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch==1
    text={'Klikt u met de muis,','om te beginnen.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Klicken Sie noch einmal die Maus,','um anzufangen.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

fprintf('.........done\n')

