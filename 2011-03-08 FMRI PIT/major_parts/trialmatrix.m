%% make trialmatrices
% Outcome matrix for whole experiment:
% XXX  = > set in this file    O  = > written during experiment

% row1 =  trialnumber                                             XXX
% row2 =  Approach/withdrawal for instrumental and PIT trials     XXX
% row3 =  which stimulus to present for Inst/Pav/PIT              XXX
% row4 =  value of stimulus                                       XXX
% row5 =  outcome go                                              XXX
% row6 =  outcome nogo                                            XXX
% row7 =  outcome pav                                             XXX
% row8 =  on which side to present the blue wall                  XXX
% row9 =  reaction time                                            O
% row10 =  response frequency                                      O
% row11 =  choice                                                  O
% row12 =  correct/incorrect                                       O
% row13 =  reward                                                  O
% row14 =  number of presses                                       O
% row15 =  time first keypress                                     O
% row16 =  time last keypress                                      O
% row17 =  time stim pres                                          O
% row18 =  time till end trial                                     O
% row19 =  time feedback switched on                               O
% row20 =  time feedback switched off                              O
% row21 =  time ON trial                                           O
% row22 =  time OFF trial                                          O
% row23 =  pavlovian stimulus on PIT trials                       XXX
% row24 =  value of pavlovian stimulus                            XXX

% row25 =  adjusted choice (<3 buttonpresses is regarded as nogo)
% row26 =  adjusted correct/incorrect
% row27 =  subjectnumber
% row28 =  x-coordinate of dot when it leaves the screen

O = NaN(28,(Tr.Tot3)); % Make NaN structure to fill out

% matrix which determines which are good and which are bad stimuli
S = NaN(2,St.Inst.N+St.Pav.N);


%% make index for all trials in instrumentaltraining
Trialnumber = [1:Tr.TotInst,1001:(Tr.TotPav+1000),2001:(Tr.TotPIT+2000)];
O(1,:) = Trialnumber; % row 1 of outcome filled in.





%% make index for approach or withdrawal trials in:
% instrumenstal task.
% approach = 1
% withdrawal = 2
% pavlovian = 3

ff.a = [1 2];
ff.a = mix(ff.a); %mix is radomization function
approach = (ff.a(1,1));

if approach == 1; % set in preps
    
    Approach1 = 1;
    A = [1*ones(1,Tr.InstMB) 2*ones(1,Tr.InstMB)];
    
elseif approach ~= 1
    
    Approach1 = 0;
    A = [2*ones(1,Tr.InstMB) 1*ones(1,Tr.InstMB)];
    
end

Ind.Inst = repmat(A,1,(Tr.TotInst/Tr.InstMB/2));
O(2,1:Tr.TotInst) = Ind.Inst; % row 2 of Outcome partially filled in.

%in PIT task
% approach = 1
% withdrawal = 2

ff.a = [1 2];
ff.a = mix(ff.a);
approach = (ff.a(1,1));

if approach == 1;
    
    Approach2 = 1;
    A = [1*ones(1,Tr.PITMB) 2*ones(1,Tr.PITMB)];
    
elseif approach ~= 1;
    
    Approach2 = 0;
    A = [2*ones(1,Tr.PITMB) 1*ones(1,Tr.PITMB)];
    
end

Ind.PIT = repmat(A,1,(Tr.TotPIT/Tr.InstMB/2));
O(2,(Tr.Tot2+1):(Tr.Tot3)) = Ind.PIT; % row 2 of Outcome partially filled in.

% in Pavlovian trials
% pavlovian = 3
Ind.Pav = 3*((1:Tr.TotPav)./(1:Tr.TotPav));
O(2,(Tr.TotInst+1):(Tr.Tot2)) = Ind.Pav;





%% make index for Instrumental, PIT and Pavlovian stimuli for:
%alternating approach and avoidance
A   = 1:St.Inst.N;
A   = mix(A);
A1  = A(1,1:(St.Inst.N/2));            %A1 = instrumental approach stimuli
A2  = A(1,((St.Inst.N/2)+1):St.Inst.N);%A2 = instrumental withdrawal stimuli

