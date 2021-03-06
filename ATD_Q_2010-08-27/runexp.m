clear all
modifyme;	% set the main experimental parameters
preps; 		% setup for stimulus presentation sequences and other stuff

try 	% this is important: if there's an error, psychtoolbox will crash graciously
		% and move on to the 'catch' block at the end, where all screens etc are
		% closed. 

	setup; 	% setup display, stimulus coordinates, load images etc. 

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Beginning of experiment 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	T(1)=GetSecs;

	%---------------------------------------------------------------------------
	% 	Block 1 
	%---------------------------------------------------------------------------
	
	%.............. instrumental training with feedback ........................
	fprintf('............. First Instrumental training\n')

	% display instructions and start clock
	if doinstr; 									% for degubbing, set doinstr=0;
		if approach;   pitinstr_approach; 	% approach instructions 
		else           pitinstr_avoid; 		% withdrawal instructions 
		end
	end	

	for nt = 1:Z.Ntrain/2
		pittraining;
	end

	%.............. Pavlovian training .........................................
	fprintf('............. First Pavlovian training\n')
	
	if doinstr; pavinstr;end	% display instructions and start clock
	for np=1:Z.Npav(1);
		pavlov;
		if ~mod(np,Z.cpmod);
			compare;
		end
	end
	
	%.............. PIT ........................................................
	fprintf('............. First PIT session \n')

	if doinstr; pitinstr_start; end
	for npit = 1:Z.Npit/2
		pit;
	end
	 
	T(2)=GetSecs;
	givebreak; 
	T(3)=GetSecs;

	%---------------------------------------------------------------------------
	% 	Block 2 
	%---------------------------------------------------------------------------
	approach = 1-approach;

	%.............. instrumental training with feedback ........................
	fprintf('............. Second Instrumental training\n')

	% display instructions and start clock
	if doinstr; 
		if approach;   pitinstr_approach;
		else           pitinstr_avoid;
		end
	end	
	
	for nt = (1:Z.Ntrain/2)+Z.Ntrain/2;
		pittraining;
	end

	%.............. Pavlovian training .........................................
	fprintf('............. Second Pavlovian training\n')
	if doinstr; pavinstr_short;end	% display short instructions
	for np=(1:Z.Npav(2))+Z.Npav(1);
		pavlov;
		if ~mod(np,Z.cpmod);
			compare;
		end
	end


	%.............. PIT ........................................................
	fprintf('............. Second PIT session \n')
	
	if doinstr; pitinstr_start;end
	for npit = (1:Z.Npit/2)+Z.Npit/2
		pit;
	end

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% End of experiment 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%.............. save all in two separate files .............................

	T(4)=GetSecs; Experimentlength=(T(4)-T(1)-(T(3)-T(2)))/60;
	if dosave; eval(['save ' namestring '.mat']);end
	if dosave; eval(['save ' namestring2 '.mat']);end

	%.............. payment ....................................................
	if payment
		payout = (sum(crt==1)+sum(cr==1)+sum(crm==1)) - (sum(crt==0)+sum(cr==0)+sum(crm==0)); 
		payout = max(min(15,.1*payout),3);

        if dutch
        text={'U heeft in totaal',[num2str(payout) ' Euro verdient.']};
		displaytext(text,wd,wdw,wdh,orange,1,0);
        else
		text={'Sie haben insgesamt',[num2str(payout) ' Euro verdient.']};
		displaytext(text,wd,wdw,wdh,orange,1,0);
        end
		WaitSecs(10);
    end
    
    if dutch
    text={'Het experiment is nu ten einde. Hartelijk dank voor uw hulp.'}; 
	displaytext(text,wd,wdw,wdh,orange,0,1);
    else
	text={'Das Experiment ist nun zu Ende. Vielen Dank fuer Ihre Hilfe.'}; 
	displaytext(text,wd,wdw,wdh,orange,0,1);
    end
    
	WaitSecs(3)
	Screen('CloseAll');

catch % execute this if there's an error, or if we've pressed the escape key

	if aborted==0;	 % if there was an error
		fprintf(' ******************************\n')
		fprintf(' **** Something went WRONG ****\n')
		fprintf(' ******************************\n')
		if dosave; eval(['save ' namestring '.crashed.mat;']);end
	elseif aborted==1; % if we've abored by pressing the escape key
		fprintf('                               \n')
		fprintf(' ******************************\n')
		fprintf(' **** Experiment aborted ******\n')
		fprintf(' ******************************\n')
		if dosave; eval(['save ' namestring '.aborted.mat;']);end
	end
	Screen('CloseAll'); % close psychtoolbox, return screen control to OSX
	rethrow(lasterror)
	ShowCursor;
end


