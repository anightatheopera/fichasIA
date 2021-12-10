%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% I.A. - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica 
% Pesquisa N達o Informada e Informada (Ficha 6)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extens達o do predicado move: LocalidadeO,LocalidadeD,CustoDistancia,CustoTempo -> {V,F}


move(elvas,borba,15,10).
move(borba,estremoz,15,10).
move(estremoz,evora,40,25).
move(evora,montemor,20,15).
move(montemor,vendasnovas,15,10).
move(vendasnovas,lisboa,50,30).
move(elvas,arraiolos,50,30).
move(arraiolos,alcacer,90,60).
move(alcacer,palmela,35,32).
move(palmela,almada,25,20).
move(palmela,barreiro,25,20).
move(barreiro,palmela,30,20).
move(almada,lisboa,15,20).
move(elvas,alandroal,40,25).
move(alandroal,redondo,25,10).
move(redondo,monsaraz,30,20).
move(monsaraz,barreiro,120,60).
move(barreiro,baixabanheira,5,5).
move(baixabanheira,moita,7,6).
move(moita,alcochete,20,20).
move(alcochete,lisboa,20,15).


% Extens達o do predicado estima: Localidade,EstimaDistancia,EstimaTempo -> {V,F}

estima(elvas,270,150).
estima(borba,250,90 ).
estima(estremoz,145,85).
estima(evora,95,68).
estima(montemor,70,40). 
estima(vendasnovas,45,30).
estima(arraiolos,190,80).
estima(alcacer,65,45).
estima(palmela,40,25 ).
estima(almada,25,20).
estima(alandroal,180,90).
estima(redondo,170,80).
estima(monsaraz,120 ,70).
estima(barreiro,30 ,20 ).
estima(baixabanheira,33,25).
estima(moita,35,20). 
estima(alcochete,26,15 ).
estima(lisboa,0,0).





%Extens達o do predicado goal: Localidade -> {V,F}

goal(lisboa).



%---------------------------------pesquisa a estrela 

resolve_aestrela(Nodo,CaminhoDistancia/CustoDist,CaminhoTempo/CustoTempo) :-
	estima(Nodo,EstimaD,EstimaT),
	aestrela_distancia([[Nodo]/0/EstimaD],InvCaminho/CustoDist/_),
	aestrela_tempo([[Nodo]/0/EstimaT],InvCaminhoTempo/CustoTempo/_),
	inverso(InvCaminho,CaminhoDistancia),
	inverso(InvCaminhoTempo,CaminhoTempo).

aestrela_distancia(Caminhos,Caminho) :-
	obtem_melhor_distancia(Caminhos,Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).

aestrela_distancia(Caminhos,SolucaoCaminho) :-
	obtem_melhor_distancia(Caminhos,MelhorCaminho),
	seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
	expande_aestrela_distancia(MelhorCaminho,ExpCaminhos),
	append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        aestrela_distancia(NovoCaminhos,SolucaoCaminho).	

