%Ficha 10 PL

:- op( 900,xfy,'::').
:- dynamic game/3.

-game(Game,Ref,Help):-
	not(game(Game,Ref,Help)),
	not(exception(game(Game,Ref,Help))).
-game(7,gg,2500).

game(1,aa,500).
game(2,bb,xpto0123).
game(5,ee,xpto456).
game(6,ff,600).
game(7,gg,xpto789).

null(xpto456).

exception(game(Game,Ref,_)):-
	game(Game,Ref,xpto0123).
exception(game(3,cc,600)).
exception(game(3,cc,350)).
exception(game(4,dd,Help)):- Help>=250, 750>=Help.
exception(game(Game,Ref,_)):- game(Game, Ref, xpto456).
exception(game(6,ff,H)):-H>5000.
exception(game(G,R,_)):-game(G,R,xpto789).
exception(game(8,hh,V)) :- about(1000, Sup, Low),V >= Low,V =< Sup.
exception(game(9,ii,Value)) :- estimation(3000, Sup, Low),Value >= Low,Value =< Sup.

about(V, Sup, Low):- Sup is V * 1.25,Low is V * 0.75.

estimation(V, Sup, Low) :- Sup is V * 1.10,Low is V * 0.90.

%Invariantes
+game(_,_,_) :: (findall(Help,(game(5,ee,Help),not(null(Help))),S),length(S,N),N == 0).

+game(_,R,_)::(findall(R,game(_,R,_),S),length(S,N),N=<3).

+game(_,Ref,_)::(findall((G1,G2),game(G1,Ref,_),game(G2,Ref,_),S),length(S,N), G2 is G1+1,N==0).

% --- Evolucao & Involucao ---
evolve( Thing ) :-
    findall(Inv,+Thing::Inv,L ),
    add( Thing ),
    test( L ).

regress( Thing ) :-
    findall( Inv,-Thing::Inv,L ),
    rem( Thing ),
    test( L ).

add(Thing) :-
    assert(Thing).
add(Thing) :-
    retract(Thing),!,fail.

rem(Thing) :-
    retract(Thing).
rem(Thing) :-
    assert(Thing),!,fail.

test([]).
test([R|LR]) :-
    R,
    test(LR).

