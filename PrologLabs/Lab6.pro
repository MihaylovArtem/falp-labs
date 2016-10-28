domains
i = integer
l = i*
predicates 
nondeterm sum(l,i)
clauses
sum([],0).
sum([H],0).
sum([H,H1|T],S):-
   sum(T,S_T),
   S=S_T+H1.
goal
sum([1,2,3,4,5,10],S).