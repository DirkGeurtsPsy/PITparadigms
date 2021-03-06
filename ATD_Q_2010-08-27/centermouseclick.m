
% write the text, don't flip screen yet
%if approach 
	if english
		txt = {'Click in the square below to continue.'};
    elseif dutch
        txt= {'Klik hieronder in het vierkant om verder te gaan.'};
    else
		%txt = {'Klicken Sie bitte kurz in das Quadrat, um weiterzumachen','(Taste nicht gedrueckt halten.)'};
		txt = {'Klicken Sie bitte kurz in das Quadrat, um weiterzumachen'};
	end
	[wt]=Screen(wd,'TextBounds',txt{1});
	xpos=wdw/2-wt(3)/2;
	ypos=wdh/2+2*(-1)*wt(4);
	Screen('Drawtext',wd,txt{1},xpos,ypos,orange);

	%[wt]=Screen(wd,'TextBounds',txt{1});
	%xpos=wdw/2-wt(3)/2;
	%ypos=wdh/2+2*(-1.5)*wt(4);
	%Screen('Drawtext',wd,txt{1},xpos,ypos,orange);
	%[wt]=Screen(wd,'TextBounds',txt{2});
	%xpos=wdw/2-wt(3)/2;
	%ypos=wdh/2+2*(-1/2)*wt(4);
	%Screen('Drawtext',wd,txt{2},xpos,ypos,orange);
%elseif ~approach 
%	if english
%		txt = {'To continue, please click','in the square below and','hold the mouse key.'};
%	else
%		txt = {'Klicken Sie in das Quadrat,','und halten Sie die Taste gedrueckt','um weiterzumachen'};
%	end
%	[wt]=Screen(wd,'TextBounds',txt{1});
%	xpos=wdw/2-wt(3)/2;
%	ypos=wdh/2+2*(-2.5)*wt(4);
%	Screen('Drawtext',wd,txt{1},xpos,ypos,orange);
%	[wt]=Screen(wd,'TextBounds',txt{2});
%	xpos=wdw/2-wt(3)/2;
%	ypos=wdh/2+2*(-1.5)*wt(4);
%	Screen('Drawtext',wd,txt{2},xpos,ypos,orange);
%	[wt]=Screen(wd,'TextBounds',txt{3});
%	xpos=wdw/2-wt(3)/2;
%	ypos=wdh/2+2*(-0.5)*wt(4);
%	Screen('Drawtext',wd,txt{3},xpos,ypos,orange);
%end

% make a small box in the center below the text 
xp=wdw/2;
yp=.6*wdh;
bxl=20;
redbox = [[xp-bxl;yp+bxl] [xp+bxl;yp+bxl] [xp+bxl;yp+bxl] [xp+bxl;yp-bxl] [xp+bxl;yp-bxl] [xp-bxl;yp-bxl] [xp-bxl;yp-bxl] [xp-bxl;yp+bxl]];
Screen('DrawLines',wd,redbox,2,orange);

Screen('Flip',wd,[],1);

% wait until subject clicks inside the box, then move on. 
wait=1;
while wait
%	if approach 
		buttons=[0 0 0 0];
		while ~any(buttons);[x,y,buttons]=GetMouse;end
		while  any(buttons);[x,y,buttons]=GetMouse;end
%	else 
%		[x,y,buttons]=GetMouse;
%		if any(buttons); 
%			while  any(buttons);[x,y,buttons]=GetMouse;end
%		end
%		while ~any(buttons);[x,y,buttons]=GetMouse;end
%	end

	if x>=xp-bxl & x<=xp+bxl & y>=yp-bxl & y<=yp+bxl;	% did we click in the square? 
		wait=0;
	end
	checkabort;
end

Screen('Fillrect',wd,ones(1,3)*bgcol(1));
Screen('Flip',wd);
