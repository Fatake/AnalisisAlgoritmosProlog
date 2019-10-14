reconoce(0,R):- R = "Cero".
reconoce(1,R):- R = "Uno".
reconoce(2,R):- R = "Dos".
reconoce(3,R):- R = "Tres".
reconoce(4,R):- R = "Cuatro".
reconoce(5,R):- R = "Cinco".
reconoce(6,R):- R = "Seis".
reconoce(7,R):- R = "Siete".
reconoce(8,R):- R = "Ocho".
reconoce(9,R):- R = "Nueve".

recibeLista([],[]).
recibeLista([X|Xre],[Nu|Nure]):-
					reconoce(X,P),
					Nu = P,
					recibeLista(Xre,Nure).