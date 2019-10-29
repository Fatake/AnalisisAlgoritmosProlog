% Autor:
% Fecha: 29/08/2019

dividir([],[]).
dividir([L|R],[L|N]):- T is L mod 2,T==0,dividir(R,N).
dividir([L|R],N):-T is L mod 2,T\==0, dividir(R,N).
impar([],[]).
impar([L|R],N):- T is L mod 2,T==0,impar(R,N).
impar([L|R],[L|N]):-T is L mod 2,T\==0, impar(R,N).
sumaM([],_,[]).
sumaM([R11|R1],[R12|R2],[R13|R3]):-sumaV(R11,R12,R13),sumaM(R1,R2,R3).
sumaV([],_,[]).
sumaV([E1|R1],[E2|R2],[E3|R3]):-E3 is E1+E2,sumaV(R1,R2,R3).

paso1(_,_,C,N,[]):-C>N.
paso1(R,M,C,N,[Elem|Resto]):-colum(M,C,Columna),productoV(R,Columna,Elem),
        Nc is C+1,paso1(R,M,Nc,N,Resto).

colum([],_,[]).
colum([R|Resto],C,[Elemc|Res]):-iesimo(R,C,Elemc),colum(Resto,C,Res).

iesimo([E|_],1,E).
iesimo([_|Res],Pos,Elem):-Npos is Pos-1,iesimo(Res,Npos,Elem).

productoV(V1,V2,Spv):-prodV(V1,V2,P),suma(P,Spv).
prodV([],[],[]).
prodV([E1|R1],[E2|R2],[E3|R3]):-E3 is E1*E2,prodV(R1,R2,R3).
suma([],0).
suma([E|R],T):-suma(R,Tp),T is E+Tp.
pert(X,[X|_]).
pert(X,[_|L]):-pert(X,L).
ultimo(L,U):-append(_,[U|[]],L).
penultimo(L,P):-append(_,[P,_],L).
ultima(L,U):-reverse(L,[U|_]).
penultima(L,U):-reverse(L,[_,U|_]).
ult([X],X).
ult([_|R],U):-ult(R,U).
pult([X,_],X).
pult([_|R],P):-pult(R,P).
inserta(X,L1,L2):-select(X,L2,L1).
longPar([]).
longPar([_,_|R]):-longPar(R).
longImPar([_]).
longImPar([_,_|R]):-longImPar(R).
% L = [1,2,3,4,5,6,7,8,9,10]   L1 = [2,3,4]   L2 = [2,4,6,8,10]
l1yl2([],_,[]).
l1yl2([X|L1],L2,[X|L3]):-member(X,L2),l1yl2(L1,L2,L3).
l1yl2([_|L1],L2,L3):-l1yl2(L1,L2,L3).
l1dl2([],_,[]).
l1dl2([X|L1],L2,L3):-member(X,L2),l1dl2(L1,L2,L3).
l1dl2([X|L1],L2,[X|L3]):-l1dl2(L1,L2,L3).

l1ul2([],L2,L2).
l1ul2([X|L1],L2,L3):-member(X,L2),l1ul2(L1,L2,L3).
l1ul2([X|L1],L2,[X|L3]):-l1ul2(L1,L2,L3).

l1Difl2(L1,L2,L3):-l1ul2(L1,L2,L4),l1yl2(L1,L2,L5),l1dl2(L4,L5,L3).
l1C(L1,L,Lc):-l1dl2(L,L1,Lc).

iter([],_,[]).
iter([X|Resto],Elemento,[[X,Elemento]|Lista]):- iter(Resto,Elemento,Lista).
junta([],L2,L2).
junta([X|L1],L2,[X|L3]):-junta(L1,L2,L3).
productoCruz([],_,_).
productoCruz([EL1|L1R],L2,L3):- iter(L2,EL1,L4),productoCruz(L1R,L2,L5),junta(L4,L5,L3).
