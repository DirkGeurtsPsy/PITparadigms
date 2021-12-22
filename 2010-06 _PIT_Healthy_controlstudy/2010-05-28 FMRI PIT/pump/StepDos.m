% Class "StepDos"
%
% *Methods*
% - runPump
% - startPump
% - stopPump
% - setRunDuration
% - setFlowRate
%
%
% *Example*
% The controller is connected to the first serial port of a
% windows computer (COM1). The run duration for pump1 is set to 1.5 seconds and the
% flowrate to 50%. Finally the runPump method is used to... run the pump!
% When you're really done, close the object. This will close and cleanup all the
% references to the serial port.
%
% stepdos = StepDos('com1');
% stepdos.setRunDuration(1, 1500);
% stepdos.setFlowRate(1, 50);
% stepdos.runPump(1);
%
% ... do more stuff here
% ...
%
% stepdos.close();
%
% Another oneliner example (handy for testing):
%
% a = StepDos('com1'); a.setFlowRate(1, 80); a.runPump(1); a.close();
%
% If called with an empty com port string, no serial connection will be
% established. The serial commands will be echo'd to stdout:
%
% a = StepDos('')
% ...
%
%
% *Protocol*
% Custom protocol for the StepDos controller:
%
% 1 -> Runs pump 1 for the set duration
% 2 -> Runs pump 2 for the set duration
% 3 -> Runs pump 3 for the set duration
%
% 11 -> Starts pump 1
% 12 -> Starts pump 2
% 13 -> Starts pump 3
%
% 21 -> Stops pump 1
% 22 -> Stops pump 2
% 23 -> Stops pump 3
%
% 31 [duration] -> Sets run duration for pump 1 to [duration] milliseconds
% 32 [duration] -> Sets run duration for pump 2 to [duration] milliseconds
% 33 [duration] -> Sets run duration for pump 3 to [duration] milliseconds
%
% 41 [flow rate] -> Sets the relative flow rate* for pump 1, 0 - 10000 ^ 0 ? 100%
% 42 [flow rate] -> Sets the relative flow rate* for pump 2, 0 - 10000 ^ 0 ? 100%
% 43 [flow rate] -> Sets the relative flow rate* for pump 3, 0 - 10000 ^ 0 ? 100%


classdef StepDos
    
    properties (SetAccess = public)
        serobj;
        debugmode = false;
    end
    
    methods
        function SD = StepDos(comport)
            if (strcmp(comport, ''))
                fprintf('StepDos: No Com port given, running in debug mode...\n')
                SD.debugmode = true;
            end
            
            if (not(SD.debugmode))
                %delete(instrfind);
                SD.serobj = serial(comport);
                
                % serial port configuration
                set(SD.serobj, 'Baudrate', 9600);
                set(SD.serobj, 'Parity', 'none');
                set(SD.serobj, 'Databits', 8); % number of data bits
                set(SD.serobj, 'StopBits', 1); % number of stop bits
                set(SD.serobj, 'Terminator', 'CR/LF'); % line ending character
                % see also:
                % http://www.mathworks.com/matlabcentral/newsreader/view_original/292759
                
                set(SD.serobj, 'InputBufferSize', 1); % set read buffBuffer for read
                set(SD.serobj, 'FlowControl', 'none'); %
                
                % open the serial port
                fopen(SD.serobj);
                
                % since matlab pulls the DTR line, the arduino will reset
                % so we have to wait for the initialization of the controller
                oldState = pause('query');
                pause on;
                pause(2.5);
                pause(oldState);
            end
        end
        
        % runPump
        % pumpNumber - number of the pump 1,2 or 3
        function runPump(SD, pumpNumber)
            offset = 1; % number to send for the first pump
            cmd = sprintf('%d', offset - 1 + pumpNumber);
            SD.sendcmd(cmd);
        end
        
        
        % startPump
        % pumpNumber - number of the pump 1,2 or 3
        function startPump(SD, pumpNumber)
            offset = 11; % number to send for the first pump
            cmd = sprintf('%d', offset - 1 + pumpNumber);
            SD.sendcmd(cmd);
        end
        
        
        % stopPump
        % pumpNumber - number of the pump 1,2 or 3
        function stopPump(SD, pumpNumber)
            offset = 21; % number to send for the first pump
            cmd = sprintf('%d', offset - 1 + pumpNumber);
            SD.sendcmd(cmd);
        end
        
        % setRunDuration
        % pumpNumber - number of the pump 1,2 or 3
        % time - flow time in miliseconds
        function setRunDuration(SD, pumpNumber, time)
            offset = 31; % number to send for the first pump
            cmd = sprintf('%d %d', offset - 1 + pumpNumber, time);
            SD.sendcmd(cmd);
        end
        
        % setFlowRate
        % pumpNumber - number of the pump 1,2 or 3
        % flowRate - percentage (0 <= flowRate <= 100)
        function setFlowRate(SD, pumpNumber, flowRate)
            offset = 41; % number to send for the first pump
            cmd = sprintf('%d %d', offset - 1 + pumpNumber, round(flowRate * 100));
            SD.sendcmd(cmd);
        end
        
        
        function sendcmd(SD, cmd)
            if (SD.debugmode)
                fprintf('StepDos: sending: ');
                fprintf(cmd);
                fprintf('\n');
            else
                fprintf(SD.serobj, cmd);
            end
        end
        
        % close
        function close(SD)
            if (not(SD.debugmode))
                fclose(SD.serobj);
                delete(SD.serobj);
            end
        end
    end
end