obtem_melhor_distancia([Caminho],Caminho) :- !.
obtem_melhor_distancia([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2,!,
	obtem_melhor_distancia([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho). 
obtem_melhor_distancia([_|Caminhos],MelhorCaminho) :- 
	obtem_melhor_distancia(Caminhos,MelhorCaminho).
	

expande_aestrela_distancia(Caminho,ExpCaminhos) :-
	findall(NovoCaminho,adjacente_distancia(Caminho,NovoCaminho),ExpCaminhos).
	
% --- tempo 

aestrela_tempo(Caminhos,Caminho) :-
	obtem_melhor_tempo(Caminhos,Caminho),
	Caminho = [Nodo|_]/_/_,
	goal(Nodo).

aestrela_tempo(Caminhos,SolucaoCaminho) :-
	obtem_melhor_tempo(Caminhos,MelhorCaminho),
	seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
	expande_aestrela_tempo(MelhorCaminho,ExpCaminhos),
	append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        aestrela_tempo(NovoCaminhos,SolucaoCaminho).
	
obtem_melhor_tempo([Caminho],Caminho) :- !.
obtem_melhor_tempo([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos],MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2,!,
	obtem_melhor_tempo([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho). 
obtem_melhor_tempo([_|Caminhos],MelhorCaminho) :- 
	obtem_melhor_tempo(Caminhos,MelhorCaminho).
	

expande_aestrela_tempo(Caminho,ExpCaminhos) :-
	findall(NovoCaminho,adjacente_tempo(Caminho,NovoCaminho),ExpCaminhos).
	
	
%-------------------------------------------pesquisa Gulosa


resolve_gulosa(Nodo,CaminhoDistancia/CustoDist,CaminhoTempo/CustoTempo) :-
	estima(Nodo,EstimaD,EstimaT),
	agulosa_distancia_g([[Nodo]/0/EstimaD],InvCaminho/CustoDist/_),
	agulosa_tempo_g([[Nodo]/0/EstimaT],InvCaminhoTempo/CustoTempo/_),
	inverso(InvCaminho,CaminhoDistancia),
	inverso(InvCaminhoTempo,CaminhoTempo).

agulosa_distancia_g(Caminhos,Caminho) :-
	obtem_melhor_distancia_g(Caminhos,Caminho),
	Caminho = [Nodo|_]/_/_,
	goal(Nodo).

agulosa_distancia_g(Caminhos,SolucaoCaminho) :-
	obtem_melhor_distancia_g(Caminhos,MelhorCaminho),
	seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
	expande_agulosa_distancia_g(MelhorCaminho,ExpCaminhos),
	append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        agulosa_distancia_g(NovoCaminhos,SolucaoCaminho).	

obtem_melhor_distancia_g([Caminho],Caminho) :- !.
obtem_melhor_distancia_g([Caminho1/Custo1/Est1,_/_/Est2|Caminhos],MelhorCaminho) :-
	Est1 =< Est2,!,
	obtem_melhor_distancia_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho). 
obtem_melhor_distancia_g([_|Caminhos],MelhorCaminho) :- 
	obtem_melhor_distancia_g(Caminhos,MelhorCaminho).
	

expande_agulosa_distancia_g(Caminho,ExpCaminhos) :-
	findall(NovoCaminho,adjacente_distancia(Caminho,NovoCaminho),ExpCaminhos).
	
% --- tempo 

agulosa_tempo_g(Caminhos,Caminho) :-
	obtem_melhor_tempo_g(Caminhos,Caminho),
	Caminho = [Nodo|_]/_/_,
	goal(Nodo).

agulosa_tempo_g(Caminhos,SolucaoCaminho) :-
	obtem_melhor_tempo_g(Caminhos,MelhorCaminho),
	seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
	expande_agulosa_tempo_g(MelhorCaminho,ExpCaminhos),
	append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
        agulosa_tempo_g(NovoCaminhos,SolucaoCaminho).
	
obtem_melhor_tempo_g([Caminho],Caminho) :- !.
obtem_melhor_tempo_g([Caminho1/Custo1/Est1,_/_/Est2|Caminhos],MelhorCaminho) :-
	Est1 =< Est2,!,
	obtem_melhor_tempo_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho). 
obtem_melhor_tempo_g([_|Caminhos],MelhorCaminho) :- 
	obtem_melhor_tempo_g(Caminhos,MelhorCaminho).
	

expande_agulosa_tempo_g(Caminho,ExpCaminhos) :-
	findall(NovoCaminho,adjacente_tempo(Caminho,NovoCaminho),ExpCaminhos).


adjacente_distancia([Nodo|Caminho]/Custo/_,[ProxNodo,Nodo|Caminho]/NovoCusto/EstDist) :-
	move(Nodo,ProxNodo,PassoCustoDist,_),
	\+ member(ProxNodo,Caminho),
	NovoCusto is Custo+PassoCustoDist,
	estima(ProxNodo,EstDist,_).


adjacente_tempo([Nodo|Caminho]/Custo/_,[ProxNodo,Nodo|Caminho]/NovoCusto/EstimaTempo) :-
	move(Nodo,ProxNodo,_,PassoTempo),
	\+ member(ProxNodo,Caminho),
	NovoCusto is Custo+PassoTempo,
	estima(ProxNodo,_,EstimaTempo).
%---------------------------------predicados auxiliares

inverso(Xs,Ys):-
	inverso(Xs,[],Ys).

inverso([],Xs,Xs).
inverso([X|Xs],Ys,Zs):-
	inverso(Xs,[X|Ys],Zs).

seleciona(E,[E|Xs],Xs).
seleciona(E,[X|Xs],[X|Ys]) :- seleciona(E,Xs,Ys).

nao(Questao) :-
    Questao,
	!,
	fail.
nao(Questao).

membro(X,[X|_]).
membro(X,[_|Xs]):-
	membro(X,Xs).		

escrever([]).
escrever([X|L]):- 
	write(X),
	nl,
	escrever(L).