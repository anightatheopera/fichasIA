inicial(jarros(0,0)).

final(jarros(4,_)).
final(jarros(_,4)).

transicao(jarros(V1,V2),encher(1),jarros(8,V2))      :- V1<8.
transicao(jarros(V1,V2),encher(2),jarros(V1,5))      :- V2<5.
transicao(jarros(V1,V2),esvaziar(1),jarros(0,V2))    :- V1>0.
transicao(jarros(V1,V2),esvaziar(2),jarros(V1,0))    :- V2>0.
transicao(jarros(V1,V2),transferir(1,2),jarros(NV1,NV2)) :- 
    A is 5-V2,
    Dif is min(A,V1),
    NV1 is V1- Dif,
    NV2 is V2+Dif.
transicao(jarros(V1,V2),transferir(2,1),jarros(NV1,NV2)) :- 
    A is 8-V1,
    Dif is min(A,V2),
    NV1 is V1+Dif,
    NV2 is V2-Dif.


% coisa em dfs
dfsYuh(Solucao) :- 
    inicial(Inicial),
    dfsYuh(Inicial,[Inicial],Solucao).

dfsYuh(Estado, Vis,[]) :- 
    final(Estado),
    !,
    write(Vis).
dfsYuh(Estado,Vis,[Move|Solucao]) :- 
    transicao(Estado,Move,Estado1),
    not(member(Estado1,Vis)), 
    dfsYuh(Estado1,[Estado1|Vis],Solucao).

%coisa em bfs
bfsYuh(Solucao) :- bfsYuh(jarros(0,0),jarros(_,4),Solucao).

bfsYuh(Orig, Dest, Cam):- bfs3(Dest,[[Orig]],Cam).

bfs3(EstadoF,[[EstadoF|T]|_],Solucao)  :- reverse([EstadoF|T],Solucao).
bfs3(EstadoF,[EstadoA|Outros],Solucao) :- 
    EstadoA = [Act|_],
    findall([X|EstadoA],
            (EstadoF\==Act,
            transicao(Act,Move,X),
            not(member(X,EstadoA))),
            Novos),
    append(Outros,Novos,Todos),
    bfs3(EstadoF,Todos,Solucao).