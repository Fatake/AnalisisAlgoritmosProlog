:-consult('Graphix.pl').
%Tables o chess import

%Inicia el sistema
start:-
        retractall(board(_)),
        assert(board([])),
        retractall(turn(_)),
        assert(turn(yellow)),
        board_color.


winner:-
        board(List),
        diagonal(List),
        writeln('diagonalwin'),
        end.


winner:-
        board(List),
        vertical(List),
        writeln('verticalwin'),
        end.

winner:-
        board(List),
        horizontal(List),
        writeln('horizontalwin'),
        end.


vertical(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X+1,
        member(soldier(X1,Y,Player),Board),
        X2 is X+2,
        member(soldier(X2,Y,Player),Board),
        X3 is X+3,
        member(soldier(X3,Y,Player),Board).


horizontal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        Y1 is Y-1,
        member(soldier(X,Y1,Player),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,Player),Board),
        Y3 is Y+2,
        member(soldier(X,Y3,Player),Board).


horizontal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        Y1 is Y+1,
        member(soldier(X,Y1,Player),Board),
        Y2 is Y-1,
        member(soldier(X,Y2,Player),Board),
        Y3 is Y-2,
        member(soldier(X,Y3,Player),Board).


horizontal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        Y1 is Y-1,
        member(soldier(X,Y1,Player),Board),
        Y2 is Y-2,
        member(soldier(X,Y2,Player),Board),
        Y3 is Y-3,
        member(soldier(X,Y3,Player),Board).


horizontal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        Y1 is Y+1,
        member(soldier(X,Y1,Player),Board),
        Y2 is Y+2,
        member(soldier(X,Y2,Player),Board),
        Y3 is Y+3,
        member(soldier(X,Y3,Player),Board).




diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X-1,
        Y1 is Y+1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X-2,
        Y2 is Y+2,
        member(soldier(X2,Y2,Player),Board),
        X3 is X-3,
        Y3 is Y+3,
        member(soldier(X3,Y3,Player),Board).




diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X+1,
        Y1 is Y-1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X-1,
        Y2 is Y+1,
        member(soldier(X2,Y2,Player),Board),
        X3 is X-2,
        Y3 is Y+2,
        member(soldier(X3,Y3,Player),Board).




diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X-1,
        Y1 is Y+1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X+1,
        Y2 is Y-1,
        member(soldier(X2,Y2,Player),Board),
        X3 is X+2,
        Y3 is Y-2,
        member(soldier(X3,Y3,Player),Board).




diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X+1,
        Y1 is Y-1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X+2,
        Y2 is Y-2,
        member(soldier(X2,Y2,Player),Board),
        X3 is X+3,
        Y3 is Y-3,
        member(soldier(X3,Y3,Player),Board).


diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X+1,
        Y1 is Y+1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X+2,
        Y2 is Y+2,
        member(soldier(X2,Y2,Player),Board),
        X3 is X+3,
        Y3 is Y+3,
        member(soldier(X3,Y3,Player),Board).




diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X-1,
        Y1 is Y-1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X+1,
        Y2 is Y+1,
        member(soldier(X2,Y2,Player),Board),
        X3 is X+2,
        Y3 is Y+2,
        member(soldier(X3,Y3,Player),Board).




diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X-1,
        Y1 is Y-1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X-2,
        Y2 is Y-2,
        member(soldier(X2,Y2,Player),Board),
        X3 is X+1,
        Y3 is Y+1,
        member(soldier(X3,Y3,Player),Board).




diagonal(Board):-
        nth1(1,Board,soldier(X,Y,Player)),
        X1 is X-1,
        Y1 is Y-1,
        member(soldier(X1,Y1,Player),Board),
        X2 is X-2,
        Y2 is Y-2,
        member(soldier(X2,Y2,Player),Board),
        X3 is X-3,
        Y3 is Y-3,
        member(soldier(X3,Y3,Player),Board).



putPiece1(List,Col,Line):-
        not(member(soldier(_,Col,_),List)),
        Line is 7.