% make index for instrumental approach stimuli
ff.a = (Tr.TotInst/2)/length(A1);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.Inst.Appr = [];

for F = 1:ff.b
    
    Mx.Inst.Appr = [Mx.Inst.Appr A1];
    
end

ff.c = ff.c*length(A1);

for F = 1:ff.c
    
    A1 = mix(A1);
    Mx.Inst.Appr = [Mx.Inst.Appr A1(1,1)];
    
end

Mx.Inst.Appr = mix(Mx.Inst.Appr);

%make index for instrumental avoidance stimuli
ff.a = (Tr.TotInst/2)/length(A2);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.Inst.With = [];

for F = 1:ff.b
    
    A2 = mix(A2);
    Mx.Inst.With = [Mx.Inst.With A2];
    
end

ff.c = ff.c*length(A1);

for F = 1:ff.c
    
    A2 = mix(A2);
    Mx.Inst.With = [Mx.Inst.With A2(1,1)];
    
end

Mx.Inst.With = mix(Mx.Inst.With);

% make index for PIT stimuli for
% alternating approach and avoidance
% make index for PIT approach stimuli

ff.a = (Tr.TotPIT/2)/length(A1);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.PIT.Appr = [];

for F = 1:ff.b
    
    Mx.PIT.Appr = [Mx.PIT.Appr A1];
    
end

ff.c = ff.c*length(A1);

for F = 1:ff.c
    
    A1 = mix(A1);
    Mx.PIT.Appr = [Mx.PIT.Appr A1(1,1)];
    
end

Mx.PIT.Appr = mix(Mx.PIT.Appr);

%make index for PIT avoidance stimuli
ff.a = (Tr.TotPIT/2)/length(A2);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.PIT.With = [];

for F = 1:ff.b
    
    A2 = mix(A2);
    Mx.PIT.With = [Mx.PIT.With A2];
    
end

ff.c = ff.c*length(A2);

for F = 1:ff.c
    
    A2 = mix(A2);
    Mx.PIT.With = [Mx.PIT.With A2(1,1)];
    
end

Mx.PIT.With = mix(Mx.PIT.With);

%make index for Pavlovian stimuli
Ap = (1:(2*St.Pav.N))+St.Inst.N;
Ap = mix(Ap);
A3 = Ap(1,1:St.Pav.N);
A = repmat(A3, 1, Tr.TotPav/St.Pav.N);
Mx.Pav.Pav = mix(A);
A = repmat(A3, 1, floor(Tr.TotPIT/St.Pav.N));

for R = 1:(Tr.TotPIT-length(A));
    
    A = [A A3(1,R)];
    
end

Mx.Pav.PIT = mix(A);

% fill instrumental, Pav and PIT stimuli in O
X = O(2,:);

X(X == 1) = 100;
X(X == 2) = 200;
X(X == 3) = 300;

X(ceil(X) == 100) = [Mx.Inst.Appr Mx.PIT.Appr];
X(ceil(X) == 200) = [Mx.Inst.With Mx.PIT.With];
X(ceil(X) == 300) = [Mx.Pav.Pav];
O(3,1:(Tr.Tot3)) = X; % row 3: stimulus is filled in for instrumental,Pav and PIT stimuli.

% fill O23 for PIT: Pavlovian cues are  equally divided over the different
% instrumental stimuli.
O(23,Tr.Tot2+1:Tr.Tot3) = O(3,Tr.Tot2+1:Tr.Tot3);

for F = 1:St.Inst.N
    
    X = mix(repmat(A3,1,(Tr.TotPIT/St.Inst.N/length(A3))));
    O(23,find(O(23,:) == F)) = X;
    
end





%% assign stimulus value
A1 = mix(A1); %instrumental approach stimuli
A2 = mix(A2); %instrumental withdrawal stimuli
A3 = mix(A3); %pavlovian stimuli

X = O(3,:);
Y = mix(St.Inst.V);
Z = mix(St.Pav.V);

