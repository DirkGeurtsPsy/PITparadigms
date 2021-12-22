fprintf('............ Displaying instructions ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if block==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if start==1
    word1='paddenstoel';
    word2='door een bos';
elseif start==0
    word1='schelp';
    word2='over een strand';
end

if dutch==1
    text{1}={'Ok, nu komt het belangrijkste deel.','(Druk op een toets om verder te gaan)'};
    text{2}={'We vragen u hetzelfde spelletje te spelen','als in het eerste gedeelte.',['De ',word1,'envelden zijn hetzelfde gebleven.'],'Ze leveren nog steeds even vaak geld en verlies op,','als in het eerste gedeelte.'};
    text{3}={'We gaan u nu echter niet meer vertellen,','hoeveel u verdient.'};
    text{4}={'Het geld wordt echter nog wel bijgehouden','en achteraf verrekend!'};
    text{5}={'U krijgt in dit gedeelte tijdens het spel','de plaatjes uit het vorige deel te zien.','Het sap van de plaatjes','wordt buiten de scanner opgevangen in verschillende glazen','deze krijgt u (net als het geld) na het experiment','om te drinken.'};
    text{6}={'Probeert u weer zoveel mogelijk','geld te verdienen.','(Druk op de knop om te starten.)'};
elseif english==1
end

for r=1:6
 displaytext(text{r},wd,wdw,wdh,orange,1,0);
end

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif block==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if start==1
    word1=['paddenstoel'];
    word2=['door een bos'];
elseif start==0
    word1=['schelp'];
    word2=['over een strand'];
end

if dutch==1
    text{1}={'Ok, nu komt het belangrijkste deel.','(Druk op een toets om verder te gaan)'};
    text{2}={'We vragen u hetzelfde spelletje te spelen','als in het eerste gedeelte.',['De ',word1,'envelden zijn hetzelfde gebleven.'],'Ze leveren nog steeds even vaak geld en verlies op,','als in het eerste gedeelte.'};
    text{3}={'We gaan u nu echter niet meer vertellen,','hoeveel u verdient.'};
    text{4}={'Het geld wordt echter nog wel bijgehouden','en achteraf verrekend!'};
    text{5}={'U krijgt in dit gedeelte tijdens het spel','de plaatjes uit het vorige deel te zien.','Het sap van de plaatjes','wordt buiten de scanner opgevangen in verschillende glazen','deze krijgt u (net als het geld) na het experiment','om te drinken.'};
    text{6}={'Probeert u weer zoveel mogelijk','geld te verdienen.','(Druk op de knop om te starten.)'};
elseif english==1
end

for r=1:6
 displaytext(text{r},wd,wdw,wdh,orange,1,0);
end

end
