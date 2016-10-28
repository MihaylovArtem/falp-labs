domains
element = string
lists = element*
predicates
nondeterm plays(string,string)
nondeterm getquartet(string,string,string,string)
nondeterm isquartet(string,string,string,string)
nondeterm member(element,lists)
clauses	
plays("Marmoset","violin").
plays("Donkey","alto").
plays("Goat","cello").
plays("Bear","contrabass").
member(X,[X|_]).
member(X,[_|T]):-
   member(X,T).
getquartet(X1,X2,X3,X4):-
  plays(X1,"violin"),
  plays(X2,"alto"),
  plays(X3,"cello"),
  plays(X4,"contrabass"),
  X1<>X2,X1<>X3,X1<>X4,X2<>X3,X2<>X4,X3<>X4.
isquartet(X1,X2,X3,X4):-
  Q = ["violin","alto","cello","contrabass"],
  plays(X1,Y1),
  plays(X2,Y2),
  plays(X3,Y3),
  plays(X4,Y4),
  member(Y1,Q),
  member(Y2,Q),
  member(Y3,Q),
  member(Y4,Q),
  Y1<>Y2,Y1<>Y3,Y1<>Y4,Y2<>Y3,Y2<>Y4,Y3<>Y4.	
goal
%plays(X1,"alto").
%plays("Marmoset",X2),
isquartet("Marmoset","Donkey","Goat","Bear").
%getquartet(Y1,Y2,Y3,Y4).
