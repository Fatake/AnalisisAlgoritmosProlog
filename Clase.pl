% [[1,2,3],[4,5,6]]
aplicaO([],_,[]).
aplicaO([[X1,Y1]|Res],[X,Y],[[Z,W]|Resto]):-Z is X1+X,W is Y1+Y,
   aplicaO(Res,[X,Y],Resto).
validaM([],[]).
validaM([M|Res],[M|Resto]):-ok(M),validaM(Res,Resto).
validaM([_|Res],Resto):-validaM(Res,Resto).
ok([X,Y]):-X>0,X<5,Y>0,Y<5.
buscaE([R|_],Elem,[1,Y]):-member(Elem,R),buscaY(R,Elem,Y).
buscaE([_|Res],Elem,[X,Y]):-buscaE(Res,Elem,[Xn,Y]),X is Xn+1.
buscaY([Elem|_],Elem,1).
buscaY([_|R],Elem,Y):-buscaY(R,Elem,Yn),Y is Yn+1.
traeri([R|_],1,R).
traeri([_|Resto],I,R):-Ni is I-1,traeri(Resto,Ni,R).
traeij(L,I,J,Elm):-traeri(L,I,R),traeri(R,J,Elm).
traeColum([],_,[]).
traeColum([R|Resto],Col,[Elem|Restop]):-traeri(R,Col,Elem),
         traeColum(Resto,Col,Restop).
diag(L,Diagonal):-auxiliar(L,Diagonal,1).
auxiliar([],[],_).
auxiliar([R|Rl],[Elem|Resto],Cont):-traeri(R,Cont,Elem),
          Ncont is Cont+1,auxiliar(Rl,Resto,Ncont).

ponLinea([_|Res],1,Elem,[Elem|Res]).
ponLinea([X|Res],J,Elem,[X|ResN]):-Jn is J-1,ponLinea(Res,Jn,Elem,ResN).
pon([X|Res],1,J,Elem,[RN|Res]):-ponLinea(X,J,Elem,RN).
pon([X|Res],I,J,Elem,[X|ResN]):-In is I-1,pon(Res,In,J,Elem,ResN).


%lin(Ele,[],[]).
%lin(Ele,[Car|Cdr],[[Ele,Car]|Resto]) :-lin(Ele,Cdr,Resto).

%l1xl2([],L2,[]).
l1xl2([Car|Cdr],L2,Resultado) :-
    lin(Car,L2,Linea),l1xl2(Cdr,L2,Resto),append(Linea,Resto,Resultado).
