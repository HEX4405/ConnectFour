run :- 
	write('==============================='), nl,
	write('== Welcome to Connect Four ! =='), nl,
	write('==============================='), nl, nl,
	play([[],[],[],[],[],[],[]], x).

play(Board, Player) :-
	nl, displayBoard(Board), nl, nl,
	write('Player '), write(Player), write(' choose a column number : '), nl,
	read(N),
	playMove(Board, N, Player, NewBoard, X),
	otherPlayer(Player, Opponent),
	play(NewBoard, Opponent).

playMove([L|G], 1, Player, _, _):- length(L, N), N >= 6, nl, write('Illegal move !'), nl, play([L|G], Player).
playMove([L|G], 1, Player, F, I):- length(L, N), N < 6, pushBack(Player, L, M), F=[M|G].
playMove([L|G], N, Player, _, _):- N > 7, nl, write('Illegal move !'), nl, play([L|G], Player).
playMove([T|X], N, Player, [T|G], I):- N > 0, N1 is N-1, playMove(X, N1, Player, G, I).

otherPlayer(x, o).
otherPlayer(o, x).

pushBack(X, [], [X]).
pushBack(X, [Y|L1], [Y|L2]):- pushBack(X, L1, L2).

nthElem(N, L, []) :- length(L, N1), N1 < N.
nthElem(N, L, X) :- nth1(N, L, X).

/*--- DISPLAY ---*/

displayElement([]) :- write(' '), !.
displayElement(E) :- write(E).

displayListe([]):- write('|').

displayListe([E|L]) :-  
	write('|'), 
	displayElement(E),
	displayListe(L).

displayBoard(_,0).

displayBoard(G, N):-	 
	N > 0,
	N1 is N-1,
	maplist(nthElem(N), G, L),
	displayListe(L),
	nl,
	displayBoard(G, N1).

displayBoard(G):- 
	displayBoard(G, 6),  
	write(' ¯ ¯ ¯ ¯ ¯ ¯ ¯'),
	nl,
	write(' 1 2 3 4 5 6 7').




 

