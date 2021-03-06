predicates
pow(real,integer,real)
cosinus(real,real)
sinus(real,real)
lg(real,real)
result(real,real,real)
result2(real,real,real)
clauses
pow(X,Y,X):-
  Y=1,!.
pow (X,Y,Z):-
  Y1=Y-1,
  pow(X,Y1,Z1),
  Z=Z1*X.    
cosinus(X,Y):-
  Y=cos(X).
sinus(X,Y):-
  Y=sin(X).
lg(X,Y):-
  Y=log(X).
result(X,Y,Z):-
  X1=3.8*X,
  cosinus(X1,CosX),
  Y1=6.5*Y,
  lg(Y1,LgY),
  pow(Y,6,Y6),
  XY=12*X*Y6,
  Z=CosX+LgY-XY.
result2(X,Y,Z):-
  pow(X,4,X1),
  pow(X,2,X2),
  XY=3*X2*Y,
  Z=X1-ln(14)+XY+1/9.
goal
  readreal(X),
  readreal(Y),
  result2(X,Y,Z).