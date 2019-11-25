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

%playColumn(X,C,C2) is satisfied if column C2 is column C after player X plays there
playColumn(X,['-'],[X]):- !. % last spot in column
playColumn(X,['-',A|AS],[X,A|AS]):- A \== ('-'), !. % jugar por encima de la pieza de alguien
playColumn(X,['-'|AS],['-'|AS2]):- playColumn(X,AS,AS2). % descend column

%<-------------------------------------------Ganar------------------------------------------------------------>%

% comprobar si hay una columna en T con 4 piezas conectadas de jugador X
wins(X,board(T)):- append(_, [C|_], T), % Checa si hay una columna
                   append(_,[X,X,X,X|_],C). % ...which has 4 connected pieces of player X

% comprobar si hay una fila en T con 4 piezas conectadas de jugador X
wins(X,board(T)):- append(_,[C1,C2,C3,C4|_],T), % check if 4 connected columns exists in board...
                   append(I1,[X|_],C1), %...such that all of them contain a piece of player X...
                   append(I2,[X|_],C2),
                   append(I3,[X|_],C3),
                   append(I4,[X|_],C4),
                   length(I1,M), length(I2,M), length(I3,M), length(I4,M). %...and every piece is in the same height

% comprueba si hay una diagonal (tipo \) en T con 4 piezas conectadas de jugador X
wins(X,board(T)):- append(_,[C1,C2,C3,C4|_],T), % check if 4 connected columns exists in board...
                   append(I1,[X|_],C1), %...such that all of them contain a piece of player X...
                   append(I2,[X|_],C2),
                   append(I3,[X|_],C3),
                   append(I4,[X|_],C4),
                   length(I1,M1), length(I2,M2), length(I3,M3), length(I4,M4),
                   M2 is M1+1, M3 is M2+1, M4 is M3+1. %...and every piece is within the same diagonal \
%check if there's a diagonal (type /) in T with 4 connected pieces of player X
wins(X,board(T)):- append(_,[C1,C2,C3,C4|_],T), % check if 4 connected columns exists in board...
                   append(I1,[X|_],C1), %...such that all of them contain a piece of player X...
                   append(I2,[X|_],C2),
                   append(I3,[X|_],C3),
                   append(I4,[X|_],C4),
                   length(I1,M1), length(I2,M2), length(I3,M3), length(I4,M4),
                   M2 is M1-1, M3 is M2-1, M4 is M3-1. %...and every piece is within the same diagonal /
                                                
%full(T) is satisfied if there isn't any free spot ('-')
full(board(T)):- \+ (append(_,[C|_],T),
                 append(_,['-'|_],C)).

%<-------------------------------------------------------Registra el tiro-------------------------------------->%
%leeColumna
readColumn(C):- nl, write('Tiro(ColFil): '),
                repeat,
                get_char(L),
                associateColumn(L,C),
                col(C), !.

%associateColumn(L,C) column C is the column associated with char L
associateColumn(L,C):- atom_codes(L,[La|_]),
                       C is La - 65.

%associateChar(L, C) char L is the char associated with column C
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
%machine(R,O,T,T2) Let R be the machine piece, O the opponent's piece and T the board game. Then T2 is board T after the machine movement
% win if possible
machine(R,_,T,T2):- iMachine(R,T,C,T2),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L),
                    nl,!.
% otherwise, if machine can't win within a move, play a move that doesn't allow opponent O to win and that would allow us to obtain a connected 4
machine(R,O,T,T2):- findall((Col,TA), (col(Col), play(R,Col,T,TA),\+ iMachine(O,TA,_,_), goodMove(R,Col,T)), [(C,T2)|_]),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L),
                    nl,!.
% otherwise play a move that doesn't allow opponent O to win
machine(R,O,T,T2):- findall((Col,TA), (col(Col), play(R,Col,T,TA),\+ iMachine(O,TA,_,_)), [(C,T2)|_]),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L), nl,
                    write('-'),!.
% otherwise play a move intercepting one of the future winning options of opponent O
machine(R,O,T,T2):- iMachine(O,T,C,_),
                    play(R,C,T,T2),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L), nl.
% otherwise play wherever
machine(R,_,T,T2):- col(C),
                    play(R,C,T,T2),
                    nl, write('computadora: '),
                    associateChar(L,C),
                    write(L), nl.
                                  
%iMachine(R,T,C,T2) is satisfied if player R can play in column C of board T and obtain a winning board T2
iMachine(R,T,C,T2):- findall((Col,TA), (col(Col), play(R,Col,T,TA),wins(R,TA)),[(C,T2)|_]).

%We consider that a good move is one allowing us to win in a column. Further improvements: rows and diagonals.
goodMove(R,Col,board(T)):- append(I,[C|_],T),
                           length(I,Col),
                           maxConnected(R,C,MaxConn),
                           MaxConn >= 4.                                                

% maxConnected(R,C,MaxConn) MaxConn is the maximum number of connected pieces that player R has/could have in column C
maxConnected(_,[],0).
maxConnected(R,[X|_],0):- X\=R.
maxConnected(R,['-'|X],N):- maxConnected(R,X,Ns),
                            N is Ns+1.
maxConnected(R,[R|X],N):- maxConnected(R,X,Ns),
                          N is Ns+1.