putPiece1(List,Col,Line):-

        member(soldier(Line1,Col,_),List),
        not((member(soldier(Line2,Col,_),List),Line2<Line1)),
        Line is Line1-1.



%movimientos de computadora
computer_move:-
        board(Board),
        vir_computer_move(Board,1,NewBoards),
        computer_rate(NewBoards,ListValue),writeln(ListValue),
        findall(Value,member(place(_,Value),ListValue),Values),
        (   (member(Value,Values),
             Value\=0,
        max(ListValue,place(Col,Value)),writeln(Value));
        (writeln('middle'),findMiddle(4,Col)   )),
        putPieceNew(Col),
        (   ((winner);(isFull(Board,1)));
              (   changeturn(red),
                   board_color)).



findMiddle(Col,Col):-
        board(Board),
        not(blocked(2,Col,Board)).

findMiddle(Temp,Col):-
        board(Board),
        blocked(2,Temp,Board),
        Temp1 is Temp-1,
        findMiddle(Temp1,Col).

findMiddle(Temp,Col):-
        board(Board),
        blocked(2,Temp,Board),
        Temp1 is Temp+1,
        findMiddle(Temp1,Col).



%obtiene el tablero actual y hace una lista de posibles tableros
vir_computer_move(_,8,[]).

vir_computer_move(Board,Col,NewBoards):-
        putPiece1(Board,Col,1),
        NewCol is Col+1,
        vir_computer_move(Board,NewCol,NewBoards).

vir_computer_move(Board,Col,[(Col,[soldier(Line,Col,red)|Board])|NewBoards]):-
        putPiece1(Board,Col,Line),
        Line>1,
        NewCol is Col+1,
        vir_computer_move(Board,NewCol,NewBoards).


isFull(Board,7):-
        blocked(2,7,Board),
        endTie.


isFull(Board,Col):-
        blocked(2,Col,Board),
        NewCol is Col+1,
        isFull(Board,NewCol).



computer_rate([],[]).
computer_rate([(Col,Board)|_],[place(Col,Win1)]):-
        win1(Board,Win1),
        Win1>0.

computer_rate([(Col,Board)|TailBoards],[place(Col,Value)|Rated]):-
        pairs(Board,Pairs),
        triples(Board,Triples),
%       win1(Board,Win1),
        oppairs(Board,OPPairs),
        optriples(Board,OPTriples),
%       opcanwin(Board,OPCanWin),
        Value is (Pairs+Triples-(OPPairs+OPTriples)),
        computer_rate(TailBoards,Rated).


blocked(X,Y,Board):-
        member(soldier(X,Y,_),Board).

blocked(X,_,_):-
        X<2.

blocked(X,_,_):-
        X>7.

blocked(_,Y,_):-
        Y<1.

blocked(_,Y,_):-
        Y>7.


blocked1(X,Y,Board):-
        member(soldier(X,Y,red),Board).


pairs(Board,Value):-
        allPairsVer(1,Board,Value1),
        allPairsHor(2,Board,Value2),
        allPairsDiag(2,Board,Value3),
        Value is Value1+Value2+Value3.


allPairsVer(8,_,0).
allPairsVer(Col,Board,Value):-
        pairsVertical(Col,Board,ValueCol),
        NewCol is Col +1,
        allPairsVer(NewCol,Board,ValueRest),
        Value is ValueCol+ValueRest.
pairsVertical(Y,Board,Value):-
        member(soldier(X,Y,red),Board),
        X>4,
        X2 is X-1,
        member(soldier(X2,Y,red),Board),
        X3 is X2-1,
        not(member(soldier(X3,Y,_),Board)),
        Value is 10.
