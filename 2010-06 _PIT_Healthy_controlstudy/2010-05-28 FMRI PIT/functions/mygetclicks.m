[ keyIsDown, timeSecs, keyCode ] = KbCheck; 
 while ~keyIsDown||find(keyCode)==53; 
     [ keyIsDown, timeSecs, keyCode ] = KbCheck; 
 end
 while KbCheck end 

%  buttons=[0 0 0 0];
% while ~any(buttons);[x,y,buttons]=GetMouse;end
% while  any(buttons);[x,y,buttons]=GetMouse;end
