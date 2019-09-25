% Autor:
% Fecha: 19/09/2019

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
%Fucion imprime(Elemento a imprimir).

ponLinea([_|Res],1,Elem,[Elem|Res]).
ponLinea([X|Res],J,Elem,[X|ResN]):-Jn is J-1,ponLinea(Res,Jn,Elem,ResN).
colocaEnXY([X|Res],1,J,Elem,[RN|Res]):-ponLinea(X,J,Elem,RN).
colocaEnXY([X|Res],I,J,Elem,[X|ResN]):-In is I-1,colocaEnXY(Res,In,J,Elem,ResN).
%funcion ColocaEnXY(Matriz,Coordenada_X, Coordenada_Y,Elemento, MatrizNueva).

buscaY([Elem|_],Elem,1).
buscaY([_|R],Elem,Y):-buscaY(R,Elem,Yn),Y is Yn+1.
buscarElemento([R|_],Elem,[1,Y]):-member(Elem,R),buscaY(R,Elem,Y).
buscarElemento([_|Res],Elem,[X,Y]):-buscarElemento(Res,Elem,[Xn,Y]),X is Xn+1.
%Funcion Buscarelemento(Matriz,Elemento,ListaCoordendas[X,Y])

traeri([R|_],1,R).
traeri([_|Resto],I,R):-Ni is I-1,traeri(Resto,Ni,R).
%Funcion traeri(Lista,posicionLista,ElementoLista).
traeElementoCoordenada(L,I,J,Elm):-traeri(L,I,R),traeri(R,J,Elm).
%Funcion TraeElementoCoordenada(Matriz,Coor_X,Coor_Y,Elemento).

traeColumna([],_,[]).
traeColumna([R|Resto],Col,[Elem|Restop]):-traeri(R,Col,Elem),
                                   traeColumna(Resto,Col,Restop).
%Funcion traeColumna(Matriz,NumeroColumna,ListaCumnaGuardada).

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