pairsVertical(_,_,0).
allPairsHor(8,_,0).
allPairsHor(Line,Board,Value):-
        somePairsHor(Line,Board,ValueLine),
        NewLine is Line+1,
        allPairsHor(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.
somePairsHor(X,Board,EndValue):-
        findall(Value,pairsHorizontal(X,Board,Value),List),
        sumlist(List,EndValue).

pairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        not((blocked(X,Y3,Board))),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Value is 45.

pairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        not(blocked1(X,Y3,Board)),
        blocked(X,Y3,Board),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Value is 30.

pairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        not((blocked(X,Y3,Board))),
        Y4 is Y-1,
        not(blocked1(X,Y4,Board)),
        blocked(X,Y4,Board),
        Value is 30.

pairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        blocked(X,Y3,Board),
        Y4 is Y-1,
        blocked(X,Y4,Board),
        Value is 0.
pairsHorizontal(_,_,0).

allPairsDiag(8,_,0).
allPairsDiag(Line,Board,Value):-
        somePairsDiag(Line,Board,ValueLine),
        NewLine is Line+1,
        allPairsDiag(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.

somePairsDiag(X,Board,EndValue):-
        findall(Value,pairsDiagonal(X,Board,Value),List),
        findall(Value,pairsDiagonal1(X,Board,Value),List1),
        append(List,List1,List2),
        sumlist(List2,EndValue).

pairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
%       pairsDiagonal1(X,Board,Value1),
        Value is 50.

pairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X-1,
        not(blocked1(X4,Y4,Board)),
        blocked(X4,Y4,Board),
%       pairsDiagonal1(X,Board,Value1),
        Value is 35.

pairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        not(blocked1(X3,Y3,Board)),
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
%       pairsDiagonal1(X,Board,Value1),
        Value is 35.

pairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X-1,
        blocked(X4,Y4,Board),
%       pairsDiagonal1(X,Board,Value1),
        Value is 0.

pairsDiagonal(_,_,0).

pairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Value is 50.

pairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        not(blocked1(X3,Y3,Board)),
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Value is 35.

pairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X+1,
        not(blocked1(X4,Y4,Board)),
        blocked(X4,Y4,Board),
        Value is 35.

pairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X+1,
        blocked(X4,Y4,Board),
        Value is 0.

pairsDiagonal1(_,_,0).

triples(Board,Value):-
        allTriplesVer(1,Board,Value1),
        allTriplesHor(2,Board,Value2),
        allTriplesDiag(2,Board,Value3),
        Value is Value1+Value2+Value3.

allTriplesVer(8,_,0).
allTriplesVer(Col,Board,Value):-
        triplesVertical(Col,Board,ValueCol),
        NewCol is Col +1,
        allTriplesVer(NewCol,Board,ValueRest),
        Value is ValueCol+ValueRest.

triplesVertical(Y,Board,Value):-
        member(soldier(X,Y,red),Board),
        X>4,
        X2 is X-1,
        member(soldier(X2,Y,red),Board),
        X3 is X2-1,
        member(soldier(X3,Y,red),Board),
        X4 is X3-1,
        not(member(soldier(X4,Y,_),Board)),
        Value is 25.

triplesVertical(_,_,0).

allTriplesHor(8,_,0).
allTriplesHor(Line,Board,Value):-
        someTriplesHor(Line,Board,ValueLine),
        NewLine is Line+1,
        allTriplesHor(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.
someTriplesHor(X,Board,EndValue):-
        findall(Value,triplesHorizontal(X,Board,Value),List),
        sumlist(List,EndValue).

triplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,red),Board),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Y5 is Y3+1,
        not((blocked(X,Y5,Board))),
        Value is 80.
triplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,red),Board),
        Y4 is Y-1,
        blocked(X,Y4,Board),
        Y5 is Y3+1,
        not((blocked(X,Y5,Board))),
        Value is 60.

triplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,red),Board),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Y5 is Y3+1,
        blocked(X,Y5,Board),
        Value is 60.

triplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,red),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,red),Board),
        Y4 is Y-1,
        blocked(X,Y4,Board),
        Y5 is Y3+1,
        blocked(X,Y5,Board),
        Value is 0.

triplesHorizontal(_,_,0).

