aresta(s,e,2).
aresta(s,a,2).
aresta(a,b,2).
aresta(b,c,2).
aresta(c,d,3).
aresta(d,t,3).
aresta(e,f,5).
aresta(f,g,2).
aresta(g,t,2).

goal(t).

% estimativas(greedy search)
estima(s,10).
estima(a,5).
estima(e,7).
estima(f,4).
estima(b,4).
estima(c,4).
estima(g,2).
estima(d,3).
estima(t,0).


dfs(Nodo,[Nodo|Caminho],C) :- profundidade(Nodo,[Nodo],Caminho,C).


profundidade(t,_,[],0) :- goal(t).

profundidade(Nodo,Historico,[ProxNodo|Caminho],C) :- 
    adjacente(Nodo,ProxNodo,C1),
    not(member(ProxNodo,Historico)),
    profundidade(ProxNodo,[ProxNodo|Historico],Caminho,C2), C is C1+C2.

adjacente(Nodo, ProxNodo, C) :- aresta(Nodo,ProxNodo,C).
adjacente(Nodo, ProxNodo, C) :- aresta(ProxNodo,Nodo,C).

resolve_gulosa(Nodo,Caminho/Custo) :- 
        estima(Nodo, Estima),
        agulosa([[Nodo]/0/Estima], InvCaminho/Custo/_),
        reverse(InvCaminho, Caminho).

agulosa(Caminhos, Caminho) :-
    obtem_melhor_g(Caminhos,Caminho),
    Caminho = [Nodo|_]/_/_,
    goal(Nodo).

agulosa(Caminhos, SolucaoCaminho) :-
    obtem_melhor_g(Caminhos,MelhorCaminho),
    remove(MehorCaminho,Caminhos,OutrosCaminhos),
    expande_gulosa(MelhorCaminho,ExpCaminhos),
    append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
    agulosa(NovoCaminhos,SolucaoCaminho).


obtem_melhor_g([Caminho],Caminho) :- !.
obtem_melhor_g([Caminho1/Custo1/Est1, _/Custo2/Est2|Caminhos], MelhorCaminho) :-
    Est1 =< Est2, !,
    obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
obtem_melhor_g([_|Caminhos], MelhorCaminho) :- obtem_melhor_g(Caminhos, MelhorCaminho).

expande_gulosa(Caminho,ExpCaminhos) :-
    findall(NovoCaminho, adjacente2(Caminho,NovoCaminho),ExpCaminhos).

adjacente2([Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/Est) :-
    aresta(Nodo,ProxNodo,PassoCusto),
    not(member(ProxNodo,Caminho)),
    NovoCusto is Custo + PassoCusto,
    estima(ProxNodo,Est).

remove(E,[E|Xs],Xs).
remove(E,[X|Xs],[X|Ys]) :- remove(E,Xs,Ys).
