%Tablero inicial de [columnas=7, filas=6]
tableroInicial(board([['-','-','-','-','-','-'],%1
                      ['-','-','-','-','-','-'],%2
                      ['-','-','-','-','-','-'],%3
                      ['-','-','-','-','-','-'],%4
                      ['-','-','-','-','-','-'],%5
                      ['-','-','-','-','-','-'],%6
                      ['-','-','-','-','-','-']])).%7

%<--------------------------------------------- Imprime Tablero ----------------------------------------------->%

% muestra(Tablero) Muestra el tablero
muestra(board(X)):- write('  A B C D E F G'), nl, imuestra(X,6).

% imuestra(X,N) muestras lineas de [N .. 1] en el tablero X
imuestra(_,0).
imuestra(X,N):- muestraLinea(X,N,X2),
                Ns is N-1,
                imuestra(X2,Ns).

% muestraLinea(X,N,X2) escribe N y muestra la primera línea del tablero X (primer elemento de cada columna)
muestraLinea(X,N,X2):- write(N), write(' '),
                   imuestraLinea(X,X2), nl.

%imuestraLinea(X,X2) Escribe el primer elemento de cada columna
imuestraLinea([],_).
imuestraLinea([[X|X2]|XS],[X2|XS2]):- write(X), write(' '),
                                  imuestraLinea(XS,XS2).

%<----------------------------------------------Iniciar Juego-------------------------------------------------->%
%
%   Inicializa El Juego
%
iniciaJuegoC4:- tableroInicial(X),
                muestra(X),
                sigTiro('X',X), !.

%sigTiro(J,X) J es el jugador que necesita tirar ('O' o 'X') y X es el tablero
%Checa si el juego termino, si no, lanza el siguiente tiro

sigTiro('X',X):- wins('O',X), write('Perdiste u.u').
sigTiro('O',X):- wins('X',X), write('Ganaste n.n').
sigTiro(_,X)  :- full(X),     write('Empate -.-').

sigTiro('X',X):- repeat, %repite en caso de que la columna sea NULL
                  readColumn(C),
                  play('X',C,X,X2), !,
                  muestra(X2),
                  sigTiro('O',X2).

sigTiro('O',X):- machine('O','X',X,X2),
                  muestra(X2),
                  sigTiro('X',X2).

%play(X,P,T,T2) si T2 el el tablero T antes de jugar X mueve en la columna P
play(X,P,board(T),board(T2)):- append(I,[C|F],T),
                               length(I,P), 
                               playColumn(X,C,C2),
                               append(I,[C2|F],T2).

%playColumn(X,C,C2) lacolumna C2 es la columna C después de que el jugador X juega allí
playColumn(X,['-'],[X]):- !. % ultimo jugar, entonce sale
playColumn(X,['-',A|AS],[X,A|AS]):- A \== ('-'), !. % jugar por encima de la pieza de alguien
playColumn(X,['-'|AS],['-'|AS2]):- playColumn(X,AS,AS2). % Descendente

%<-------------------------------------------Ganar------------------------------------------------------------>%

% comprobar si hay una columna en T con 4 piezas conectadas de jugador X
wins(X,board(T)):- append(_, [C|_], T), % Checa si hay una columna
                   append(_,[X,X,X,X|_],C). % ...which has 4 connected pieces of player X

% comprobar si hay una fila en T con 4 piezas conectadas de jugador X
wins(X,board(T)):- append(_,[C1,C2,C3,C4|_],T), % compruebe si existen 4 columnas conectadas en el tablero con fichas
                   append(I1,[X|_],C1),
                   append(I2,[X|_],C2),
                   append(I3,[X|_],C3),
                   append(I4,[X|_],C4),
                   length(I1,M), length(I2,M), length(I3,M), length(I4,M). %Cada ficha esté en la misma altura

% comprueba si hay una diagonal (tipo \) en T con 4 piezas conectadas de jugador X
wins(X,board(T)):- append(_,[C1,C2,C3,C4|_],T),
                   append(I1,[X|_],C1),
                   append(I2,[X|_],C2),
                   append(I3,[X|_],C3),
                   append(I4,[X|_],C4),
                   length(I1,M1), length(I2,M2), length(I3,M3), length(I4,M4),
                   M2 is M1+1, M3 is M2+1, M4 is M3+1. %