for F = 1:(St.Inst.N/2/(length(Y)))
    
    X(X == A1(1,F)) = Y(1,1);
    X(X == A2(1,F)) = Y(1,1);
    
end

for F = ((St.Inst.N/2/(length(Y))+1):(St.Inst.N/2))
    
    X(X == A1(1,F)) = Y(1,2);
    X(X == A2(1,F)) = Y(1,2);
    
end

for F = 1:St.Pav.N
    
    X(X == A3(1,F)) = St.Pav.V(1,F);
    
end

O(4,:) = X;

X = O(23,Tr.Tot2+1:Tr.Tot3);

for F = 1:St.Pav.N
    
    X(X == A3(1,F)) = St.Pav.V(1,F);
    
end

O(24,(Tr.Tot2+1):Tr.Tot3) = X;





%% Outcome for Go

% outcome for Go in approach trials with positive inst stimulus in instrumental training.
stim = unique(O(3,(O(2,1:Tr.TotInst) == 1)&(O(4,1:Tr.TotInst)>0)));

for i = stim

    X = O(2,(O(3,1:Tr.TotInst) == i))*-1;
X((1:(St.Inst.F)*length(X)))= 1;
X = mix(X);
O(5,(O(3,1:Tr.TotInst) == i)) = X;

end

% outcome for Go in approach trials with negative inst stimulus in instrumental training.
stim = unique(O(3,(O(2,1:Tr.TotInst) == 1)&(O(4,1:Tr.TotInst)<0)));

for i = stim

    X = O(2,(O(3,1:Tr.TotInst) == i));
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O(5,(O(3,1:Tr.TotInst) == i)) = X;

end

% outcome for Go in withdrawal trials with positive inst stimulus in instrumental training.
stim = unique(O(3,(O(2,1:Tr.TotInst) == 2)&(O(4,1:Tr.TotInst)>0)));

for i = stim

    X = O(2,(O(3,1:Tr.TotInst) == i))/2;
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O(5,(O(3,1:Tr.TotInst) == i)) = X;

end

% outcome for Go in withdrawal trials with negative inst stimulus in instrumental training.
stim = unique(O(3,(O(2,1:Tr.TotInst) == 2)&(O(4,1:Tr.TotInst)<0)));

for i = stim

    X = O(2,(O(3,1:Tr.TotInst) == i))/2*-1;
X(1:((St.Inst.F)*length(X))) = 1;
X = mix(X);
O(5,(O(3,1:Tr.TotInst) == i)) = X;

end

%No outcome for pavlovian trials
O(5,(Tr.Tot1+1):Tr.Tot2) = 0;

% outcome for Go in approach trials with positive inst stimulus in PIT.
stim = unique(O(3,(O(2,(Tr.Tot2+1):Tr.Tot3) == 1)&(O(4,(Tr.Tot2+1):Tr.Tot3)>0)));

for i = stim

    X = O(2,(O(3,(Tr.Tot2+1):Tr.Tot3) == i))*-1;
