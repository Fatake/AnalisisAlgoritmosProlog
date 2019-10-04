% Autor: Paulo Lozano
% Fecha: 09/09/2019

ultimoAppend(L,Ult):- append(_,[Ult],L).
penultimoAppend(L,Ult):- append(_,[Ult,_],L).
%
ultimoReverse(L,Ult):- reverse(L,[Ult|_]).
penultimoReverse(L,Ult):- reverssse(L,[_,Ult|_]).
%
ultimo(X,[X]).
ultimo(X,[_|Resto]):- ultimo(X,Resto).
%
pultimo(X,[X,_]).
pultimo(X,[_|Resto]):- pultimo(X,Resto).