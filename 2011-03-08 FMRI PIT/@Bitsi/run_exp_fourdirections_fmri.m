

new                    = input('New subject?','s'); 
sID                    = input('Subject ID: ','s');
today                  = date;
startexp               = clock;
startexp               = [num2str(startexp(4)) ':' num2str(startexp(5))];
coherence_threshold    = input('Coherence threshold:');
practice               = 0;

%subject specific parameters
nrofnovel           = 100; %multiple of 10
nroftrials          = nrofnovel * 10;
%coherence_threshold = 10;

start_time = GetSecs;

if new == 'y'
    dotsSetup_fMRI;
    makeStimuli;
    tr                 = 1;
    ss                 = 1;
    trbins             = 1;
else
    tr                 = input('Trialnumber:');
    ss                 = input('Novelnumber:');
    trbins             = 2;
    screenNumber = max(Screen('Screens'));
    %[w,screenRect]   = Screen('OpenWindow', screenNumber, [0 0 0], [100 100 1024 768]); %debug mode
    [w,screenRect] = Screen(screenNumber,'OpenWindow');
    Screen('FillRect',w,background);
    Screen('Flip', w);
    HideCursor;
    b = Bitsi('com6');
    makeStimuli;
end;

Screen('FillRect',w,background);

Screen('Flip', w);

FlushEvents

%define some start-up stuff
att_side               = 1;
feedback               = 1;
nrcorrect              = 0;
resp                   = 0;
time                   = 0;
keyIsDown              = 0;
start_flip             = GetSecs;
novel                  = 0;
switched               = 0;
nonswitch              = 0;
nrofnonswitch          = 0;
%direction 1 = up
%direction 2 = down
%direction 3 = left
%direction 4 = right

while b.numberOfResponses() == 0
    writetexttoscreenOffPosCol(w,begintekst,screenRect,0,255);
    Screen('Flip', w);
    WaitSecs(0.001);
end;

b2.clearResponses();

% present a black screen saying 'waiting to start' while waiting for first
% scantrigger
first_scan = 0;
while first_scan == 0
    while b2.numberOfResponses() == 0
        writetexttoscreenOffPosCol(w,scannertekst,screenRect,0,255);
        Screen('Flip', w);
        WaitSecs(0.001);
    end;
    [resp, time_resp] = b2.getResponse(0.001, true);
    if resp == 97
        first_scan = 1;
        nr_of_scans = 1;
        start_scan = time_resp;
    end;
end;



%for multi-echo -- first trigger send after a number of preparatory scans
%no need for dummy scans since equilibrium is already achieved during these
%preparatory scans
%acquire 30 volumes during 'rest' for weighting of echo scans

fixationcross(w,fixvhdim,linewidth,screenRect,color);
Screen('Flip',w);

timingpulses(nr_of_scans) = start_scan;

while nr_of_scans < 30 + 1
    while b2.numberOfResponses() == 0
        WaitSecs(0.001);
    end;    
    [resp, time_resp] = b2.getResponse(0.001, true);
    if resp == 97
        nr_of_scans = nr_of_scans + 1;
        timingpulses(nr_of_scans) = time_resp;
    end;
end;


b.clearResponses();

% try

