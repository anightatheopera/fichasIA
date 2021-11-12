% alínea a


solveDF(Ei, Ef, Path) :-
    solveDF(Ei, Ef, [], Path).

solveDF(Ei, Ei, Visited, Path) :- reverse(Visited, Path).
solveDF(Ei, Ef, Visited, Path) :-
    not(member(Ei, Visited)),
    t(Ei, E, T),
    solveDF(E, Ef, [Ei|Visited], Path).


t((Xi, Yi), (8, Yi), t1x).
t((Xi, Yi), (Xi, 5), t1y).
t((Xi, Yi), (0, Yi), t2x).
t((Xi, Yi), (Xi, 0), t2y).
t((Xi, Yi), (Xf,Yf), t3x) :- 
    A is 8 - Xi,
    Diff is min(A,Yi),
    Xf is Xi + Diff,
    Yf is Yi - Diff.
t((Xi, Yi), (Xf,Yf), t3y) :- 
    A is 5 - Yi,
    Diff is min(A,Xi),
    Xf is Xi - Diff,
    Yf is Yi + Diff.