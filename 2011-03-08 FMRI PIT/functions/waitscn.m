% Wait for the scanner to start, turn the screen black (just a fixation
% cross). Then wait until the dummy scans have past.
if fmri==1
    while kbcheck;end %make sure all keys are released
    
    % present a black screen saying
    text = {'Even geduld alstublieft','we gaan zo meteen weer verder.','Schrik niet van de geluiden en','probeer uw hoofd stil te houden.**'};
    displaytext(text,wd,wdw,wdh,orange,0,0);
    [ keyIsDown, timeSecs, keyCode ] = KbCheck; 
    while ~keyCode(enter); [ keyIsDown, timeSecs, keyCode ] = KbCheck;end
    while KbCheck; end 
end
% start the experiment

