% FAKTEN: Eltern-Kind-Beziehungen

% elternteil(X,Y) bedeutet: X ist ein Elternteil von Y

% Vyacheslav ist Vater von Maria, Lyuba und Oksana
elternteil(vyacheslav, maria).
elternteil(vyacheslav, lyuba).
elternteil(vyacheslav, oksana).

% Maria ist Mutter von Taras und Nazar
elternteil(maria, taras).
elternteil(maria, nazar).

% Oksana ist Mutter von Nastya und Artem
elternteil(oksana, nastya).
elternteil(oksana, artem).

% Lyuba ist Mutter von Diana
elternteil(lyuba, diana).

% Halyna ist Mutter von Ivan und Vasyl
elternteil(halyna, ivan).
elternteil(halyna, vasyl).

% Ivan ist Vater von Taras und Nazar
elternteil(ivan, taras).
elternteil(ivan, nazar).

% Vasyl ist Vater von Dima
elternteil(vasyl, dima).



% FAKTEN: Geschlecht der Personen

% geschlecht(X,Y) bedeutet: X hat das Geschlecht Y

% männliche Personen
geschlecht(vyacheslav, maennlich).
geschlecht(taras, maennlich).
geschlecht(nazar, maennlich).
geschlecht(artem, maennlich).
geschlecht(ivan, maennlich).
geschlecht(vasyl, maennlich).
geschlecht(dima, maennlich).

% weibliche Personen
geschlecht(maria, weiblich).
geschlecht(lyuba, weiblich).
geschlecht(oksana, weiblich).
geschlecht(nastya, weiblich).
geschlecht(diana, weiblich).
geschlecht(halyna, weiblich).



% REGELN: Grundlegende Beziehungen


% vater(V,K) bedeutet: V ist der Vater von K
vater(V,K) :-
    elternteil(V,K),
    geschlecht(V, maennlich).

% mutter(M,K) bedeutet: M ist die Mutter von K
mutter(M,K) :-
    elternteil(M,K),
    geschlecht(M, weiblich).

% sohn(S,E) bedeutet: S ist der Sohn von E
sohn(S,E) :-
    elternteil(E,S),
    geschlecht(S, maennlich).

% tochter(T,E) bedeutet: T ist die Tochter von E
tochter(T,E) :-
    elternteil(E,T),
    geschlecht(T, weiblich).



% REGELN: Geschwister


% bruder(B,G) bedeutet: B ist der Bruder von G
bruder(B,G) :-
    elternteil(F,B),
    elternteil(F,G),
    geschlecht(F, maennlich),
    elternteil(M,B),
    elternteil(M,G),
    geschlecht(M, weiblich),
    geschlecht(B, maennlich),
    B \= G.

% schwester(S,G) bedeutet: S ist die Schwester von G
schwester(S,G) :-
    elternteil(F,S),
    elternteil(F,G),
    geschlecht(F, maennlich),
    elternteil(M,S),
    elternteil(M,G),
    geschlecht(M, weiblich),
    geschlecht(S, weiblich),
    S \= G.



% REGELN: Großeltern


% grossvater(GV,E) bedeutet: GV ist der Großvater von E
grossvater(GV,E) :-
    elternteil(GV,X),
    elternteil(X,E),
    geschlecht(GV, maennlich).

% grossmutter(GM,E) bedeutet: GM ist die Großmutter von E
grossmutter(GM,E) :-
    elternteil(GM,X),
    elternteil(X,E),
    geschlecht(GM, weiblich).



% REGELN: Onkel und Tante


% onkel(O,N) bedeutet: O ist der Onkel von N
onkel(O,N) :-
    bruder(O,P),
    elternteil(P,N).

% tante(T,N) bedeutet: T ist die Tante von N
tante(T,N) :-
    schwester(T,P),
    elternteil(P,N).



% REGELN: Cousins und Cousinen


% cousin(C,X) bedeutet: C ist ein Cousin von X
cousin(C,X) :-
    elternteil(P1,C),
    elternteil(P2,X),
    bruder(P1,P2),
    geschlecht(C, maennlich),
    C \= X.

cousin(C,X) :-
    elternteil(P1,C),
    elternteil(P2,X),
    schwester(P1,P2),
    geschlecht(C, maennlich),
    C \= X.


% cousine(C,X) bedeutet: C ist eine Cousine von X
cousine(C,X) :-
    elternteil(P1,C),
    elternteil(P2,X),
    bruder(P1,P2),
    geschlecht(C, weiblich),
    C \= X.

cousine(C,X) :-
    elternteil(P1,C),
    elternteil(P2,X),
    schwester(P1,P2),
    geschlecht(C, weiblich),
    C \= X.