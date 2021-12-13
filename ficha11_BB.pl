%Ficha 11 PL

:- op(900,xfy,'::').
:- dynamic service/2.
:- dynamic doing/4.

-servico(_,Name) :- 
    not(servico(_,A)),
    not(exception(servico(_,A))).
	
-ato(A,B,C,D) :-
	not(ato(A,B,C,D)),
	not(exception(ato(A,B,C,D))).

servico(ortopedia,amelia).
servico(obstetricia,ana).
servico(obstetricia,maria).
servico(obstetricia,mariana).
servico(geriatria,sofia).
servico(geriatria,susana).
servico(z7,teodora).
servico(np9,zulmira).

exception(servico(_,E)) :- servico(z7,E).
exception(servico(_,E)) :- servico(np9,E).

null(np9).

ato(penso,ana,joana,sabado).
ato(gesso,amelia,jose,domingo).
ato(z17,mariana,joaquina,domingo).
ato(domicilio,maria,c21,d51).
ato(sutura,t13,josue,segunda).

exception(ato(_,A,B,C)) :- ato(z17,A,B,C).
exception(ato(A,B,_,_)) :- ato(A,B,c21,d51).
exception(ato(A,_,C,D)) :- ato(A,t13,C,D).
exception(ato(domicilio,susana,joao,segunda)).
exception(ato(domicilio,susana,jose,segunda)).
exception(ato(sutura,maria,josefa,terca)).
exception(ato(sutura,maria,josefa,sexta)).
exception(ato(sutura,mariana,josefa,terca)).
exception(ato(sutura,mariana,josefa,sexta)).
exception(ato(bandaid,ana,jacinta,D)) :- member(D,[segunda,terca,quarta,quinta,sexta]).


%Invariantes
+ato(A,E,U,D) :: (
    D==feriado,
    findall((A,E,U,D),ato((A,E,U,D)),S),
    length(S,N),
    N==0
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
