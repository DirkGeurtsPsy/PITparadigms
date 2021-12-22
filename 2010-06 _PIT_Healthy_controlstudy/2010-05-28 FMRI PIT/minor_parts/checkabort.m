[foo, foo, key ] = KbCheck;
if strcmpi(KbName(key),'ESCAPE')
	aborted=1; 
	Screen('Fillrect',wd,ones(1,3)*100);
	text='Aborting experiment';col=red;
	displaycentraltxt; 
	error('Pressed ESC --- aborting experiment')
end

[foo, foo, key ] = KbCheck;
if strcmpi(KbName(key),'F12')
    T.break.start(nt)=GetSecs;
    if np~=0
        T.break.pav.start(np)=GetSecs;
    end
    WaitScn;
                dummyStart=5;
                scannerTrigger;
                T.break.end(nt)=GetSecs;
    if np~=0
        T.break.pav.total(np)=GetSecs;
    end
end

