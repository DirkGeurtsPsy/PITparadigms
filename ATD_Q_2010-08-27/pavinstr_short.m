fprintf('............ Pavlovian refresher instructions');

if dutch
    text={'We gaan nu kort terug naar','naar de andere opdracht'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
	% Start clock when subject presses mouse for the first time
	T(5)=GetSecs;
else
text={'Wir kehren jetzt kurz','zur anderen Aufgabe zurueck'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
	% Start clock when subject presses mouse for the first time
	T(5)=GetSecs;
end

if dutch
    text={'We laten u wederom plaatjes zien zoals deze'};
	[wt]=Screen(wd,'TextBounds',text{1});
	Screen('Drawtext',wd,text{1},wdw/2-wt(3)/2,y0/2,orange);
	Screen('DrawTexture',wd,shape(1),[],[x0+.5*xl2 y0 x0+1.5*xl2 y0+yl0-.1*yl0]);
	Screen('Flip', wd);
	mygetclicks;
else
text={'Wir zeigen Ihnen wieder Bilder wie dieses'};
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
    text={'Onthoud,','hoe goed de plaatjes zijn.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
else
text={'Erinnern Sie sich wieder daran,','wie gut Bilder sind.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
    text={'Af en toe moet u weer','tussen twee beelden kiezen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0)
else
text={'Sie werden ab und zu wieder zwischen','zwei Bildern waehlen muessen.'};
	displaytext(text,wd,wdw,wdh,orange,1,0);
end

display('done')
