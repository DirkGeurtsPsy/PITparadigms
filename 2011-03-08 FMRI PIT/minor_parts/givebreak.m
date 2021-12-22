%------------------------------------------------------------------------------------------------
%			GIVE BREAK
%------------------------------------------------------------------------------------------------
col=[240 240 20];

%--------------------------------------------------------------
Screen('TextSize',wd,txtsize);	

clear txt
for k=breaklength:-1:0;
% 	if english
% 		txt{1}='BREAK';
% 		txt{2}='     ';
% 		if k>60
% 			txt{3}=[num2str(floor(k/60)) ' minutes'];
% 		else
% 			txt{3}='      ';
% 		end
% 		txt{4}=[num2str(k-60*floor(k/60)) ' seconds'];
% 	else
		txt{1}='Pauze';
		txt{2}='Houd uw hoofd alstublieft stil!';
		if k>60
			txt{3}=[num2str(floor(k/60)) ' Minuten'];
		else
			txt{3}='      ';
		end
		txt{4}=[num2str(k-60*floor(k/60)) ' Seconden'];
% 	end
	displaytext(txt,wd,wdw,wdh,col,0,0);
	checkabort;
	WaitSecs(1);
end

clear txt
% if english 
% 	txt{1}='BREAK OVER';
% 	txt{2}='     ';
% 	txt{3}='Click to continue';
% else 
	txt{1}='Pauze is afgelopen';
	txt{2}='     ';
	txt{3}='Drukt u op de knop om verder te gaan.';
% end

displaytext(txt,wd,wdw,wdh,col,1,0);
clear txt
