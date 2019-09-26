pos(1).
pos(2).
pos(3).
pos(4).
pos(5).
pos(6).
pos(7).
pos(8).

todasPos([]).
todasPos([X | XS]) :- pos(X), todasPos(XS).

unaToDif(_, []).
unaToDif(X, [Y | YS]) :- X =\= Y, unaToDif(X, YS).

diferencia([]).
diferencia([X | XS]) :- unaToDif(X, XS), diferencia(XS).

unachecaDiag1(_, _, _, []).
unachecaDiag1(R1, C1, R2, [C2 | CS]) :-
    R1 + C2 =\= R2 + C1,
    RN is R2 + 1,
    unachecaDiag1(R1, C1, RN, CS).

checaDiag1(_, []).
checaDiag1(R, [C | CS]) :- RN is R + 1, unachecaDiag1(R, C, RN, CS), checaDiag1(RN, CS).

unaChecaDiag2(_, _, _, []).
unaChecaDiag2(R1, C1, R2, [C2 | CS]) :-
    R1 + C1 =\= R2 + C2,
    RN is R2 + 1,
    unaChecaDiag2(R1, C1, RN, CS).

checaDiag2(_, []).
checaDiag2(R, [C | CS]) :- RN is R + 1, unaChecaDiag2(R, C, RN, CS), checaDiag2(RN, CS).

reinas(A, B, C, D, E, F, G, H) :-
    L = [A, B, C, D, E, F, G, H],
    todasPos(L),
    diferencia(L),
    checaDiag1(1, L),
    checaDiag2(1, L).