%comprueba si hay una diagonal (tipo /¿diagonal) en T con 4 piezas conectadas de jugador X
wins(X,board(T)):- append(_,[C1,C2,C3,C4|_],T),
                   append(I1,[X|_],C1),
                   append(I2,[X|_],C2),
                   append(I3,[X|_],C3),
                   append(I4,[X|_],C4),
                   length(I1,M1), length(I2,M2), length(I3,M3), length(I4,M4),
                   M2 is M1-1, M3 is M2-1, M4 is M3-1.
                                                
%full()comprueba si no hay ningún espacio libre ('-')
full(board(T)):- \+ (append(_,[C|_],T),
                 append(_,['-'|_],C)).

%<-------------------------------------------------------Registra el tiro-------------------------------------->%
%leeColumna
readColumn(C):- nl, write('Tiro(ColFil): '),
                repeat,
                get_char(L),
                associateColumn(L,C),
                col(C), !.

%associateColumn() la columna C es la columna asociada con char L
associateColumn(L,C):- atom_codes(L,[La|_]), %funcon atom_code, asocia un string con algo atomico en este caso la lista de columnas
                       C is La - 65.

associateChar(L, C):- Ln is 65+C,
                      atom_codes(L,[Ln]).

%columnas validas
col(0).
col(1).
col(2).
col(3).
col(4).
col(5).
col(6).

%<--------------------------------------------Computadora------------------------------------------------------>%
% máquina (R, O, T, T2): Sea R la pieza de la máquina, O la pieza del oponente y T el juego de mesa.
% Donde T2 es el tablero T después del movimiento de la máquina (busca mejor tiro para ganar)
machine(R,_,T,T2):- iMachine(R,T,C,T2),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L),
                    nl,!.
% Si la máquina no puede ganar dentro de un movimiento
% esta juegará un movimiento que no permita que el oponente gane y que nos permita obtener un 4 conectado
machine(R,O,T,T2):- findall((Col,TA), (col(Col), play(R,Col,T,TA),\+ iMachine(O,TA,_,_), goodMove(R,Col,T)), [(C,T2)|_]), %Encuentra todos
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L),
                    nl,!.
% Juega un movimiento que no permita qu eel oponente gane
machine(R,O,T,T2):- findall((Col,TA), (col(Col), play(R,Col,T,TA),\+ iMachine(O,TA,_,_)), [(C,T2)|_]),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L), nl,
                    write('-'),!.
% Juega un movimiento que evita que el oponente gane
machine(R,O,T,T2):- iMachine(O,T,C,_),
                    play(R,C,T,T2),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L), nl.
% Si no hay riesgo de perder, juega donde sea
machine(R,_,T,T2):- col(C),
                    play(R,C,T,T2),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L), nl.
                                  
%iMachine(R,T,C,T2) si el jugador R puede jugar en la columna C del tablero T y obtener un tablero ganador T2
iMachine(R,T,C,T2):- findall((Col,TA), (col(Col), play(R,Col,T,TA),wins(R,TA)),[(C,T2)|_]). %Busca por las ramas un juego o si hay victoria

%Se considera que una buena jugada es aquella que nos permite ganar en una columna, fila o diagonal.
goodMove(R,Col,board(T)):- append(I,[C|_],T),
                           length(I,Col),
                           maxConnected(R,C,MaxConn),
                           MaxConn >= 4.                                                

% maxConnected(R,C,MaxConn) MaxConn es el número máximo de piezas conectadas que el jugador R tiene o podría tener en la columna C
maxConnected(_,[],0).
maxConnected(R,[X|_],0):- X\=R.
maxConnected(R,['-'|X],N):- maxConnected(R,X,Ns),
                            N is Ns+1.
maxConnected(R,[R|X],N):- maxConnected(R,X,Ns),
                          N is Ns+1.
