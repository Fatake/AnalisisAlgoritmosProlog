use_module(library(random)).
fichas([[0,0],[0,1],[0,2],[0,3],[0,4],[0,5],[0,6]
       ,[1,1],[1,2],[1,3],[1,4],[1,5],[1,6]
       ,[2,2],[2,3],[2,4],[2,5],[2,6]
       ,[3,3],[3,4],[3,5],[3,6]
       ,[4,4],[4,5],[4,6]
       ,[5,5],[5,6]
       ,[6,6]]).
%reparte(L,CantidaJugadores,ListaRepartida,Sobran).
imprime([]).
imprime([P|Resto]):-write(P),write(" "),imprime(Resto).

tamanio([],0).
tamanio([_|Res],Tam):-tamanio(Res,Tn),Tam is Tn + 1.

numxjuga(Tam,NumJuga,Fixjuga,FiRes):-
        Fixjuga is div(Tam, NumJuga),
        FiRes is mod(Tam, NumJuga).
        
generaFicha([X,Y]):-random(0,7,R),X is R,random(0,7,C), Y is C.

elimina(_,[],[]).
elimina([X,Y],[[X,Y]|Res],Res).
elimina([X,Y],[[X2,Y2]|Res],[[X2,Y2]|ResN]):-elimina([X,Y],Res,ResN).

liFiJu(Fichas,FichasJuga,Fn):-generaFicha(Ficha),
      elimina(Ficha,Fichas,FiN)
     ,append(Ficha,FichasJuga,ListaN), Fn is FiN,
     FichasJuga is ListaN.









