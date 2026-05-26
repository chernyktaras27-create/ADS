% ======================================================================
% Praktikum 3 zu TILO
% ======================================================================
app( [ ], Ys, Ys ).
app( [X | Xs], Ys, [X | Rs] ) :- app( Xs, Ys, Rs ).

präfix( Xs, Ys ) :- app( Xs, Hs, Ys )
% ======================================================================
% Aufgabe 1: (Listenstruktur und -operationen)
% Implementieren Sie das Prädikat postfix(Xs,Ys) zweimal jeweils in einer Zeile.
% ======================================================================

% 1. Variante: ohne append, mit präfix aus Übung 20b und reverse des Prolog-Systems.
postfix(Xs, Ys) :- reverse(Xs, RevXs), reverse(Ys, RevYs), präfix(RevXs, RevYs).

% 2. Variante: unter Verwendung von append.
postfix(Xs, Ys) :- append(_, Xs, Ys).


% ======================================================================
% Aufgabe 2: (Binärbaumstruktur und -operationen)
% membertree(X, Xb) : Baum Xb enthält den Eintrag X.
% Verwenden Sie die Datentyprelation binbaum zur Überprüfung.
% ======================================================================

% Fall 1: Das gesuchte Element X befindet sich genau in der Wurzel.
membertree(X, n(X, Lb, Rb)) :- binbaum(n(X, Lb, Rb)).

% Fall 2: Das Element X befindet sich irgendwo im linken Teilbaum.
membertree(X, n(R, Lb, Rb)) :- binbaum(n(R, Lb, Rb)), membertree(X, Lb).

% Fall 3: Das Element X befindet sich irgendwo im rechten Teilbaum.
membertree(X, n(R, Lb, Rb)) :- binbaum(n(R, Lb, Rb)), membertree(X, Rb).


% ======================================================================
% Aufgabe 3: (Binärbäume und Listen)
% Implementieren Sie Relationen für Binärbäume.
% ======================================================================

% präorder(Xb, Ys) : Ys ist die Liste der Knotenbeschriftungen in Präorder.
% (Wurzel -> linker Teilbaum -> rechter Teilbaum)
präorder(e, []).
präorder(n(R, Lb, Rb), Ys) :- 
    binbaum(n(R, Lb, Rb)), 
    präorder(Lb, LLs), 
    präorder(Rb, LRs), 
    append([R | LLs], LRs, Ys).

% postorder(Xb, Ys) : Ys ist die Liste der Knotenbeschriftungen in Postorder.
% (linker Teilbaum -> rechter Teilbaum -> Wurzel)
postorder(e, []).
postorder(n(R, Lb, Rb), Ys) :- 
    binbaum(n(R, Lb, Rb)), 
    postorder(Lb, LLs), 
    postorder(Rb, LRs), 
    append(LLs, LRs, TempList), 
    append(TempList, [R], Ys).

% roots(Xbs, Ys) : Xbs ist eine Liste von Binärbäumen. Ys ist die Liste der
% Wurzelbeschriftungen. Ein leerer Baum e hat keine Wurzelbeschriftung.
% Fall 1: Die leere Liste von Bäumen liefert eine leere Liste von Wurzeln.
roots([], []).

% Fall 2: Das erste Element der Liste ist ein gültiger Knoten n(...).
% Extrahieren der Wurzel R und rekursiver Aufruf für die restlichen Bäume.
roots([n(R, Lb, Rb) | RestBäume], [R | RestRoots]) :- 
    binbaum(n(R, Lb, Rb)), 
    roots(RestBäume, RestRoots).

% Fall 3: Das erste Element der Liste ist ein leerer Baum e.
% Dieser wird ignoriert (nichts wird zu Ys hinzugefügt), rekursiver Aufruf für den Rest.
roots([e | RestBäume], RestRoots) :- 
    roots(RestBäume, RestRoots).          