allTriplesDiag(8,_,0).
allTriplesDiag(Line,Board,Value):-
        someTriplesDiag(Line,Board,ValueLine),
        NewLine is Line+1,
        allTriplesDiag(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.

someTriplesDiag(X,Board,EndValue):-
        findall(Value,triplesDiagonal(X,Board,Value),List),
        findall(Value1,triplesDiagonal1(X,Board,Value1),List1),
        append(List,List1,List2),
        sumlist(List2,EndValue).

triplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3+1,
        not((blocked(X5,Y5,Board))),
        Value is 85.

triplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X-1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3+1,
        not((blocked(X5,Y5,Board))),
        Value is 65.

triplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3+1,
        blocked(X5,Y5,Board),
        Value is 65.

triplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X-1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3+1,
        blocked(X5,Y5,Board),
        Value is 0.

triplesDiagonal(_,_,0).


triplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3-1,
        not((blocked(X5,Y5,Board))),
        Value is 85.

triplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X+1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3-1,
        not((blocked(X5,Y5,Board))),
        Value is 65.

triplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3-1,
        blocked(X5,Y5,Board),
        Value is 65.

triplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,red),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,red),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,red),Board),
        Y4 is Y-1,
        X4 is X+1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3-1,
        blocked(X5,Y5,Board),
        Value is 0.

triplesDiagonal1(_,_,0).

win1(Board,Value):-
        diagonalwin(Board),
        Value is 1000000.

win1(Board,Value):-
        verticalwin(Board),
        Value is 1000000.

win1(Board,Value):-
        horizontalwin(Board),
        Value is 1000000.

win1(_,0).

verticalwin(Board):-
        member(soldier(X,Y,red),Board),
        X1 is X+1,
        member(soldier(X1,Y,red),Board),
        X2 is X+2,
        member(soldier(X2,Y,red),Board),
        X3 is X+3,
        member(soldier(X3,Y,red),Board).


horizontalwin(Board):-
        member(soldier(X,Y,red),Board),
        Y1 is Y+1,
        member(soldier(X,Y1,red),Board),
        Y2 is Y+2,
        member(soldier(X,Y2,red),Board),
        Y3 is Y+3,
        member(soldier(X,Y3,red),Board).


diagonalwin(Board):-
        member(soldier(X,Y,red),Board),
        X1 is X-1,
        Y1 is Y+1,
        member(soldier(X1,Y1,red),Board),
        X2 is X-2,
        Y2 is Y+2,
        member(soldier(X2,Y2,red),Board),
        X3 is X-3,
        Y3 is Y+3,
        member(soldier(X3,Y3,red),Board).


diagonalwin(Board):-
        member(soldier(X,Y,red),Board),
        X1 is X+1,
        Y1 is Y+1,
        member(soldier(X1,Y1,red),Board),
        X2 is X+2,
        Y2 is Y+2,
        member(soldier(X2,Y2,red),Board),
        X3 is X+3,
        Y3 is Y+3,
        member(soldier(X3,Y3,red),Board).


oppairs(Board,Value):-
        allopPairsVer(1,Board,Value1),
        allopPairsHor(2,Board,Value2),
        allopPairsDiag(2,Board,Value3),
        Value is Value1+Value2+Value3.


allopPairsVer(8,_,0).
allopPairsVer(Col,Board,Value):-
        oppairsVertical(Col,Board,ValueCol),
        NewCol is Col +1,
        allopPairsVer(NewCol,Board,ValueRest),
        Value is ValueCol+ValueRest.
