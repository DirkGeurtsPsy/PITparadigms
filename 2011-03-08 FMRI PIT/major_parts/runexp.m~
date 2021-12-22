clear all
close all
delete(instrfind)

T.gen.start=GetSecs;

modifyme;	% set the main experimental parameters
preps; 		% setup for stimulus presentation sequences and other stuff

try

    trialmatrix; % Set up experiment
    setup; 	% setup display, stimulus coordinates, load images etc.
    HideCursor; %hides cursor
    np=0;
    
    T.gen.setup=GetSecs-T.gen.start;
    
    %%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Beginning of experiment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Visual analogue scales for juices
    vasn=1;
    
    if Vas==1;
    
        VASpics;
    
    end
    
    T.gen.VAS.start(1)=GetSecs-T.gen.start;
    
    
    %% callibration
    if Cal==1;
    
        Callibration;
    
    else
        
        Frq.Max=7;
    
    end
    
    T.gen.cal=GetSecs-T.gen.start;
    
    
    %% Start with experiment
    for block=1:2;
        
        %% Instruct instrumental phase
        if doinstr;
          
            Instr_Inst1;                              % instructions for instrumental trial
        
        end
        
        T.gen.Inst.start(block)=GetSecs-T.gen.start;
        
        
        %% Execute instrumental phase
        if fmri==1
        
            WaitScn;
            dummyStart=35;
            scannerTrigger;
        
        end
        
        T.fmristart.inst(block)    = GetSecs;
        T.gen.Inst.scntr(block)=GetSecs-T.gen.start;
        
        for nt=1:Tr.Tot1
        
            Pittraining
        
        end
        
        T.gen.Inst.end(block)=GetSecs-T.gen.start;
        
        if fmri==1
        
            dummyStart=6;
            scannerTrigger;
        
        end
        
        
        
        
        %% Instruct Pavlovian phase
        if doinstr;
        
            Instr_pav;
        
        end
        
        T.gen.Pav.start(block)=GetSecs-T.gen.start;
        
        
        %% Execute pavlovian phase
        if fmri==1
        
            WaitScn;
            dummyStart=5;
            scannerTrigger;
        
        end
        
        T.fmristart.pav(block)    = GetSecs;
        
        T.gen.Pav.scntr(block)=GetSecs-T.gen.start;
        Q=1;
        
        for np=(Tr.TotInst+1):Tr.Tot2;
        
            pavlov;
            
            if np==(Tr.TotInst+Q*Comp);
            
                compare;
                Q=Q+1;
            
            end
            
        end
        
        T.gen.Pav.end(block)=GetSecs-T.gen.start;
        
        if fmri==1
        
            dummyStart=6;
            scannerTrigger;
        
        end
        
        
        
        
        
        %% Instruct PIT pahse
        if doinstr;
        
            Instr_PIT;
        
        end
        
        T.gen.PIT.start(block)=GetSecs-T.gen.start;
        
        
        %% Execute PIT phase
        if fmri==1
        
            WaitScn;
            dummyStart=5;
            scannerTrigger;
        
        end
        
        T.fmristart.PIT(block)    = GetSecs;
        T.gen.PIT.scntr(block)=GetSecs-T.gen.start;
        
        for nt=(Tr.Tot2+1):Tr.Tot3;
            
            pit;
        
        end
        
        T.gen.PIT.end(block)=GetSecs-T.gen.start;
        
        if fmri==1
        
            dummyStart=6;
            scannerTrigger;
        
        end
        
        %% Give feedback about Block
        feedback;
        T.gen.FB.end(block)=GetSecs-T.gen.start;
        
        if block==1
            
            givebreak;
            T.gen.pauze.end(block)=GetSecs-T.gen.start;
        
        else
            
            if Vas==1;
            
                vasn=vasn+1;
                VASpics;
            
            end
            
            T.gen.VAS.end(block+1)=GetSecs-T.gen.start;
        
        end
        
        if start==1
            
            start=0; %reset 'start' to go to next block.
            
        else
            
            start=1;
        
        end
        
    end
    
    %%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % End of experiment
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    
    %%  ............ save all in two separate files .............................
    
    
    if dosave; eval(['save ' namestring '.mat']);end
    if dosave; eval(['save ' namestring2 '.mat']);end
    
    
    
    
    %% EINDE
    text={'Het experiment is nu ten einde.','Hartelijk bedankt voor uw hulp.'};
    displaytext(text,wd,wdw,wdh,orange,0,1);
    
    WaitSecs(3)
    Screen('CloseAll');
    
    
    
    
    
    %% Pomp afsluiten
    if COM~=0
      
        % Close the stepdos object: close and cleanup all the references to the
        % serial port.
        stepdos.close();
        rmpath(pumppath);
    
    end
    
    T.gen.stop1=GetSecs-T.gen.start;
    
    
    
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
    ShowCursor;
    rethrow(lasterror);
    
    
    T.gen.stop2=GetSecs-T.gen.start;

end


