%Ficha 11 PL

:- op(900,xfy,'::').
:- dynamic service/2.
:- dynamic doing/4.

-service(_,Name) :- 
    not(service(_,Name)),
    not(exception(service(_,Name))).
	
-doing(Do,Doer,Doet,Day) :-
	not(doing(Do,Doer,Doet,Day)),
	not(exception(doing(Do,Doer,Doet,Day))).

service(orthopedics,amelia).
service(obstetrics,ana).
service(obstetrics,maria).
service(obstetrics,mariana).
service(geriartrics,sofia).
service(geriartrics,susana).
service(x007,teodora).
service(np9,zulmira).

doing(bandaid,ana,joana,sabado).
doing(plaster,amelia,jose,domingo).
doing(x017,mariana,jose,domingo).
doing(domicilio,maria,x121,x251).
doing(stitching,x313,josue,segunda).

null(np9).

exception(service(_,E)) :- service(x007,E).
exception(service(_,E)) :- service(np9,E).
exception(doing(A,E,_,_)) :- doing(A,E,x121,x251).
exception(doing(A,_,U,D)) :- doing(A,x313,U,D).
exception(doing(_,E,U,D)) :- doing(x017,E,U,D).
exception(doing(domicilio,susana,joao,segunda)).
exception(doing(domicilio,susana,jose,segunda)).
exception(doing(stitching,maria,josefa,terca)).
exception(doing(stitching,maria,josefa,sexta)).
exception(doing(stitching,mariana,josefa,terca)).
exception(doing(stitching,mariana,josefa,sexta)).
exception(doing(bandaid,ana,jacinta,D)) :- member(D,[segunda,terca,quarta,quinta,sexta]).

%Invariantes
+doing(A,P,U,_) :: (
    D\=feriado,
    findall((A,P,U,D),(doing(A,P,U,D)),S),
    length(S,N),
    N==1
                  ).

+service(S,_) :: (
    findall(S,(service(S,zulmira),not(null(S))),L),
    length(L,N),
    N==0
                ).

-service(_,Nome) :: (
    findall(Nome,doing(_,Nome,_,_),S),
    length(S,N),
    N==0
                   ).

% --- Evolucao & Involucao ---
evolve(Thing) :-
    findall(Inv,+Thing::Inv,L),
    add(Thing),
    test(L).

regress(Thing) :-
    findall(Inv,-Thing::Inv,L),
    rem(Thing),
    test(L).

test([]).
test([R|LR]) :-
    R,
    test(LR).

add(Thing) :- assert(Thing).
add(Thing) :-
    retract(Thing),
    !,
    fail.

rem(Thing) :- retract(Thing).
rem(Thing) :-
    assert(Thing),
    !,
    fail.

demo(Questao,verdadeiro) :- Questao.
demo(Questao,falso) :- -Questao.
demo(Questao,desconhecido) :-
    not(Questao),
    not(-Questao).
