%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes sobre listas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :- X \= Y, pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :- comprimento( L,N1 ), N is N1+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F}

diferentes( [],0 ).
%diferentes( [H|T],R ) :- apagaT(H, T, T0), diferentes(T0, R0), R is R0 + 1.
diferentes( [H|T], R) :- diferentes(T, R0), (pertence(H, T) -> R is R0; R is R0+1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}

apaga1( X,[],[] ).
apaga1( X,[X|L],L ).
apaga1( X,[Y|L],[Y|N]) :- X \= Y, apaga1( X,L,N ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagaT( X,[],[] ).
apagaT( X,[X|L],N ) :- apagaT( X,L,N ).
apagaT( X,[Y|L],[Y|N] ) :- apagaT( X,L,N ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

adicionar(X, L, L) :- pertence(X, L).
adicionar(X, L, [X|L]) :- not(pertence(X, L)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}

concatenar([],L,L).
concatenar([X|XS],YS,R) :- concatenar(XS, YS, R0), R = [X|R0].


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}


inverter([],[]).
inverter([X|XS], R) :- inverter(XS, R0), concatenar(R0, [X], R).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

sublista([],L).
sublista([X|XS], [X|LS]) :- sublista(XS, LS).
sublista([X|XS], [Y|LS]) :- X \= Y, sublista([X|XS], LS).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
