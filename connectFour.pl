run :- 
	write('==============================='), nl,
	write('== Welcome to Connect Four ! =='), nl,
	write('==============================='), nl, nl,
	play([[],[],[],[],[],[],[]], x).

play(Board, Player) :- otherPlayer(Player, Opponent), gameOver(Board, Opponent), nl, displayWinner(Board, Opponent), !.

play(Board, Player) :-
	nl, displayBoard(Board), nl, nl,
	write('Player '), write(Player), write(' choose a column number : '), nl,
	read(N),
	playMove(Board, N, Player, NewBoard, X),
	otherPlayer(Player, Opponent),
	play(NewBoard, Opponent).

playMove([H|T], 1, Player, _, _):- length(H, N), N >= 6, nl, write('Illegal move !'), nl, play([H|T], Player).
playMove([H|T], 1, Player, F, _):- length(H, N), N < 6, pushBack(Player, H, M), F=[M|T].

playMove([H|T], N, Player, _, _):- N > 7, nl, write('Illegal move !'), nl, play([H|T], Player).
playMove([H|T1], N, Player, [H|T2], I):- N > 0, N1 is N-1, playMove(T1, N1, Player, T2, I).

otherPlayer(x, o).
otherPlayer(o, x).

/*--- WINNING/DRAW CONDITIONS ---*/

verticalWin([H|_], Player) :- sublist([Player, Player, Player, Player], H), !.
verticalWin([_|T], Player) :- verticalWin(T, Player).

horizontalWin(Board, Player, N) :- maplist(nthElem(N), Board, L), sublist([Player,Player,Player,Player], L),!.
horizontalWin(Board, Player, N) :- N > 0, N1 is N-1, horizontalWin(Board, Player, N1).
horizontalWin(Board, Player) :- horizontalWin(Board, Player, 6).

gameOver(Board, Player) :- verticalWin(Board, Player).
gameOver(Board, Player) :- horizontalWin(Board, Player).

/*--- UTILITIES ---*/

sublist(SL, L):- append(SL,_,L).
sublist(SL,[_|T]):- sublist(SL, T).

pushBack(X, [], [X]).
pushBack(X, [Y|L1], [Y|L2]):- pushBack(X, L1, L2).

nthElem(N, L, []) :- length(L, N1), N1 < N.
nthElem(N, L, X) :- nth1(N, L, X).

/*--- DISPLAY ---*/

displayElement([]) :- write(' '), !.
displayElement(E) :- write(E).

displayListe([]) :- write('|').

displayListe([E|L]) :-  
	write('|'), 
	displayElement(E),
	displayListe(L).

displayBoard(_,0).

displayBoard(Board, N) :-	 
	N > 0,
	N1 is N-1,
	maplist(nthElem(N), Board, L),
	displayListe(L),
	nl,
	displayBoard(Board, N1).

displayBoard(Board) :- 
	displayBoard(Board, 6),  
	write(' ¯ ¯ ¯ ¯ ¯ ¯ ¯'),
	nl,
	write(' 1 2 3 4 5 6 7').

displayWinner(Board, Player) :- 
	displayBoard(Board), 
	nl, nl, 
	write('Player '), 
	write(Player), 
	write(' win the game !').
