lista([20,22,31,37,7,9]).

while([],I,I).
while([X|Res],I,F):-Aux is F mod I, Aux =:= 0, X is I, 
                    Aux2 is I+1, while( Res,Aux2,F ).
while(L,I,F):- Aux is I+1, while(L,Aux,F).
divisores(Num,L):- while(L,1,Num).
%Rertorna en forma de Lista todos los Divisores de Num

sumaLista([],0).
sumaLista([X|Res],C):-sumaLista(Res,C1), C is C1+X.
%Dada una Lista, retorna en C la suma numerica de cada Elemento

comparaTipo(Num,SumDiv,X):-Num > SumDiv, X = "a".
comparaTipo(Num,SumDiv,X):-Num = SumDiv, X = "b".
comparaTipo(Num,SumDiv,X):-Num < SumDiv, X = "c".
%Dado un numero y la suma de sus divisores, terna en X el tipo

for(I,I,[]).
for(I,Para,Lista):-
                    divisores(I,Div),
                    sumaLista(Div,sumDiv),
                    comparaTipo(O,sumDiv,Lt),
                    append(Lista,Lt,ListaNueva)
                    I is I +1,
                    for(I,Para,ListaNueva).
clasifica(20,L):-for(1,20,L).