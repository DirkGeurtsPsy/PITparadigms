fprintf('............ Displaying instructions ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~exist('nt')
if dutch 
        text={'Het experiment staat klaar.','Klikt u met de muis om te beginnen.'};
		displaytext(text,wd,wdw,wdh,orange,1,0);
		% Start clock when subject presses mouse for the first time
		T(5)=GetSecs;
else 
    text={'Experiment steht bereit','Klicken Sie die Maus um zu beginnen.'};
		displaytext(text,wd,wdw,wdh,orange,1,0);
		% Start clock when subject presses mouse for the first time
		T(5)=GetSecs;
end
end

if dutch 
    text={'Stelt u zich voor,','dat u paddenstoelen hebt verzameld,','en nu naar huis gaat.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Stellen Sie sich vor,','Sie waren Pilze sammeln,','und kommen nun nach Hause.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'U heeft veel paddenstoelen bij u,','die gesorteerd moeten worden.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Sie haben viele Pilze dabei,','die gilt es jetzt auszusortieren.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'Wij zullen u de paddenstoelen laten zien, die u verzameld heeft.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Wir werden Ihnen Pilze zeigen, die Sie gesammelt haben.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'Daaronder bevinden zich zowel goede,','als ook slechte paddenstoelen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Darunter sind sowohl gute,','als auch schlechte Pilze.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
text={'U bepaalt, of u een paddenstoel','weggooit of houdt.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Sie entscheiden, ob Sie einen Pilz','wegwerfen oder behalten.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'Beslissingen leiden of','tot 20 cent winst,','of tot 20 cent verlies.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Entscheidungungen fuehren entweder','zu 20 Cent Gewinn,','oder zu 20 Cent Verlust.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'Slechte paddenstoelen leiden vaker','(maar niet altijd)','tot winst,','als ze weggegooid worden.'}
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Schlechte Pilze fuehren oefters','(aber nicht immer)','zu Gewinn,','wenn sie weggeworfen werden.'}
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'Goede paddenstoelen leiden vaker','(maar niet altijd)','tot verlies,','als ze weggegooid worden.'}
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Gute Pilze fuehren oefters','(aber nicht immer)','zu Verlust,','wenn sie weggeworfen werden.'}
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'Om paddenstoelen weg te gooien,','klikt u in het lege blauwe vakje.'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	[wt]=Screen(wd,'TextBounds',text{2});
	Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
else 
text={'Um Pilze wegzuwerfen,','klicken Sie in das leere blaue Kaestchen.'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	[wt]=Screen(wd,'TextBounds',text{2});
	Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
end

	tdr = drms; 
	tdr(:,[2 4]) = tdr(:,[2,4])+80;
	Screen('DrawTexture',wd,msh(2*Z.Ninst),[],tdr(1,:));

	tdr = drm; 
	tdr(:,[2 4]) = tdr(:,[2,4])+80;
	tmp = [tdr(3,[1 3 3 1]); tdr(3,[2 2 4 4])];	 
	redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
	Screen('DrawLines',wd,redbox,2,blue);

	WaitSecs(.01);	
	Screen('Flip',wd,[],1);
	WaitSecs(.01);	
	Screen('Flip', wd);
	mygetclicks;
	checkabort;

if dutch
    text={'Om paddenstoelen te behouden doet u niets.','Wacht gewoon.'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	[wt]=Screen(wd,'TextBounds',text{2});
	Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
else 
text={'Um Pilze zu behalten, tun Sie nichts.','Warten Sie einfach.'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('DrawText',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	[wt]=Screen(wd,'TextBounds',text{2});
	Screen('Drawtext',wd,text{2},wdw/2-wt(3)/2,y0/2+1.5*txtsize,orange);
end



	tdr = drms; 
	tdr(:,[2 4]) = tdr(:,[2,4])+80;
	Screen('DrawTexture',wd,msh(2),[],tdr(3,:));

	tdr = drm; 
	tdr(:,[2 4]) = tdr(:,[2,4])+80;
	tmp = [tdr(1,[1 3 3 1]); tdr(1,[2 2 4 4])];	 
	redbox = [tmp(:,1:2) tmp(:,2:3) tmp(:,3:4) tmp(:,[4 1])];
	Screen('DrawLines',wd,redbox,2,blue);

	WaitSecs(.01);	
	Screen('Flip',wd,[],1);
	WaitSecs(.01);	
	Screen('Flip', wd);
	WaitSecs(4)

if dutch 
    text={['Als u binnen' num2str(nogodelay) ' secondes'],'niet in het lege vakje geklikt','hebt, dan behoudt u de paddenstoel.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={['Wenn Sie innerhalb von' num2str(nogodelay) ' Sekunden'],'nicht in das leere Kaestchen geklickt ','haben, dann behalten Sie den Pilz.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch 
    text={'Klikt u nogmaals op de muis,','om te starten.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else 
text={'Klicken Sie noch einmal die Maus,','um anzufangen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

fprintf('.........done\n')
