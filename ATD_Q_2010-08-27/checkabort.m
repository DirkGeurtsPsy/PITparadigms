[foo, foo, key ] = KbCheck;
if strcmpi(KbName(key),'ESCAPE')
	aborted=1; 
	Screen('Fillrect',wd,ones(1,3)*100);
	text='Aborting experiment';col=red;
	displaycentraltxt; 
	error('Pressed ESC --- aborting experiment')
end