oppairsVertical(Y,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        X>4,
        X2 is X-1,
        member(soldier(X2,Y,yellow),Board),
        X3 is X2-1,
        not(member(soldier(X3,Y,_),Board)),
        Value is 9.

oppairsVertical(_,_,0).

allopPairsHor(8,_,0).
allopPairsHor(Line,Board,Value):-
        someopPairsHor(Line,Board,ValueLine),
        NewLine is Line+1,
        allopPairsHor(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.
someopPairsHor(X,Board,EndValue):-
        findall(Value,oppairsHorizontal(X,Board,Value),List),
        sumlist(List,EndValue).

oppairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        not((blocked(X,Y3,Board))),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Value is 44.

oppairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        blocked(X,Y3,Board),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Value is 29.

oppairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        not((blocked(X,Y3,Board))),
        Y4 is Y-1,
        blocked(X,Y4,Board),
        Value is 29.

oppairsHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        blocked(X,Y3,Board),
        Y4 is Y-1,
        blocked(X,Y4,Board),
        Value is 0.

oppairsHorizontal(_,_,0).

allopPairsDiag(8,_,0).

allopPairsDiag(Line,Board,Value):-
        someopPairsDiag(Line,Board,ValueLine),
        NewLine is Line+1,
        allopPairsDiag(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.

someopPairsDiag(X,Board,EndValue):-
        findall(Value,oppairsDiagonal(X,Board,Value),List),
        sumlist(List,EndValue).

oppairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
        oppairsDiagonal1(X,Board,Value1),
        Value is Value1+49.

oppairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X-1,
        blocked(X4,Y4,Board),
        oppairsDiagonal1(X,Board,Value1),
        Value is Value1+34.

oppairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
        oppairsDiagonal1(X,Board,Value1),
        Value is Value1+34.

oppairsDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X-1,
        blocked(X4,Y4,Board),
        oppairsDiagonal1(X,Board,Value1),
        Value is Value1.

oppairsDiagonal(_,_,0).

oppairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Value is 49.

oppairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Value is 34.

oppairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        not((blocked(X3,Y3,Board))),
        Y4 is Y-1,
        X4 is X+1,
        blocked(X4,Y4,Board),
        Value is 34.

oppairsDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        blocked(X3,Y3,Board),
        Y4 is Y-1,
        X4 is X+1,
        blocked(X4,Y4,Board),
        Value is 0.

oppairsDiagonal1(_,_,0).

optriples(Board,Value):-
        allopTriplesVer(1,Board,Value1),
        allopTriplesHor(2,Board,Value2),
        allopTriplesDiag(2,Board,Value3),
        Value is Value1+Value2+Value3.



allopTriplesVer(8,_,0).
allopTriplesVer(Col,Board,Value):-
        optriplesVertical(Col,Board,ValueCol),
        NewCol is Col +1,
        allopTriplesVer(NewCol,Board,ValueRest),
        Value is ValueCol+ValueRest.


optriplesVertical(Y,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        X>4,
        X2 is X-1,
        member(soldier(X2,Y,yellow),Board),
        X3 is X2-1,
        member(soldier(X3,Y,yellow),Board),
        X4 is X3-1,
        not(member(soldier(X4,Y,_),Board)),
        Value is 24.


optriplesVertical(_,_,0).

allopTriplesHor(8,_,0).
allopTriplesHor(Line,Board,Value):-
        someopTriplesHor(Line,Board,ValueLine),
        NewLine is Line+1,
        allopTriplesHor(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.
someopTriplesHor(X,Board,EndValue):-
        findall(Value,optriplesHorizontal(X,Board,Value),List),
        sumlist(List,EndValue).

optriplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,yellow),Board),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Y5 is Y3+1,
        not((blocked(X,Y5,Board))),
        Value is 79.
optriplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,yellow),Board),
        Y4 is Y-1,
        blocked(X,Y4,Board),
        Y5 is Y3+1,
        not((blocked(X,Y5,Board))),
        Value is 59.

optriplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,yellow),Board),
        Y4 is Y-1,
        not((blocked(X,Y4,Board))),
        Y5 is Y3+1,
        blocked(X,Y5,Board),
        Value is 59.

optriplesHorizontal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y2+1,
        member(soldier(X,Y3,yellow),Board),
        Y4 is Y-1,
        blocked(X,Y4,Board),
        Y5 is Y3+1,
        blocked(X,Y5,Board),
        Value is 0.


optriplesHorizontal(_,_,0).

allopTriplesDiag(8,_,0).

allopTriplesDiag(Line,Board,Value):-
        someopTriplesDiag(Line,Board,ValueLine),
        NewLine is Line+1,
        allopTriplesDiag(NewLine,Board,ValueRest),
        Value is ValueLine+ValueRest.

