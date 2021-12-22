aborted=0; % if this parameter is set to one, things will abort. 

% order.mat is a matrix containing 0's and 1's, which determines whether a
% subject starts with the approach or the avoidance trial. 
load order2;
approach = ordering(str2num(subjn)-1000);	 % this depends on subject numbering

% make sure we use different random numbers
rand('twister',sum(1000*clock));

% make a unique string to save data 
namestring=[datestr(now,'yymmdd_HHMM_') subjn '_' type '_' name];
namestring2=['subject_' subjn]; 				% and also just save it by subject number

start=round(rand(1));
if start==1
    gen.begin={'mushroom'};
elseif start==0
    gen.begin={'shells'};
end

% print out in command window if we're saving stuff
if dosave 
	fprintf('............ Data is being saved as                              \n');
	fprintf('............ %s                                       \n',namestring);
end

clear appr;


%% Set up (comport of) pump
COM         = input('COM (0 if no pump): ');
home        = pwd;
if COM ~=0;
    stepdos = setupPump(COM,pump);
end 

%% set up Bitsi on comport. post can be changed by command window input.
Bitsion=input('Do you want to use Bitsi? (0=no 1=yes)');
if Bitsion==1
ComPortB = input('ComPortBitsi?: ','s');
%bitsi = Bitsi('');
bitsi = Bitsi(ComPortB);
end

%%

