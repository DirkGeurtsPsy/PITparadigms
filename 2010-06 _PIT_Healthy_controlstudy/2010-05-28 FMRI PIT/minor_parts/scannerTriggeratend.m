% Wait for the scanner to start, turn the screen black (just a fixation
% cross). Then wait until the dummy scans have past.
if fmri==1
    while kbcheck,end %make sure all keys are released
    
    % present a black screen saying 'waiting to start'
    text = {'Dit onderdeel van het spel is ten einde','de scanner zal zo stoppen.','Probeer uw hoofd stil te houden.'};
    displaytext(text,wd,wdw,wdh,orange,0,0);
    % wait for the scanner trigger
    scanTrigger = 0;
    while (~scanTrigger)
        [secs, keyCode, dSecs]  = kbWait;
        st = find(keyCode);
        if (st == Triggernr)
            scanTrigger = 1;
        end
    end
    tScanStart = GetSecs; % ASSUMING THIS HAPPENS AT THE START OF THE FIRST VOLUME!!
    % wait for the dummy scans
    while scanTrigger <=dummyStop;
        while kbcheck,end
        [secs, keyCode, dSecs]  = kbWait;
        st = find(keyCode);
        if (st == Triggernr)
            scanTrigger = scanTrigger+1;
        end
    end
end
% start the experiment

