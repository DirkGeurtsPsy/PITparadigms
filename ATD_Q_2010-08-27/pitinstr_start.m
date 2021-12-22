fprintf('............ Displaying instructions ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if dutch
    text={'Ok, nu komt het belangrijkste deel.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Ok, jetzt kommt der wichtigste Teil.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
    text={'We zullen u echter niet meer vertellen,','hoevel u verdient heeft.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Wir werden Ihnen aber nicht mehr sagen,','wie viel Sie verdient haben.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if dutch
        text={'De punten worden desalniettemin','verder bijgehouden.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
else
    text={'Die Punkte werden dennoch','weiterhin gezaehlt.'};
    displaytext(text,wd,wdw,wdh,orange,1,0);
end

if approach
    if dutch
        text={'Verzameld u gewoon weer','goede paddenstoelen.','    ','Klik op de muis om door te gaan.'};
    else
        text={'Sammeln Sie einfach weiter','gute Pilze ein.','    ','Klicken Sie die Maus, um fortzufahren.'};
    end
else
    if dutch
        text={'Gooit u weer gewoon','de giftige paddenstoelen weg.','    ','Klik op de muis om door te gaan.'};
    else
        text={'Werfen Sie einfach weiter','giftige Pilze weg.','    ','Klicken Sie die Maus, um fortzufahren.'};
    end
end
displaytext(text,wd,wdw,wdh,orange,1,0);

