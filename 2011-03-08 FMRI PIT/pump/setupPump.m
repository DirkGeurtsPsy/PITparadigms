function stepdos = setupPump(COM,pump)

% Initialise the pump: the controller is connected to the first serial port
% of a windows computer (COM). First we initialise the pump, then we set
% the runDuration and flowRate. Next we calculate the tubevolume (depend
% on input 'tubelength') and run both pumps for the calculated duration to
% make sure the tubes are filled.

stepdos = StepDos(['com' num2str(COM)]);

stepdos.setRunDuration(1, pump.runDuration);
stepdos.setRunDuration(2, pump.runDuration);
stepdos.setRunDuration(3, pump.runDuration);
stepdos.setFlowRate(1, pump.flowRate);
stepdos.setFlowRate(2, pump.flowRate);
stepdos.setFlowRate(3, pump.flowRate);

fprintf('Fill the tubes - press space to continue...\n');
KbWait;

% make sure the tubes are filled: turn pumps 1, 2 and 3 on, flush pumps for 
% calculated period ('duration'), then turn off again. Note that max
% flowrate is (30ml/min) 
duration    = pump.tubeVol/(0.3*pump.flowRate); 
stepdos.runPump(11);
stepdos.runPump(12);
stepdos.runPump(13);
WaitSecs(60*duration);
stepdos.runPump(21);
stepdos.runPump(22);
stepdos.runPump(23);

end