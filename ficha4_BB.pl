%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Grafos (Ficha 9)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Diferentes representacaoes de grafos
%
%lista de adjacencias: [n(b,[c,g,h]), n(c,[b,d,f,h]), n(d,[c,f]), ...]
%
%termo-grafo: grafo([b,c,d,f,g,h,k],[e(b,c),e(b,g),e(b,h), ...]) or
%            digrafo([r,s,t,u],[a(r,s),a(r,t),a(s,t), ...])
%
%clausula-aresta: aresta(a,b)


%---------------------------------

g( grafo([madrid, cordoba, braga, guimaraes, vilareal, viseu, lamego, coimbra, guarda],
  [aresta(madrid, cordoba, a4, 400),
   aresta(braga, guimaraes,a11, 25),
   aresta(braga, vilareal, a11, 107),
   aresta(guimaraes, viseu, a24, 174),
   aresta(vilareal, lamego, a24, 37),
   aresta(viseu, lamego,a24, 61),
   aresta(viseu, coimbra, a25, 119),
   aresta(viseu,guarda, a25, 75)]
 )).

%--------------------------------- 
%alinea 1)

adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(X,Y,K,E),Es).
adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(Y,X,K,E),Es).

%--------------------------------- 
%alinea 2)

caminho(G,A,B,P) :- caminho(G,A,B,P,[B],[B]).

caminho(G,A,A,P,_,P).
caminho(G,A,B,P,Visited,P0) :-
    adjacente(C, B, _, _, G),
    not(member(C, Visited)),
    caminho(G, A, C, P, [C|Visited], [C|P0]).


%--------------------------------- 
% alinea 3)

ciclo(G,A,[A|P]) :- 
    adjacente(A, B, _, _, G),
    caminho(G, B, A, P).


%--------------------------------- 
%alinea 4)

caminhoK(G,A,B,P,Km,Es) :- caminhoK(G,A,B,P,Km,Es,([B],0,[])).

caminhoK(G,A,A,P,Km,Es,(P,Km,Es)).
caminhoK(G,A,B,P,Km,Es,Acc) :-
    (P0, Km0, Es0) = Acc,
    adjacente(C, B, Es1, Km1, G),
    not(member(C, P0)),
    Km2 is Km0 + Km1,
    caminhoK(G, A, C, P, Km, Es, ([C|P0], Km2, [Es1|Es0])).


%--------------------------------- 
%alinea 5)

cicloK(G,A,[A|P],Km,[Es0,Es1]) :- 
    adjacente(A, B, Es0, Km0, G),
    caminhoK(G, B, A, P, Km1, Es1),
    Km is Km0 + Km1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).