%------------------------------------------------------------------------------------------------
%			GIVE BREAK
%------------------------------------------------------------------------------------------------
col=[240 240 20];

%--------------------------------------------------------------
Screen('TextSize',wd,txtsize);	

% if demorun
% 	breaklength=3;
% end

clear txt
for k=breaklength:-1:0;
	if english
		txt{1}='BREAK';
		txt{2}='     ';
		if k>60
			txt{3}=[num2str(floor(k/60)) ' minutes'];
		else
			txt{3}='      ';
		end
		txt{4}=[num2str(k-60*floor(k/60)) ' seconds'];
    elseif dutch
        txt{1}='PAUZE';
		txt{2}='     ';
		if k>60
			txt{3}=[num2str(floor(k/60)) ' minuten'];
		else
			txt{3}='      ';
		end
		txt{4}=[num2str(k-60*floor(k/60)) ' secondes'];
	else
		txt{1}='Pause';
		txt{2}='     ';
		if k>60
			txt{3}=[num2str(floor(k/60)) ' Minute'];
		else
			txt{3}='      ';
		end
		txt{4}=[num2str(k-60*floor(k/60)) ' Sekunden'];
	end
	displaytext(txt,wd,wdw,wdh,col,0,0);
	checkabort;
	WaitSecs(1);
end

clear txt
if english 
	txt{1}='BREAK OVER';
	txt{2}='     ';
	txt{3}='Click to continue';
elseif dutch 
	txt{1}='Pauze voorbij';
	txt{2}='     ';
	txt{3}='Klikt u om verder te gaan.';
else 
	txt{1}='Pause fertig';
	txt{2}='     ';
	txt{3}='Klicken Sie, um weiterzumachen.';
end

displaytext(txt,wd,wdw,wdh,col,1,0);
clear txt
