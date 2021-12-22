%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if block==1
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
text{1}={['Stelt u zich voor dat u een stip bent','en ',word2,' loopt'],['om ',word1,'en te verzamelen.']};
text{2}={['U komt op uw weg verschillende ',word1,'envelden tegen,'],'waarin zowel goede als slechte',[word1,'en staan.']};
text{3}={['Deze ',word1,'envelden zullen wij'],'u op het beeldscherm tonen (zie hierboven).'};
text{4}={['Als u ',word1,'en wilt '],'gaan verzamelen in het veld','dan moet u de stip door dit veld heen sturen.'};
text{5}={['Als u de ',word1,'en wilt laten staan'],'dan moet u met de stip','het veld ontwijken.'};
text{6}={'U besluit dus of u wel of niet',[word1,'en gaat verzamelen.']};
text{7}={'Ieder besluit leidt tot','of een beloning van 5 cent','of tot een verlies van 5 cent.'};
text{8}={'De goede velden zullen vaker,','maar niet altijd,',['goede ',word1,'en opleveren,'],'en dus geld,','als u de stip er doorheen laat gaan.'};
text{9}={'Als u met de stip NIET','door het goede veld gaat','zult u vaker, maar niet altijd,','geld verliezen.'};
text{10}={'De slechte velden zullen vaker,','maar niet altijd,',['slechte ',word1,'en opleveren'],'en dus geldverlies,','als u de stip er doorheen laat gaan.'};
text{11}={'Er zijn twee soorten wandelingen:'};
text{12}={'1. Bij de ene wandeling loopt u', 'recht op een veld af.',['Als u dan binnen ' num2str(nogodelay) ' seconde'], 'niets gedaan hebt','loopt u door het veld heen', ['en verzamelt u ',word1,'en.'],'Om het veld te ontwijken','moet u snel en vaak op de knop drukken'};
text{13}={'Van deze wandeling volgt nu een voorbeeld:','(druk op een knop om het voorbeeld te starten;','u kunt de stip nu nog NIET bewegen)'};
text{14}={'2. Bij de andere wandeling loopt u','langs het veld omhoog.', ['En verzamelt u geen ',word1,'en'],['als u ' num2str(nogodelay) ' seconde niets doet.'],'Om wel door het veld heen te gaan',['en dus ',word1,'en te verzamelen'],'moet u snel en vaak op de knop drukken.'};
text{15}={'Van deze wandeling volgt nu een voorbeeld:','(druk op een knop om het voorbeeld te starten;','u kunt de stip nu nog NIET bewegen)'};
text{16}={'Drukt u op de drukknop,','om te oefenen met het bewegen van de stip','(door snel en vaak te drukken).','Er volgen twee voorbeelden, waarbij u',['het ',word1,'enveld kan benaderen'],'en twee voorbeelden','waarbij u het ',word1,'enveld kan ontwijken.'};
text{17}={'Het kan zijn dat u maar een of tweemaal drukt','dan zult u het veld niet ontwijken of benaderen.','Dit is ook zo, als u te laat','begint met drukken.','U krijgt dan de volgende tekst te zien:','"Gedrukt, geen volledige actie"'};
text{18}={'Dit was alle informatie.','Veel succes','met het verdienen van zoveel mogelijk geld!'};
elseif english==1
end

for r=1:18
    if r==3
        texts=text{r};
        [wt]=Screen(wd,'TextBounds',texts{1});
        Screen('DrawText',wd,texts{1},wdw/2-wt(3)/2,y0+(yfrac*wdh),orange);
        [wt]=Screen(wd,'TextBounds',texts{2});
        Screen('Drawtext',wd,texts{2},wdw/2-wt(3)/2,y0+(yfrac*wdh)+1.5*txtsize,orange);
        % draw mushroom 
        tdr = drms; 
        tdr(:,[2 4]) = tdr(:,[2,4]);
        if start==1
        Screen('DrawTexture',wd,msh(1),[],tdr(2,:));
        elseif start==0
        Screen('DrawTexture',wd,shll(1),[],tdr(2,:));
        end
        WaitSecs(.01);	
        Screen('Flip',wd,[],1);
        WaitSecs(.01);	
        Screen('Flip', wd);
        mygetclicks;
    elseif r==13
        displaytext(text{r},wd,wdw,wdh,orange,1,0);
        example_nogo_avoid;	
        WaitSecs(.01);	
        Screen('Flip',wd,[],1);
        WaitSecs(.01);	
        Screen('Flip', wd);
    elseif r==15
        displaytext(text{r},wd,wdw,wdh,orange,1,0);
        example_nogo_approach
        WaitSecs(.01);	
        Screen('Flip',wd,[],1);
        WaitSecs(.01);	
        Screen('Flip', wd);
    elseif r==16
        displaytext(text{r},wd,wdw,wdh,orange,1,0);
        for R=1:4
        X=0;
        training
        end
    elseif r~=3||r~=13||r~=15||r~=16
        displaytext(text{r},wd,wdw,wdh,orange,1,0);
    end 
end
  
  



fprintf('.........done\n')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif block==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if start==1
    word1=['paddenstoel'];
    word2=['schelp'];
elseif start==0
    word1=['schelp'];
    word2=['paddenstoel'];
end

if dutch==1
text{1}={'We gaan hetzelfde nogmaals doen.','U krijgt nu alleen ',[word1,'envelden te zien in plaats van ',word2,'envelden.']};
text{2}={'De velden leveren wederom geld of verlies op.'};
text{3}={'Succes met het winnen van veel geld','Druk op een knop om het spel weer te starten.'};
elseif english==1
end

for r=1:3
    displaytext(text{r},wd,wdw,wdh,orange,1,0);
end

end