X((1:(St.Inst.F)*length(X)))= 1;
X = mix(X);
O(5,(O(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end

% outcome for Go in approach trials with negative inst stimulus in PIT.
stim = unique(O(3,(O(2,(Tr.Tot2+1):Tr.Tot3) == 1)&(O(4,(Tr.Tot2+1):Tr.Tot3)<0)));

for i = stim

    X = O(2,(O(3,(Tr.Tot2+1):Tr.Tot3) == i));
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O(5,(O(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end

% outcome for Go in withdrawal trials with positive inst stimulus in PIT.
stim = unique(O(3,(O(2,(Tr.Tot2+1):Tr.Tot3) == 2)&(O(4,(Tr.Tot2+1):Tr.Tot3)>0)));

for i = stim

    X = O(2,(O(3,(Tr.Tot2+1):Tr.Tot3) == i))/2;
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O(5,(O(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end

% outcome for Go in withdrawal trials with negative inst stimulus in PIT.
stim = unique(O(3,(O(2,(Tr.Tot2+1):Tr.Tot3) == 2)&(O(4,(Tr.Tot2+1):Tr.Tot3)<0)));

for i = stim

    X = O(2,(O(3,(Tr.Tot2+1):Tr.Tot3) == i))/2*-1;
X(1:((St.Inst.F)*length(X))) = 1;
X = mix(X);
O(5,(O(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end



%% Outcome for NoGo
O(6,:) = -1.*O(5,:);





%% Outcome for Pavlovian
A = [];
r = [];
Y = [];
A = 1:(Tr.TotPav/St.Pav.N);
B = 1:(Tr.TotPav/St.Pav.N);
A = A./B;
A(1:((Tr.TotPav/St.Pav.N)*(1-St.Pav.F))) = 0;
A = mix(A);
B = mix(A);
C = mix(A);

O(7,(O(4,:) == St.Pav.V(1,1))) = A;
O(7,(O(4,:) == St.Pav.V(1,2))) = B;
O(7,(O(4,:) == St.Pav.V(1,3))) = C;





%% Side BW 1 = right 2 = left
%for Inst

A = (1:Tr.TotInst)./(1:Tr.TotInst);
A((Tr.TotInst/2+1):Tr.TotInst) = (1:(Tr.TotInst/2))./(1:Tr.TotInst/2).*2;
A = mix(A);

%for PIT
B = (1:Tr.TotPIT)./(1:Tr.TotPIT);
B((Tr.TotPIT/2+1):Tr.TotPIT) = (1:(Tr.TotPIT/2))./(1:Tr.TotPIT/2).*2;
B = mix(B);

% for Pav 0
C = (1:Tr.TotPav).*0;

% fill in the outcomematrix with BW.
O(8,1:(Tr.Tot3)) = [A C B];
%O(8,(O(2,:) == 2)) = 3;





%% Choice trials Pav
A = []; %will become C2 = stimulus to present left
B = []; %will become C3 = stimulus to present right
Co = [];
X = [];

for F = 1:floor(Tr.TotPav/Comp);

    X = O(3,(Tr.TotInst+((F-1)*Comp+1)):(Tr.TotInst+(F*Comp))); % make array to choose stimuli from
    X = mix(X);                       % mix stimuli
    A = [A (X(1,1))];                 % fill left presentation
    
    if X(1,1) ~= X(1,2);          % fill right presentation if stimulus is not the same as left
    
        B = [B (X(1,2))];
    
    else                        %else fill right with following stimulus,
    
        for Y = 1:(Comp*F)
        
            if X(1,1) ~= X(1,Y);     %if that one isn't the same either, or else try following.
            
                B = [B X(1,Y)];
                break
            
            end
            
        end
        
    end
    
end

Co(1,1:length(A)) = [1:length(A)];
Co(2:3,:) = [A;B];                  %fill Comparison matrix
Co(4,1:length(A)) = NaN;


%%
%% MAKE SECO2ND MATRIX
%%
% Exaactly the same as constructing first matrix, but different
% instrumental stimuli, and different sequence.

O2 = NaN(28,(Tr.Tot3));


% matrix which determines which are good and which are bad stimuli
S = NaN(2,St.Inst.N+St.Pav.N);





%% make index for all trials in instrumentaltraining
Trialnumber = [1:Tr.TotInst,1001:(Tr.TotPav+1000),2001:(Tr.TotPIT+2000)];
O2(1,:) = Trialnumber; % row 1 of outcome filled in.





%% make index for approach or withdrawal trials in
% instrumenstal task.
% approach = 1
% withdrawal = 2
% pavlovian = 3

ff.a = [1 2];
ff.a = mix(ff.a);
approach = (ff.a(1,1));

if approach == 1;

    Approach1 = 1;
    A = [1*ones(1,Tr.InstMB) 2*ones(1,Tr.InstMB)];

elseif approach ~= 1

    Approach1 = 0;
    A = [2*ones(1,Tr.InstMB) 1*ones(1,Tr.InstMB)];

end

Ind.Inst = repmat(A,1,(Tr.TotInst/Tr.InstMB/2));
O2(2,1:Tr.TotInst) = Ind.Inst; % row 2 of O2utcome partially filled in.

%in PIT task
% approach = 1
% withdrawal = 2
ff.a = [1 2];
ff.a = mix(ff.a);
approach = (ff.a(1,1));

if approach == 1;

    Approach2 = 1;
    A = [1*ones(1,Tr.PITMB) 2*ones(1,Tr.PITMB)];

elseif approach ~= 1;

    Approach2 = 0;
    A = [2*ones(1,Tr.PITMB) 1*ones(1,Tr.PITMB)];

end

Ind.PIT = repmat(A,1,(Tr.TotPIT/Tr.InstMB/2));
O2(2,(Tr.Tot2+1):(Tr.Tot3)) = Ind.PIT; % row 2 of O2utcome partially filled in.

% in Pavlovian trials
% pavlovian = 3
Ind.Pav = 3*((1:Tr.TotPav)./(1:Tr.TotPav));
O2(2,(Tr.TotInst+1):(Tr.Tot2)) = Ind.Pav;





%% make index for Instrumental, PIT and Pavlovian stimuli for
%alternating approach and avoidance
A = 1:St.Inst.N;
A = mix(A);
A1 = A(1,1:(St.Inst.N/2));
A2 = A(1,((St.Inst.N/2)+1):St.Inst.N);

% make index for instrumental approach stimuli
ff.a = (Tr.TotInst/2)/length(A1);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.Inst.Appr = [];

for F = 1:ff.b

    Mx.Inst.Appr = [Mx.Inst.Appr A1];

end

ff.c = ff.c*length(A1);

for F = 1:ff.c

    A1 = mix(A1);
    Mx.Inst.Appr = [Mx.Inst.Appr A1(1,1)];

end

Mx.Inst.Appr = mix(Mx.Inst.Appr);

%make index for instrumental avoidance stimuli
ff.a = (Tr.TotInst/2)/length(A2);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.Inst.With = [];

for F = 1:ff.b

    A2 = mix(A2);
    Mx.Inst.With = [Mx.Inst.With A2];

end

ff.c = ff.c*length(A1);

for F = 1:ff.c

    A2 = mix(A2);
    Mx.Inst.With = [Mx.Inst.With A2(1,1)];

end

Mx.Inst.With = mix(Mx.Inst.With);

% make index for PIT stimuli for
% alternating approach and avoidance
% make index for PIT approach stimuli
ff.a = (Tr.TotPIT/2)/length(A1);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.PIT.Appr = [];

for F = 1:ff.b

    Mx.PIT.Appr = [Mx.PIT.Appr A1];

end

ff.c = ff.c*length(A1);

for F = 1:ff.c

    A1 = mix(A1);
    Mx.PIT.Appr = [Mx.PIT.Appr A1(1,1)];

end

Mx.PIT.Appr = mix(Mx.PIT.Appr);

%make index for PIT avoidance stimuli
ff.a = (Tr.TotPIT/2)/length(A2);
ff.b = floor(ff.a);
ff.c = ff.a-ff.b;
Mx.PIT.With = [];

for F = 1:ff.b

    A2 = mix(A2);
    Mx.PIT.With = [Mx.PIT.With A2];

end

ff.c = ff.c*length(A2);

for F = 1:ff.c

    A2 = mix(A2);
    Mx.PIT.With = [Mx.PIT.With A2(1,1)];

end

Mx.PIT.With = mix(Mx.PIT.With);

%make index for Pavlovian stimuli
A3 = Ap(1,(St.Pav.N+1):(St.Pav.N*2));
A = repmat(A3, 1, Tr.TotPav/St.Pav.N);
Mx.Pav.Pav = mix(A);
A = repmat(A3, 1, floor(Tr.TotPIT/St.Pav.N));

for R = 1:(Tr.TotPIT-length(A));

    A = [A A3(1,R)];

end

Mx.Pav.PIT = mix(A);

% fill instrumental, Pav and PIT stimuli in O2
X = O2(2,:);

X(X == 1) = 100;
X(X == 2) = 200;
X(X == 3) = 300;

X(ceil(X) == 100) = [Mx.Inst.Appr Mx.PIT.Appr];
X(ceil(X) == 200) = [Mx.Inst.With Mx.PIT.With];
X(ceil(X) == 300) = [Mx.Pav.Pav];
O2(3,1:(Tr.Tot3)) = X; % row 3: stimulus is filled in for instrumental,Pav and PIT stimuli.

% fill O223 for PIT: Pavlovian cues are  equally divided over the different
% instrumental stimuli.
O2(23,Tr.Tot2+1:Tr.Tot3) = O2(3,Tr.Tot2+1:Tr.Tot3);

for F = 1:St.Inst.N

    X = mix(repmat(A3,1,(Tr.TotPIT/St.Inst.N/length(A3))));
    O2(23,find(O2(23,:) == F)) = X;

end





%% assign stimulus value
A1 = mix(A1); %instrumental approach stimuli
A2 = mix(A2); %instrumental withdrawal stimuli
A3 = mix(A3); %pavlovian stimuli

X = O2(3,:);
Y = mix(St.Inst.V);
Z = mix(St.Pav.V);

for F = 1:(St.Inst.N/2/(length(Y)))

    X(X == A1(1,F)) = Y(1,1);
    X(X == A2(1,F)) = Y(1,1);

end

for F = ((St.Inst.N/2/(length(Y))+1):(St.Inst.N/2))

    X(X == A1(1,F)) = Y(1,2);
    X(X == A2(1,F)) = Y(1,2);

end

for F = 1:St.Pav.N

    X(X == A3(1,F)) = St.Pav.V(1,F);

end

O2(4,:) = X;

X = O2(23,Tr.Tot2+1:Tr.Tot3);

for F = 1:St.Pav.N

    X(X == A3(1,F)) = St.Pav.V(1,F);

end

O2(24,(Tr.Tot2+1):Tr.Tot3) = X;





%% O2utcome for Go

%% Outcome for Go

% outcome for Go in approach trials with positive inst stimulus in instrumental training.
stim = unique(O2(3,(O2(2,1:Tr.TotInst) == 1)&(O2(4,1:Tr.TotInst)>0)));

for i = stim

    X = O2(2,(O2(3,1:Tr.TotInst) == i))*-1;
X((1:(St.Inst.F)*length(X)))= 1;
X = mix(X);
O2(5,(O2(3,1:Tr.TotInst) == i)) = X;

end

% outcome for Go in approach trials with negative inst stimulus in instrumental training.
stim = unique(O2(3,(O2(2,1:Tr.TotInst) == 1)&(O2(4,1:Tr.TotInst)<0)));

for i = stim

    X = O2(2,(O2(3,1:Tr.TotInst) == i));
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O2(5,(O2(3,1:Tr.TotInst) == i)) = X;

end

% outcome for Go in withdrawal trials with positive inst stimulus in instrumental training.
stim = unique(O2(3,(O2(2,1:Tr.TotInst) == 2)&(O2(4,1:Tr.TotInst)>0)));

for i = stim

    X = O2(2,(O2(3,1:Tr.TotInst) == i))/2;
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O2(5,(O2(3,1:Tr.TotInst) == i)) = X;

end

% outcome for Go in withdrawal trials with negative inst stimulus in instrumental training.
stim = unique(O2(3,(O2(2,1:Tr.TotInst) == 2)&(O2(4,1:Tr.TotInst)<0)));

for i = stim

    X = O2(2,(O2(3,1:Tr.TotInst) == i))/2*-1;
X(1:((St.Inst.F)*length(X))) = 1;
X = mix(X);
O2(5,(O2(3,1:Tr.TotInst) == i)) = X;

end

%No outcome for pavlovian trials
O2(5,(Tr.Tot1+1):Tr.Tot2) = 0;

% outcome for Go in approach trials with positive inst stimulus in PIT.
stim = unique(O2(3,(O2(2,(Tr.Tot2+1):Tr.Tot3) == 1)&(O2(4,(Tr.Tot2+1):Tr.Tot3)>0)));

for i = stim

    X = O2(2,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i))*-1;
X((1:(St.Inst.F)*length(X)))= 1;
X = mix(X);
O2(5,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end

% outcome for Go in approach trials with negative inst stimulus in PIT.
stim = unique(O2(3,(O2(2,(Tr.Tot2+1):Tr.Tot3) == 1)&(O2(4,(Tr.Tot2+1):Tr.Tot3)<0)));

for i = stim

    X = O2(2,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i));
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O2(5,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end

% outcome for Go in withdrawal trials with positive inst stimulus in PIT.
stim = unique(O2(3,(O2(2,(Tr.Tot2+1):Tr.Tot3) == 2)&(O2(4,(Tr.Tot2+1):Tr.Tot3)>0)));

for i = stim

    X = O2(2,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i))/2;
X(1:(St.Inst.F*length(X))) = -1;
X = mix(X);
O2(5,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end

% outcome for Go in withdrawal trials with negative inst stimulus in PIT.
stim = unique(O2(3,(O2(2,(Tr.Tot2+1):Tr.Tot3) == 2)&(O2(4,(Tr.Tot2+1):Tr.Tot3)<0)));

for i = stim

    X = O2(2,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i))/2*-1;
X(1:((St.Inst.F)*length(X))) = 1;
X = mix(X);
O2(5,(O2(3,(Tr.Tot2+1):Tr.Tot3) == i)) = X;

end



%% O2utcome for NoGo
O2(6,:) = -1.*O2(5,:);





%% Outcome for Pavlovian
A = [];
r = [];
Y = [];
A = 1:(Tr.TotPav/St.Pav.N);
B = 1:(Tr.TotPav/St.Pav.N);
A = A./B;
A(1:((Tr.TotPav/St.Pav.N)*(1-St.Pav.F))) = 0;
A = mix(A);
B = mix(A);
C = mix(A);

O2(7,(O2(4,:) == St.Pav.V(1,1))) = A;
O2(7,(O2(4,:) == St.Pav.V(1,2))) = B;
O2(7,(O2(4,:) == St.Pav.V(1,3))) = C;





%% Side BW 1 = right 2 = left
%for Inst
A = (1:Tr.TotInst)./(1:Tr.TotInst);
A((Tr.TotInst/2+1):Tr.TotInst) = (1:(Tr.TotInst/2))./(1:Tr.TotInst/2).*2;
A = mix(A);
%for PIT
B = (1:Tr.TotPIT)./(1:Tr.TotPIT);
B((Tr.TotPIT/2+1):Tr.TotPIT) = (1:(Tr.TotPIT/2))./(1:Tr.TotPIT/2).*2;
B = mix(B);
% for Pav 0
C = (1:Tr.TotPav).*0;
% fill in the outcomematrix with BW.
O2(8,1:(Tr.Tot3)) = [A C B];
%O2(8,(O2(2,:) == 2)) = 3;





%% Choice trials Pav
A = []; %will become C2 = stimulus to present left
B = []; %will become C3 = stimulus to present right
Co2 = [];
X = [];

for F = 1:floor(Tr.TotPav/Comp);

    X = O2(3,(Tr.TotInst+((F-1)*Comp+1)):(Tr.TotInst+(F*Comp))); % make array to choose stimuli from
    X = mix(X);                       % mix stimuli
    A = [A (X(1,1))];                 % fill left presentation
    
    if X(1,1) ~= X(1,2);          % fill right presentation if stimulus is not the same as left
    
        B = [B (X(1,2))];
    
    else                        %else fill right with following stimulus,
    
        for Y = 1:(Comp*F)
        
            if X(1,1) ~= X(1,Y);     %if that one isn't the same either, or else try following.
            
                B = [B X(1,Y)];
                break
            
            end
            
        end
        
    end
    
end

Co2(1,1:length(A)) = [1:length(A)];
Co2(2:3,:) = [A;B];                  %fill Comparison matrix
Co2(4,1:length(A)) = NaN;





%%
return