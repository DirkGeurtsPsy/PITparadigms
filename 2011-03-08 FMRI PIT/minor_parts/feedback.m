%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if block==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if start==1
        payout1 =(nansum(O(13,1:Tr.Tot1))*0.05) + (nansum(O(13,Tr.Tot2+1:Tr.Tot3))*0.05);
elseif start==0
        payout1 =(nansum(O2(13,1:Tr.Tot1))*0.05) + (nansum(O2(13,Tr.Tot2+1:Tr.Tot3))*0.05);
end

if dutch==1
text{1}={'U heeft inclusief het voorgaande onderdeel','in totaal',[num2str(payout1) ' Euro verdiend!'],'(Druk op een toets om verder te gaan)'};
text{2}={'U heeft tijdens het laatste deel','ook 16 ml vieze sap verzameld,','maar gelukkig ook 16 ml lekkere sap','Dit krijgt u na het einde','van het hele spel te drinken.','(Druk op een toets om verder te gaan)'};
elseif english==1
end

for r=1:2;
    displaytext(text{r},wd,wdw,wdh,orange,1,0);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif block==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if start==1
        payout2 =(nansum(O(13,1:Tr.Tot1))*0.05) + (nansum(O(13,Tr.Tot2+1:Tr.Tot3))*0.05) + payout1;
elseif start==0
        payout2 =(nansum(O2(13,1:Tr.Tot1))*0.05) + (nansum(O2(13,Tr.Tot2+1:Tr.Tot3))*0.05) + payout1;
end

    
if dutch==1
text{1}={'U heeft inclusief het voorgaande onderdeel','in totaal',[num2str(payout2) ' Euro verdiend!'],'(Druk op een toets om verder te gaan)'};
text{2}={'U heeft tijdens het laatste deel','ook 16 ml vieze sap verzameld,','maar gelukkig ook 16 ml lekkere sap','Dit krijgt u na het einde','van het hele spel te drinken.','(Druk op een toets om verder te gaan)'};
elseif english==1
end

for r=1:2;
    displaytext(text{r},wd,wdw,wdh,orange,1,0);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
