%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas.
app(X+Y, R) :- R is X+Y.
app(X-Y, R) :- R is X-Y.
app(X*Y, R) :- R is X*Y.
app(X/Y, R) :- R is X/Y.
max(X, Y, R) :- X >= Y, R is X.
max(X, Y, R) :- Y >= X, R is Y.
max3(X, Y, Z, R) :- max(X, Y, L), max(L, Z, R).
min(X, Y, R) :- X >= Y, R is Y.
min(X, Y, R) :- Y >= X, R is X.
min3(X, Y, Z, R) :- min(X, Y, L), min(L, Z, R).
par(X) :- 0 is mod(X,2).
impar(X) :- not(par(X)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Soma -> {V,F}

soma( X,Y,Soma ) :-
    Soma is X+Y.

soma( X,Y,Z, Soma) :- Soma is X+Y+Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Máximo divisor comum
mdc(X,X,X).
mdc(X,Y,MDC) :-
    X =\= Y,
    Dif is abs(X-Y),
    min(X,Y,Small),
    mdc(Dif,Small,MDC).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Mínimo múltiplo comum

mmc(X,X,X).
mmc(X,Y,R) :- Mul is X*Y,
              mdc(X,Y,MDC),
              R is Mul/MDC.
