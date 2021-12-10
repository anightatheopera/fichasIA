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
    sol((F,P), 
    (son(F,P)),S),
    comp(S,N), 
    N==1
             ).

% Invariante Referencial: doesn's allow more than 2 x for the same y (father/son)

+son(F,P) :: (   
    sol((F,P),(son(F,P),S)),
    comp(S,N),
    N==1     
            ).

+son(F,_) :: (
    sol(Ps,(son(F,Ps),S)),
    comp(S,N),
    N=<2
             ).

-son(F,P) :: (
    sol(F,(age(F,I)),S),
    comp(S,N),
    N == 0
             ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado que permite a evolucao do conhecimento

evolution(Term) :- 
    sol(Invariant,+Term::Invariant,List), 
    rem(Term),
    test(List).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Auxiliar

test([]).
test([R|Lr]) :- R, test(Lr).

sol(X,P,S) :- findall(X,P,S).

rem(Term) :- retract(Term).
rem(Term) :- 
    assert(Term), 
    !, 
    fail.

