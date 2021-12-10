%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programadog em logica estendida


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- dynamic '-'/1.
:- dynamic mamal/1.
:- dynamic bat/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

-fly( tweety ).

-fly( X ) :-
    mamal( X ).

-fly(X) :- mamal(X),not(exception(-fly(X))).

-fly(X) :- exception(fly(X)).

fly(X) :- exception(-fly(X)).

fly( X ) :-
    bird( X ).

fly(X) :-
    bird(X), 
    not(exception(fly(X))).

bird(tweety).

bird(X) :- canary(X).
bird(X) :- ostrich(X).
bird(X) :- penguin(X).

canary(piupiu).
ostrich(trux).
penguin(pingu).

mamal(silvestre).

mamal(X) :- dog(X).
mamal(X) :- cat(X).
mamal(X) :- bat(X).

bat(bate).
dog(boby).

si(Questao, verdadeiro) :- Questao.
si(Questao, falso) :- -Questao.
si(Questao, desconhecido) :- not(Questao),
							 not(-Questao).

siL([],[]).
siL([Questao|L],[Resposta|S]) :-
    si(Questao,Resposta),
    siL(L,S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -







