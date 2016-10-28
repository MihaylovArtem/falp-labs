predicates
nondeterm reversedigits(integer,integer,integer)
nondeterm palindrome(integer)
clauses
reversedigits(0,Y,Y).
reversedigits(X,T,Y):-
  X>0,
  X1 = X div 10,
  X2 = X mod 10,
  T1 = T*10 + X2,
  reversedigits(X1,T1,Y). 
palindrome(X):-
  reversedigits(X,0,Y),
  X=Y.
goal
palindrome(101).