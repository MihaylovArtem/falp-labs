domains
s = string
c = char
i=integer
li = i*

database - eras
rule(s,li)
cond(i,s)

database - answers
cond_is(integer,char)

predicates
nondeterm start
nondeterm update
nondeterm read_true_char(c)
nondeterm test(c,c)
nondeterm check(li)
nondeterm guessEra
nondeterm test_cond(i) 
nondeterm add_cond(li) 
nondeterm print_cond(i,li,li) 
nondeterm read_cond(c,li,li) 
nondeterm ex_cond(i,li,li,i) 
nondeterm wr_cond(c,i,li,li)
nondeterm new_cond(i,li,li) 

clauses

start:-
  consult("eras.ddb",eras),
  write("Propose an era, and I'll try to guess it!"),nl,
  guessEra,
  retractall(_,eras),
  retractall(_,answers),
  nl,nl,
  write("Wanna play again? (1 - Yes, 0 - No)"),nl,
  read_true_char(C),
  C='1',!,start.
start:-
  write("Bye-bye."),
  readchar(_).

guessEra:-
  rule(X,L),
  check(L),
  write("I think it's ",X),nl,
  write("Am I right?(0 - no, 1 - yes)"),nl,
  read_true_char(C),C='1',!.
guessEra:-
  write("I don't know what era is it"),nl,
  write("Let's add it into my database!"),nl,
  update.

check([H|T]):-
  test_cond(H),
  check(T).
check([]).

test_cond(H):-
  cond_is(H,'1'),!.
test_cond(H):-
  cond_is(H,'0'),!,fail.
test_cond(H):-
  cond(H,S),
  write("Is there ",S," in this era? (1-Yes, 0-No)"),nl,
  read_true_char(A),
  assert(cond_is(H,A)),
  test_cond(H).
  
update:-
  write("Print era name"),nl,
  readln(S),
  add_cond(L),
  assert(rule(S,L),eras),
  save("eras.ddb",eras).
  
add_cond(L):-
  cond_is(_,'1'),!,
  write("We know the following:"),nl,
  print_cond(1,[],L1),
  write("Anything else? (1 - Yes, 0 - No)"),nl,
  read_true_char(C),
  read_cond(C,L1,L).
add_cond(L):-
  read_cond('1',[],L).
  
read_cond('1',L,L2):-
  ex_cond(1,L,L1,N),
  new_cond(N,L1,L2),!.
read_cond(_,L,L):-!.

print_cond(H,L,L):-
  not(cond(H,_)),!.
print_cond(H,L,L1):-
  cond_is(H,'1'),!.
print_cond(H,L,L1):-
  cond_is(H,'1'),!,
  cond(H,T),
  H1=H+1,
  nl,write(T),
  print_cond(H1,[H|L],L1).
print_cond(H,L,L1):-
  H1=H+1,
  print_cond(H1,L,L1).
  
ex_cond(N,L,L,N):-
  not(cond(N,_)),!.
ex_cond(N,L,L1,N2):-
  cond_is(N,_),!,
  N1=N+1,
  ex_cond(N1,L,L1,N2).
ex_cond(N,L,L1,N1):-
  cond(N,S),
  write("Is there ",S,"in this era? (1 - Yes, 0 - No)"),nl,
  read_true_char(A),
  wr_cond(A,N,L,L2),
  N1=N+1,
  ex_cond(N1,L2,L1,N2).

wr_cond('1',N,L,[N|L]):-!.
wr_cond('0',_,L,L):-!.

new_cond(N,L,L1):-
  write("Anything else? (1 - Yes, 0 - No)"),nl,
  read_true_char(A),
  A='1',!,
  write("Write, what also can be in this era"),nl,
  readln(S),
  assertz(cond(N,S)),
  N1=N+1,
  new_cond(N1,[N|L],L1).

new_cond(_,L,L).
 
read_true_char(C):-
  readchar(C1),
  test(C1,C).
test(C,C):-
  '0'<=C,C<='1',!.
test(_,C):-
  write("You need to write 1 or 0!"),nl,
  readchar(C1),
  test(C1,C).
  

goal

start.