% loop till a certain number of novel trials
for s = ss:nrofnovel
    
    
    % loop till a certain number of correct repeat responses
    while nrcorrect < nrcorrectrepeattrials(s)
        
        if (trbins == 4) && (s == 20 || s == 40 || s == 60 || s == 80 )
            FlushEvents('keyDown');
            b.clearResponses();
            while b.numberOfResponses() == 0
                writetexttoscreenOffPosCol(w,pauzetekst,screenRect,0,255);
                Screen('Flip', w);
                WaitSecs(0.001);
            end;
            %novel = 0;
            b.clearResponses();
            pause = 1;
            nrcorrect = 0;
        else
            pause = 0;
        end;
        
        %nr of repeat trials is assumed to be max 10 times the nr of novel trials.
        %if this number is exceeded, start over in the same array
        if tr > nroftrials
            coherence_repeat_transform(tr) = coherence_repeat_transform(tr-nroftrials);
            switch_target(tr) = switch_target(tr-nroftrials);
            directions_repeat(tr) = directions_repeat(tr-nroftrials);
        end;
        
        startTr(tr) = GetSecs;
        FlushEvents('keyDown');
        
        color = 150;
        
        %novel stimulus always has different direction compared to attented side
        %coherence of novel stimulus is randomized
        if novel == 1
            %'old' side
            coherence_att(tr) = coherence_repeat_transform(tr);
            target_direction_att(tr) = directions_repeat(tr);
            %'novel' side
            coherence_unatt(tr) = coherence_novel_transform(s-1);
            target_direction_unatt(tr) = directions_novel(s-1);
            
            while target_direction_att(tr) == target_direction_unatt(tr)
                target_direction_att(tr) = randi(4);
            end;
            
            %if novel stimulus comes on, allow enough time to make the
            %switch
            if switch_target(tr) < 160 %2666 ms
                switch_target(tr) = 160; 
            end;
            
        else
            
            %switch changes the attended side
            if switched == 1
                if att_side == 1;
                    att_side = 2;
                elseif att_side == 2;
                    att_side = 1;
                end;
            end;
            
            if nonswitch == 1;
                %coherence and direction unattended (=novel) do not change
                coherence_unatt(tr) = coherence_novel_transform(s-1);
                target_direction_unatt(tr) = directions_novel(s-1);
                coherence_att(tr) = coherence_repeat_transform(tr);
                target_direction_att(tr) = directions_repeat(tr);
                
                while target_direction_att(tr) == target_direction_unatt(tr)|| target_direction_att(tr) == target_direction_att(tr-1)
                    target_direction_att(tr) = randi(4);
                end;
                
                if nrofnonswitch > 10
                    color = 255;
                end;
                
                %repeat and switch trials
            else
                %first trial after switch no change on novel attended side
                if switched == 1
                    coherence_att(tr) = coherence_unatt(tr-1);
                    target_direction_att(tr) = target_direction_unatt(tr-1);
                    switched = 0;
                else
                    coherence_att(tr) = coherence_repeat_transform(tr);
                    target_direction_att(tr) = directions_repeat(tr);
                    
                    if tr ~= 1
                        while target_direction_att(tr) == target_direction_att(tr-1)
                            target_direction_att(tr) = randi(4);
                        end;
                    end;
                end;
                
                target_direction_unatt(tr) = 0;
                coherence_unatt(tr) = 0;
                unattname = 'n';
                
            end;
        end;
        
        if target_direction_att(tr) == 1
            attname = ['sup_', int2str(coherence_att(tr))];
        elseif target_direction_att(tr) == 2
            attname = ['sdown_', int2str(coherence_att(tr))];
        elseif target_direction_att(tr) == 3
            attname = ['sleft_', int2str(coherence_att(tr))];
        elseif target_direction_att(tr) == 4
            attname = ['sright_', int2str(coherence_att(tr))];
        end
        
        if target_direction_unatt(tr) == 1
            unattname = ['sup_', int2str(coherence_unatt(tr))];
        elseif target_direction_unatt(tr) == 2
            unattname = ['sdown_', int2str(coherence_unatt(tr))];
        elseif target_direction_unatt(tr) == 3
            unattname = ['sleft_', int2str(coherence_unatt(tr))];
        elseif target_direction_unatt(tr) == 4
            unattname = ['sright_', int2str(coherence_unatt(tr))];
        elseif target_direction_unatt(tr) == 0
            coherence_unatt(tr) = 0;
            unattname = 'n';
        end
        
        att_side_log(tr)            = att_side;
        
        target_att = eval(attname);
        target_unatt = eval(unattname);
        
        for frame = 1:switch_target(tr)
            
            start_cycle(frame,tr) = GetSecs;
            cycleframe = 1+mod(frame,preFrame);
            
            if att_side == 1
                Screen('DrawTexture',w,target_att(cycleframe),s_r,left);
                Screen('DrawTexture',w,target_unatt(cycleframe),s_r,right);
                fixationcross(w,fixvhdim,linewidth,screenRect,color);
            elseif att_side == 2
                Screen('DrawTexture',w,target_att(cycleframe),s_r,right);
                Screen('DrawTexture',w,target_unatt(cycleframe),s_r,left);
                fixationcross(w,fixvhdim,linewidth,screenRect,color);
            end;
            
            start_stim(frame,tr) = GetSecs;
            cycle_time(frame,tr) = start_stim(frame,tr) - start_flip;
            
            
            time = (1/60) - start_flip;
            while b.numberOfResponses() == 0 && ((start_stim(frame,tr) - start_flip) <= time)
                start_stim(frame,tr) = GetSecs;
                WaitSecs(0.001);
            end;
            
            if b.numberOfResponses() == 0
                resp = 0;
                time_resp = 0;
            else
                [resp, time_resp] = b.getResponse(0.001, true); % Buttonboxresponse
            end;
            
            response_miss_time(frame,tr) = GetSecs;
            
            %start stimulus
            Screen('Flip', w);
            
            cycle_time_flip(frame,tr) = start_stim(frame,tr) - start_flip;
            start_flip = GetSecs;
            start_flip_log(frame,tr) = GetSecs;
            
            %send trigger to eyetracker
            if frame == 1
                b.sendTrigger(21);
            end;
                        
            trueresponses(frame,tr) = resp;
            truetimeresp(frame,tr) = time_resp;
            
        end;
        
        %On repeat trials - First response made after start of the trial
        %On novel trials - Last response made after start of the trial
        if novel == 1 || nonswitch == 1
            a = find((trueresponses(:,tr)>0 & trueresponses(:,tr)>90),1,'last');
        else
            a = find((trueresponses(:,tr)>0 & trueresponses(:,tr)>90),1,'first');
        end;
        
        
        %Compare response to stimulus for feedback
        if a > 0
            
            resp(tr) = trueresponses(a,tr);
            if resp(tr) == 72 %102
                response(tr) = 1;
            elseif resp(tr) == 71 %101
                response(tr) = 2;
            elseif resp(tr) == 65 %97
                response(tr) = 3;
            elseif resp(tr) == 66 %98
                response(tr) = 4;
            else
                resp(tr) = 0;
                response(tr) = 0;
            end;
        else
            resp(tr) = 0;
            response(tr) = 0;
        end;
        
        if novel == 1 || nonswitch == 1
            if response(tr) == target_direction_att(tr) %nonswitch
                feedback(tr) = 0;
                nrcorrect = 0;
                nonswitch = 1;
                nonswitch_log(tr) = 1;
                nrofnonswitch = nrofnonswitch + 1;
                switched = 0;
                switched_log(tr) = 0;
            elseif response(tr) == target_direction_unatt(tr) %switch
                feedback(tr) = 1;
                nrcorrect = nrcorrect + 1;
                nonswitch = 0;
                nonswitch_log(tr) = 0;
                nrofnonswitch = 0;
                switched = 1;
                switched_log(tr) = 1;
            elseif response(tr) == 0;  %miss
                feedback(tr) = 0;
                nrcorrect = 0;
                nonswitch = 1;
                nonswitch_log(tr) = 2;
                nrofnonswitch = nrofnonswitch + 1;
                switched = 0;
                switched_log(tr) = 0;
            else                       %random response
                feedback(tr) = 0;
                nrcorrect = 0;
                nonswitch = 1;
                nonswitch_log(tr) = 3;
                nrofnonswitch = nrofnonswitch + 1;
                switched = 0;
                switched_log(tr) = 0;
            end;
            if a > 0
                time_resp_log(tr) = truetimeresp(a,tr);
                resp_time(tr) = (time_resp_log(tr) - start_flip_log(1,tr))*1000;
            else
                time_resp_log(tr) = 0;
                resp_time(tr) = 0;    
            end;
        else
            if response(tr) == target_direction_att(tr)
                feedback(tr) = 1;
                nrcorrect = nrcorrect + 1;
                time_resp_log(tr) = truetimeresp(a,tr);
                resp_time(tr) = (time_resp_log(tr) - start_flip_log(1,tr))*1000;
            elseif response(tr) == 0 && tr ~= 1 && switched_log(tr-1) == 1
                feedback(tr) = 1;
                nrcorrect = nrcorrect + 1;
                time_resp_log(tr) = 0;
                resp_time(tr) = 0;
            else
                feedback(tr) = 0;
                nrcorrect = 0;
                time_resp_log(tr) = 0;
                resp_time(tr) = 0;
            end;
            nonswitch = 0;
            nonswitch_log(tr) = 0;
            switched = 0;
            switched_log(tr) = 0;
            nrofnonswitch = 0;
        end;
        
        %log trialspecific stuff
        nrcorrect_log(tr) = nrcorrect;
        nrcorrectrepeattrials_log(tr) = nrcorrectrepeattrials(s);
        pause_log(tr) = pause;
        s_log(tr) = s;
        
        if novel == 1
        else
            novel_log(tr) = 0;
        end;
        
        novel = 0;
        tr = tr+1;
        trbins = trbins + 1;
    end;
    novel = 1;
    novel_log(tr) = 1;
    trbins = 1;
    nrcorrect = 0;
end;

% catch
%     WriteToLogfile;
% end;



writetexttoscreenOffPosCol(w,eindtekst,screenRect,0,255);
Screen('Flip', w);
WaitSecs(3);


b.close();
b2.close();
WriteToLogfile;

screen closeall;
ShowCursor;
Screen('CloseAll');