someopTriplesDiag(X,Board,EndValue):-
        findall(Value,optriplesDiagonal(X,Board,Value),List),
        findall(Value1,optriplesDiagonal1(X,Board,Value1),List1),
        append(List,List1,List2),
        sumlist(List2,EndValue).

optriplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3+1,
        not((blocked(X5,Y5,Board))),
        Value is 84.

optriplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X-1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3+1,
        not((blocked(X5,Y5,Board))),
        Value is 64.

optriplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X-1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3+1,
        blocked(X5,Y5,Board),
        Value is 64.

optriplesDiagonal(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X+1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2+1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X-1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3+1,
        blocked(X5,Y5,Board),
        Value is 0.

optriplesDiagonal(_,_,0).

optriplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3-1,
        not((blocked(X5,Y5,Board))),
        Value is 84.

optriplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X+1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3-1,
        not((blocked(X5,Y5,Board))),
        Value is 64.

optriplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X+1,
        not((blocked(X4,Y4,Board))),
        Y5 is Y3+1,
        X5 is X3-1,
        blocked(X5,Y5,Board),
        Value is 64.

optriplesDiagonal1(X,Board,Value):-
        member(soldier(X,Y,yellow),Board),
        Y2 is Y+1,
        X2 is X-1,
        member(soldier(X2,Y2,yellow),Board),
        Y3 is Y2+1,
        X3 is X2-1,
        member(soldier(X3,Y3,yellow),Board),
        Y4 is Y-1,
        X4 is X+1,
        blocked(X4,Y4,Board),
        Y5 is Y3+1,
        X5 is X3-1,
        blocked(X5,Y5,Board),
        Value is 0.

optriplesDiagonal1(_,_,0).


opcanwin(Board,Value):-
        opdiagonalwin(Board),
        Value is 100000.

opcanwin(Board,Value):-
        opverticalwin(Board),
        Value is 100000.

opcanwin(Board,Value):-
        ophorizontalwin(Board),
        Value is 100000.

opcanwin(_,0).

opverticalwin(Board):-
        member(soldier(X,Y,yellow),Board),
        X1 is X+1,
        member(soldier(X1,Y,yellow),Board),
        X2 is X+2,
        member(soldier(X2,Y,yellow),Board),
        X3 is X+3,
        member(soldier(X3,Y,yellow),Board).

ophorizontalwin(Board):-
        member(soldier(X,Y,yellow),Board),
        Y1 is Y+1,
        member(soldier(X,Y1,yellow),Board),
        Y2 is Y+2,
        member(soldier(X,Y2,yellow),Board),
        Y3 is Y+3,
        member(soldier(X,Y3,yellow),Board).


opdiagonalwin(Board):-
        member(soldier(X,Y,yellow),Board),
        X1 is X-1,
        Y1 is Y+1,
        member(soldier(X1,Y1,yellow),Board),
        X2 is X-2,
        Y2 is Y+2,
        member(soldier(X2,Y2,yellow),Board),
        X3 is X-3,
        Y3 is Y+3,
        member(soldier(X3,Y3,yellow),Board).


opdiagonalwin(Board):-
        member(soldier(X,Y,yellow),Board),
        X1 is X+1,
        Y1 is Y+1,
        member(soldier(X1,Y1,yellow),Board),
        X2 is X+2,
        Y2 is Y+2,
        member(soldier(X2,Y2,yellow),Board),
        X3 is X+3,
        Y3 is Y+3,
        member(soldier(X3,Y3,yellow),Board).



max(ListValue,place(Col,Value)):-
    member(place(Col,Value),ListValue),
    not((member(place(_,V1),ListValue),V1>Value)).


putPieceNew(Col):-
        board(List),
        turn(Turn),
        not(member(soldier(_,Col,_),List)),
        retract(board(_)),
        assert(board([soldier(7,Col,Turn)|List])).

putPieceNew(Col):-
        board(List),
        turn(Turn),
        member(soldier(Line,Col,_),List),
        not((member(soldier(Line2,Col,_),List),Line2<Line)),
        Line1 is Line-1,
        retract(board(_)),
        assert(board([soldier(Line1,Col,Turn)|List])).
        