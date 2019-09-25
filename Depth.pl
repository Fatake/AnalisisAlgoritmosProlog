% Autor:
% Fecha: 17/09/2019
% [[1,2,3,4],[5,6,7,8],[3,1,0,11,12],[13,10,14,15]]
vert([[_,Y]|Res],[_,Y]).
vert([_|Res],Pos):-vert(Res,Pos).
for(_,[_,9],[]).
for(Reynas,[_,Y],[1|Resto]):-vert(Reynas,[_,Y]),Yn is Y+1,
                             for(Reynas,[_,Yn],Resto).
for(Reynas,[_,Y],[0|Resto]):-Yn is Y+1,for(Reynas,[_,Yn],Resto),


imprime([P|Resto]):-writeln(P),imprime(Resto).
goal([],_).
goal([R1|Res1],[R2|Res2]):-igual(R1,R2),goal(Res1,Res2).
igual([],_).
igual([E1|Res1],[E1|Res2]):-igual(Res1,Res2).
sucs(_,[],_,[]).
sucs(Puzz,[[Mx,My]|Resm],[X0,Y0],[Sol|Resto]):-traeij(Puzz,Mx,My,Elem),
                           ponE(Puzz,X0,Y0,Elem,Sucs),
                           ponE(Sucs,Mx,My,0,Sol),
                           sucs(Puzz,Resm,[X0,Y0],Resto).
traeri([R|_],1,R).
traeri([_|Resto],I,R):-Ni is I-1,traeri(Resto,Ni,R).
traeij(L,I,J,Elm):-traeri(L,I,R),traeri(R,J,Elm).
ponE([R|Res],1,Y,Elem,[Nr|Res]):-ponY(R,Y,Elem,Nr).
ponE([R|Res],X,Y,Elem,[R|Resto]):-Nx is X-1,ponE(Res,Nx,Y,Elem,Resto).
ponY([_|Res],1,Elem,[Elem|Res]).
ponY([P|Res],Y,Elem,[P|Resto]):-Ny is Y -1,ponY(Res,Ny,Elem,Resto).
apliO([],_,[]).
apliO([[X1,Y1]|Res],[X,Y],[[W,Z]|Resto]):-W is X1+X,Z is Y1+Y,
    apliO(Res,[X,Y],Resto).
validaM([],[]).
validaM([M|Res],[M|Resto]):-ok(M),validaM(Res,Resto).
validaM([_|Res],Resto):-validaM(Res,Resto).
ok([X,Y]):-X>0,X<5,Y>0,Y<5.