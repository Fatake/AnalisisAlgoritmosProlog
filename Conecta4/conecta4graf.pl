% Autor:
% Fecha: 25/11/2019

:- use_module(library(pce)).

juego:-
       new(D, dialog),
       new(Ventana, window("Conecta 4", size(600,400))),
       send(D, append, new(B, button(solve, message@prolog, solve, D, 10, 20))),
       send(D, below, W),
       send(D, opem).