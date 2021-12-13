%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programadog em logica estendida


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: definicoes iniciais

:- set_prolog_flag(discontiguous_warnings,off).
:- set_prolog_flag(single_var_warnings,off).
:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

excecao(voa(X)) :-
  morcego(X).
excecao(-voa(X)) :-
  avestruz(X).
excecao(-voa(X)) :-
  pinguim(X).

voa(X) :-
  ave(X),
  not(excecao(-voa(X))).

voa(X) :-
  excecao(voa(X)).

-voa(X) :-
  mamifero(X),
  not(excecao(voa(X))).

-voa(X) :-
  excecao(-voa(X)).

-voa('Tweety').

ave(X) :- canario(X).
ave(X) :- periquito(X).
ave(X) :- avestruz(X).
ave(X) :- pinguim(X).
ave('Pitigui').
avestruz('Truz').
pinguim('Pingu').
periquito('Faisca').
canario('Piupiu').

mamifero('Silvestre').
mamifero(X) :- cao(X).
mamifero(X) :- gato(X).
mamifero(X) :- morcego(X).
gato('Bichano').
cao('Boby').
morcego('Batman').

demo(Questao,verdadeiro) :- Questao.
demo(Questao,falso) :- -Questao.
demo(Questao,desconhecido) :-
    not(Questao),
    not(-Questao).

demoL([],[]).
demoL([Questao|L],[Resposta|S]) :-
    si(Questao,Resposta),
    demoL(L,S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -







