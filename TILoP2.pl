% Hilfsprädikat app (Konkatenation von Listen)
app(nil, Ys, Ys).
app(list(X, Xs), Ys, list(X, Rs)) :- app(Xs, Ys, Rs).

% Hilfsprädikat zur Addition symbolischer Zahlen (falls nicht schon vorhanden)
% add(X, Y, X+Y)
add(o, X, X).
add(s(X), Y, s(R)) :- add(X, Y, R).

% linListe(Xs) : Überprüft, ob es sich bei Xs um eine gültige Liste handelt.
% Induktionsanfang: Die leere Liste ist eine gültige Liste.
linListe(nil).

% Induktionsschluss: Eine Liste ist gültig, wenn ihr Rest (Xs) eine gültige Liste ist.
linListe(list(X, Xs)) :- linListe(Xs).

% mem(X,Ys) : Ys enthält das Element X.
% Fall 1: X ist direkt das erste Element der Liste (Kopf).
mem(X, list(X, Ys)) :- linListe(Ys).
% Fall 2: X befindet sich irgendwo im Rest der Liste (Schwanz).
mem(X, list(Y, Ys)) :- linListe(list(Y, Ys)), mem(X, Ys).

% infix(Xs,Ys) : Ys enthält die Liste Xs (Xs ist eine Teilliste von Ys).
% Logik: Ys besteht aus einem vorderen Teil (H1), der Teilliste Xs und einem hinteren Teil.
infix(Xs, Ys) :- 
    linListe(Xs), 
    linListe(Ys), 
    app(_H1, Rest, Ys), 
    app(Xs, _H2, Rest).

% attach(Xs,X,Ys) : Ys ist Xs verlängert um das Element X.
% Logik: Man hängt eine Liste, die nur aus X besteht ( list(X,nil) ), an Xs an.
attach(Xs, X, Ys) :- 
    linListe(Xs), 
    linListe(Ys), 
    app(Xs, list(X, nil), Ys).


% rev(Xs,Ys) : Ys ist das gespiegelte Xs.
% Induktionsanfang: Eine leere Liste gespiegelt ist wieder leer.
rev(nil, nil).
% Induktionsschluss: Spiegele den Rest der Liste (RevXs) und hänge das erste Element X ganz hinten an.
rev(list(X, Xs), Ys) :- 
    linListe(list(X, Xs)), 
    linListe(Ys), 
    rev(Xs, RevXs), 
    app(RevXs, list(X, nil), Ys).    

% Datentyprelation binbaum(Xb) : Überprüft, ob Xb ein gültiger Binärbaum ist.
binbaum(e).
binbaum(n(R, Lb, Rb)) :- binbaum(Lb), binbaum(Rb).


% construct(Root,Lb,Rb,Xneub) : Xneub ist der Baum mit Root als Wurzel, Lb als linkem und Rb als rechtem Teilbaum.
% Logik: Die Variablen werden einfach in den Struktur-Funktor n(...) eingesetzt. 
% Vorher wird geprüft, ob Lb und Rb gültige Bäume sind.
construct(Root, Lb, Rb, n(Root, Lb, Rb)) :- 
    binbaum(Lb), 
    binbaum(Rb).    

% knotenanz(Xb, N) : N (symbolische Zahl) ist die Anzahl der Knoten des Baumes Xb.

% Induktionsanfang: Ein leerer Baum hat 0 Knoten (o).
knotenanz(e, o).
% Induktionsschluss: Die Anzahl der Knoten eines Baumes n(...) ist 
% 1 (für die Wurzel) + Knoten im linken Teilbaum + Knoten im rechten Teilbaum.
knotenanz(n(R, Lb, Rb), s(N)) :- 
    binbaum(n(R, Lb, Rb)),     
    knotenanz(Lb, N1),         
    knotenanz(Rb, N2),         
    add(N1, N2, N).             