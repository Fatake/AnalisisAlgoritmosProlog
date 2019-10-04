% Autor: Paulo Cesar Ruiz Lozano
% Fecha: 18/09/2019
tablero([[0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0]]).

listaReynas([[1,4],[2,2],[8,3]]).

imprime([]).
imprime([P|Resto]):-writeln(P),imprime(Resto).

ponLinea([_|Res],1,Elem,[Elem|Res]).
ponLinea([X|Res],J,Elem,[X|ResN]):-Jn is J-1,ponLinea(Res,Jn,Elem,ResN).
colocaEnXY([X|Res],1,J,Elem,[RN|Res]):-ponLinea(X,J,Elem,RN).
colocaEnXY([X|Res],I,J,Elem,[X|ResN]):-In is I-1,colocaEnXY(Res,In,J,Elem,ResN).

buscaY([Elem|_],Elem,1).
buscaY([_|R],Elem,Y):-buscaY(R,Elem,Yn),Y is Yn+1.
buscarElemento([R|_],Elem,[1,Y]):-member(Elem,R),buscaY(R,Elem,Y).
buscarElemento([_|Res],Elem,[X,Y]):-buscarElemento(Res,Elem,[Xn,Y]),X is Xn+1.

traeri([R|_],1,R).
traeri([_|Resto],I,R):-Ni is I-1,traeri(Resto,Ni,R).
traeElementoCoordenada(L,I,J,Elm):-traeri(L,I,R),traeri(R,J,Elm).

traeColumna([],_,[]).
traeColumna([R|Resto],Col,[Elem|Restop]):-traeri(R,Col,Elem),
                                   traeColumna(Resto,Col,Restop).

pon1(_,[_,9],[]).
pon1(_,[9,_],[]).
pon1(Matriz,X,Y,Mn):-colocaEnXY(Matriz,X,Y,1,Mne),
                       Xn is X + 1, Yn is Y+1,
                       Mn is Mne,
                       pon1(Matriz,Xn,Yn,Mn).
diagonalInferiorDerechaUnos(Matriz,Xreina,Yreina,MatrizNueva):-X is Xreina+1,
                            Y is Yreina, pon1(Matriz,X,Y,MatrizNueva).


aux(_,[_,1],_).
aux(Matriz,[X,Y],MatrizNueva):-colocaEnXY(Matriz,X,Y,1,Mn),
                               MatrizNueva is Mn,
                               Yn is Y+1,
                               aux(Matriz,[X,Yn],MatrizNueva).
pon1Columna(Matriz,[X,_],MatrizNueva):-aux(Matriz,[X,1],Mn), MatrizNueva is Mn.

posicion(0, []).
posicion(X, [X | YS]) :- X >= 0, Y is X - 1, posicion(Y, YS).


len([], 0).
len([_ | XS], Y) :- len(XS, L), Y is L + 1.

noChocaUna(_, _, _, []).
noChocaUna(R1, C1, R2, [C2 | CS]) :-
    R2 - R1 =\= C2 - C1,
    R2 - R1 =\= C1 - C2,
    RN is R2 + 1, noChocaUna(R1, C1, RN, CS).

noChocan([], _).
noChocan([C | XS], R) :- 
    RN is R + 1,
    noChocaUna(R, C, RN, XS), 
    noChocan(XS, RN).

noChocan(L) :- noChocan(L, 1).

reinasJuego(L,Lsol) :- 
    len(L, Len),
    listaReynas(Lr),
    posicion(Len, Lr),
    noChocan(Lr,Lsol),
    
    