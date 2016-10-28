domains

file = f
list = char*

predicates

nondeterm upper_file(string)
nondeterm check(list,char)
nondeterm contains(list,char)
nondeterm first(list)

clauses
contains([X|_],X).
contains([_|T],X):-
  contains(T,X).

first(L):-
          not(eof(f)),!, 
          readchar(S), 
          check(L,S).
first(_):-
          closefile(f). 
          
check(L,S):-
  not(contains(L,S)),
  !,
  write(S),
  first([S|L]).
check(L,_):-
  first(L).

upper_file(N_F):-
          existfile(N_F),!, 
          openread(f,N_F), 
          readdevice(f), 
          first([]),nl. 
upper_file(_):-
          write("no such file").
goal
readln(X),
upper_file(X).