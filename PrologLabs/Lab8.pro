domains
name = string
pweight, fweight, cweight = integer
ene = integer
comp = string
components = comp*
price = integer
dish = d(name,pweight,fweight,cweight,ene,components,price)
database 
dishes(dish)

predicates
nondeterm addDishes
nondeterm member(comp, components)

nondeterm dishesByComponents(components)
nondeterm dishesWithEneLessThan1000
nondeterm dishesWithPotato

nondeterm printDishIfNeeded(name,comp,comp,comp,components)
nondeterm printDishIfNeeded2(name,pweight,fweight,cweight,ene)
nondeterm printDishIfNeeded3(name,price,components)

clauses
addDishes:-
  assert(dishes(d("Borsh",1,1,1,10000,["onion","potato","water"],100))),
  assert(dishes(d("Olivie",5,0,0,100,["sausage","potato","mayo"],50))),
  assert(dishes(d("Meat",0,10,100,500,["meat","tomates","mayo"],100))).

member(X,[X|_]).
member(X,[_|T]):-
  member(X,T).

dishesByComponents(L):-
  dishes(d(X,_,_,_,_,[A,B,C],_)),
  printDishIfNeeded(X,A,B,C,L),
  fail.
  
printDishIfNeeded(X,A,B,C,L):-
  member(A,L) and member(B,L) and member(C,L),
  !,
  write(X),nl.

dishesWithEneLessThan1000:-
  dishes(d(X,A,B,C,D,_,_)),
  printDishIfNeeded2(X,A,B,C,D),
  fail.
  
printDishIfNeeded2(X,A,B,C,D):-
  D<1000,
  !,
  write(X),
  write(" "),
  write(A),
  write(" "),
  write(B),
  write(" "),
  write(C),
  nl.
  
dishesWithPotato:-
  dishes(d(X,_,_,_,_,L,Y)),
  printDishIfNeeded3(X,Y,L),
  fail.
  
printDishIfNeeded3(X,Y,L):-
  member("potato",L),
  !,
  write(X),
  write(" "),
  write(Y),
  nl.

goal
addDishes,
%dishesByComponents(["onion","potato","water","meat","tomates","mayo"]).
%dishesWithEneLessThan1000.
dishesWithPotato.