% Autor:
% Fecha: 29/08/2019
% [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,0,15]]
% [[1,0],[0,1],[-1,0],[0,-1]]
nth([H|_],1,H).
nth([_|Resto],N,Elem):-NewN is N-1,nth(Resto,NewN,Elem).
traeXY([H|_],1,Y,Elem):-nth(H,Y,Elem).
traeXY([_|R],X,Y,Elem):-Xn is X-1,traeXY(R,Xn,Y,Elem).
coordXY([R|_],Elem,[1,Y]):-member(Elem,R),traeY(R,Elem,Y).
coordXY([_|Resto],Elem,[X,Y]):-coordXY(Resto,Elem,[Xn,Y]),X is Xn+1.
traeY([E|_],E,1).
traeY([_|Resto],Elem,Y):-traeY(Resto,Elem,Yn),Y is Yn+1.
aplicaO([],_,[]).
aplicaO([[X1,Y1]|Resto],[X,Y],[[Z,W]|Res]):-Z is X1+X,W is Y1+Y,
    aplicaO(Resto,[X,Y],Res).
validaM([],[]).
validaM([[X,Y]|Rm],[[X,Y]|Resto]):-ok(X,Y),validaM(Rm,Resto).
validaM([_|Rm],Resto):-validaM(Rm,Resto).
ok(X,Y):-0<X,X<5,0<Y,Y<5.