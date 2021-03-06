fprintf('............ Displaying instructions \n');
if dutch
    text={'We willen u nu vragen,','iets anders te doen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else
text={'Wir moechten Sie jetzt bitten,','etwas anderes zu tun.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
text={'U krijgt beelden te zien, zoals deze'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	Screen('DrawTexture',wd,shape(1),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
	Screen('Flip', wd);
	mygetclicks;
else
    text={'Sie werden Bilder sehen, wie z.B. dieses'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	Screen('DrawTexture',wd,shape(1),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
	Screen('Flip', wd);
	mygetclicks;
end

if dutch
text={'of deze. '};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	Screen('DrawTexture',wd,shape(2),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
	Screen('Flip', wd);
	mygetclicks;
else
    text={'oder dieses. '};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	Screen('DrawTexture',wd,shape(2),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
	Screen('Flip', wd);
	mygetclicks;
end

if dutch
    text={'Met ieder beeld kunt u of','punten winnen of punten verliezen','of geen punten verdienen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else
text={'Mit jedem Bild koennen Sie entweder','Punkte gewinnen oder verlieren','oder keine Punkte gewinnen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
    text={'Onthoud,','wat goede, en wat slechte','plaatjes zijn.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else
text={'Erinnern Sie sich daran,','welches gute, und welches schlechte','Bilder sind.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
    text={'Af en toe moet u tussen','twee plaatjes kiezen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else
text={'Ab und zu werden Sie zwischen','zwei Bildern waehlen muessen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
    text={'En wel dan, wanneer u er twee ziet:'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	Screen('DrawTexture',wd,shape(1),[],dr(1,:));
	Screen('DrawTexture',wd,shape(2),[],dr(2,:));
	Screen('Flip', wd);
	mygetclicks;
else
text={'Und zwar immer dann, wenn Sie zwei sehen:'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	Screen('DrawTexture',wd,shape(1),[],dr(1,:));
	Screen('DrawTexture',wd,shape(2),[],dr(2,:));
	Screen('Flip', wd);
	mygetclicks;
end

if dutch
    text={'Probeert u,','zoveel mogelijk geld','te winnen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else
text={'Versuchen Sie,','so viele Geld wie moeglich','zu gewinnen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
    text={'Klikt u met de muis','om te beginnen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else
text={'Klicken Sie die Maus','um zu beginnen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

display('done')
