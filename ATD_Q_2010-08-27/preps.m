
aborted=0; % if this parameter is set to one, things will abort. 

total = 10;% start Pavlovian training out with 10 Euros
wrong = 0; % initialize number of errors

% order.mat is a matrix containing 0's and 1's, which determines whether a
% subject starts with the approach or the avoidance trial. 
load order2;
approach = ordering(str2num(subjn)-1000);	 % this depends on subject numbering
Z.approachstart=approach;						 % 1 if start with approach

% make sure we use different random numbers
rand('twister',sum(1000*clock));

% make a unique string to save data 
namestring=[datestr(now,'yymmdd_HHMM_') subjn '_' type '_' name];
namestring2=['subject_' subjn]; 				% and also just save it by subject number

% print out in command window if we're saving stuff
if dosave 
	fprintf('............ Data is being saved as                              \n');
	fprintf('............ %s                                       \n',namestring);
end

%....................... Pavlovian block 


Z.Npspos=sum(Z.Pavout>0);					% Number of positive Pavlovian Stimuli 
Z.Npsneg=sum(Z.Pavout==0);					% Number of negative Pavlovian Stimuli 
Z.Npsneu=sum(Z.Pavout<0);					% Number of neutral Pavlovian Stimuli 
Z.Nps = length(Z.Pavout);					% Number of Pavlovian stimuli per value 
if length(Z.P)~=Z.Npspos;error('Pav stim and probs not equal length');end

Npavtot = sum(Z.Npav);
[foo,i]=sort(rand(1,Z.Nps*ceil(Npavtot/Z.Nps)));	% Pavlovian presentation sequence
	tmp =  [1:Z.Nps]'*ones(1,ceil(Npavtot/Z.Nps));	% ensure equal number of stimulus
	pavpres = tmp(i);											% presentations. 
posp = ones(Npavtot,1);										% Whether to present stimulus on left or right

%................ Stimulus value sequence 

pavout = Z.Pavout(pavpres);

%................ Pavlovian comparison trials 
Z.Ncp = Npavtot/Z.cpmod;									% how many comparison trials 
[foo,i]=sort(rand(1,Z.Ncp));	  							% comparison stimulus 1 
	tmp = [1:Z.Nps]'*ones(1,ceil(Z.Ncp/Z.Nps));
	cppres(1,:) = tmp(i);
cppres(2,:) = ceil((Z.Nps-1)*rand(1,Z.Ncp)); 		% comparison stimulus 2 
for k=1:Z.Nps-1												% don't compare stimulus to itself
	i=(cppres(1,:)==k) & (cppres(2,:)>=k);
	cppres(2,i) = cppres(2,i)+1;
end
for t=1:Z.Ncp; 												% randomize presentation side 
	[foo,i]=sort(rand(2,1));
	cppres(:,t)=cppres(i,t);
end 


%....................... Instrumental training block 
appr = 1:Z.Ntrain;appr=appr<=Z.Ntrain/2; if ~Z.approachstart; appr = ~appr;end

[foo,i]=sort(rand(1,Z.Ntrain));			   					% go or nogo trial. this ensures all
	tmp = [1:2]'*ones(1,ceil(Z.Ntrain/2)); 					% actions are presented equally often
	ainst = tmp(i)';

[foo,i]=sort(rand(1,Z.Ntrain));									% go or nogo trial 
	tmp = [1:Z.Ninst]'*ones(1,ceil(Z.Ntrain/Z.Ninst));
	mprest = tmp(i)';
mprest(~appr) = mprest(~appr)+2*Z.Ninst; 									% 1:2*Z.Ninst are approach block stimuli
mprest(ainst==2 &  appr') = Z.Ninst + mprest(ainst==2 &  appr'); 	% nogo in appr block for stim >Z.Ninst
mprest(ainst==1 & ~appr') = Z.Ninst + mprest(ainst==1 & ~appr'); 	% go in withdr block for stim >Z.Ninst

lrt = ceil(2*rand(Z.Ntrain,1)); lrt(lrt==2)=3;	% whether to present instr stimulus on left or right

crtfb = (1:Z.Ntrain)<=Z.Ntrain*Z.Pi;				% give accurate (1) or false (0) feedback
	[foo,i]=sort(rand(1,Z.Ntrain));
	crtfb=crtfb(i);

%....................... PIT block 
appr = 1:Z.Npit;appr=appr<=Z.Npit/2; if ~Z.approachstart; appr = ~appr;end

[foo,i]=sort(rand(1,Z.Npit));			    						% go or nogo trial. this ensures all
	tmp = [1:2]'*ones(1,ceil(Z.Npit/2)); 						% actions are presented equally often
	ains = tmp(i)';

[foo,i]=sort(rand(1,Z.Npit));										% go or nogo trial 
	tmp = [1:Z.Ninst]'*ones(1,ceil(Z.Npit/Z.Ninst));
	mpres = tmp(i)';
mpres(~appr) = mpres(~appr)+2*Z.Ninst; 								% 1:2*Z.Ninst are approach block stimuli
mpres(ains==2 &  appr') = Z.Ninst + mpres(ains==2 &  appr'); 	% nogo in appr block for stim >Z.Ninst
mpres(ains==1 & ~appr') = Z.Ninst + mpres(ains==1 & ~appr'); 	% go in withdr block for stim >Z.Ninst

lr = ceil(2*rand(Z.Npit,1)); lr(lr==2)=3;	% whether to present instr stimulus on left or right

[foo,i]=sort(rand(1,Z.Npit));					% which Pavlovian stimulus to present with instructed stimulus 
	tmp =  [1:Z.Nps]'*ones(1,ceil(Z.Npit/Z.Nps));
	mpresp = tmp(i);

clear appr;

