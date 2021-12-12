%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% ITELIG�NCIA ARTIFICIAL - MiEI/LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariants

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% PROLOG: initial definition

:- op(900,xfy,'::').
:- dynamic son/2.
:- dynamic father/2.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extension son:Son,Father -> {V,F,D}

son(joao,jose).
son(jose,manuel).
son(carlos,jose).

% Structural Invariant: doesn't allow duplicate knowlege addiction 

+son(F,P) :: (
    findall((F,P), 
    (son(F,P)),S),
    comp(S,N), 
    N==1
             ).

% Invariante Referencial: doesn's allow more than 2 x for the same y (father/son)

+son(F,P) :: (   
    findall((F,P),(son(F,P),S)),
    comp(S,N),
    N==1     
            ).

+son(F,_) :: (
    findall(Ps,(son(F,Ps),S)),
    comp(S,N),
    N=<2
             ).

-son(F,P) :: (
    findall(F,(age(F,I)),S),
    comp(S,N),
    N == 0
             ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

evolucao(Term) :- 
    findall(Invariant,+Term::Invariant,List), 
    insercao(Term),
    test(List).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Auxiliar

evolucao(Termo) :-
    findall(Invariante,+Termo::Invariante,Lista),
    insercao(Termo),
    teste(Lista).

insercao(Termo) :-
    assert(Termo).
insercao(Termo) :-
    retract(Termo),!,fail.
