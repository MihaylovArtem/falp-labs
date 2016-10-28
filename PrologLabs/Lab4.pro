domains
rang = integer
kindofsport = string
year = integer
country = string
teamlist = team*
team = t(teamname,teamcountry,teamresults)
teamname = string
teamcountry = string
teamresults = result*
result = r(opponent,opponentcountry,resulttype)
opponent = string
opponentcountry = string
resulttype = string

teamscount = integer
rangteam = rt(rang,teamlist)
rangteamlist = rangteam*

predicates
nondeterm competition(rang,kindofsport,year,country,teamlist)

nondeterm a(year,kindofsport,integer,rang)
nondeterm countteams(teamlist,integer)

nondeterm b(rang,year)
nondeterm findTeamsWithoutLoses(teamlist)
nondeterm checkTeamForLoses(team)

nondeterm c(teamname,rang,year)
nondeterm printAllOponentsForTeam(teamname,teamlist)

nondeterm d(year,kindofsport)

nondeterm writeTeams(teamlist)
nondeterm e(rang,country)

clauses
competition(1,"football",2014,"Russia",[t("Amur","Ukraine",[r("Zenit","Russia","win")]),t("Spartak","Russia",[r("Zenit","Russia","lose")]),t("Zenit","Russia",[r("Spartak","Russia","win"),r("Amur","Ukraine","lose")])]).
competition(4,"football",2014,"USA",[t("Dinamo","Russia",[])]).
competition(8,"football",2014,"Australia",[t("Traktor","Russia",[]), t("Ak bars","Russia",[])]).
%competition(12,"football",2014,"Russia",[]).

%A

a(X,Y,Min,Rang):-
  competition(Z,Y,X,_,L),
  countteams(L,A),
  A < Min, 
  !,
  a(X,Y,A,Z).
a(X,Y,Min,Rang):-
  write(Rang),nl.
  
countteams([],0).  
countteams([_|T],X):-
  countteams(T,X1),
  X=X1+1.
%B

b(X,Y):-
  competition(X,_,Y,_,L),
  findTeamsWithoutLoses(L).

findTeamsWithoutLoses([]):-
  true.

findTeamsWithoutLoses([t(Y,_,X)|T]):-
  checkTeamForLoses(t(Y,_,X)),
  !,
  write(Y),
  nl,
  findTeamsWithoutLoses(T).
  
findTeamsWithoutLoses([t(Y,_,X)|T]):-
  findTeamsWithoutLoses(T).
  
  
checkTeamForLoses(t(_,_,[])):-
  true.
checkTeamForLoses(t(_,_,[r(_,_,X)|T])):-
  X="lose",
  !,
  fail.
  
checkTeamForLoses(t(_,_,[r(_,_,X)|T])):-
  checkTeamForLoses(t(_,_,T)).
  
  
%C
c(X,Y,Z):-
  competition(Y,_,Z,_,L),
  printAllOponentsForTeam(X,L).
  
printAllOponentsForTeam(_,[]):-
  fail.
printAllOponentsForTeam(X,[t(Z,_,[H1|T1])|T]):-
  X = Z,
  !,
  H1=r(A,_,_),
  write(A),
  nl,
  printAllOponentsForTeam(X,[t(Z,_,T1)|T]).
printAllOponentsForTeam(X,[_|T]):-
  printAllOponentsForTeam(X,T).
  
%D   
d(X,Y):-
  competition(_,Y,X,_,_).
  
%E
writeTeams([]):-
  fail.
writeTeams([t(Z,_,_)|T]):-
  write(Z),
  nl,
  writeTeams(T).

e(X,Y):-
  competition(X,_,_,Y,L),
  writeTeams(L).
goal
% A
%a(2014, "football", 100, 100).
% B
%b(1,2014).
% C
%c("Zenit",1,2014).
% D
%d(2014,Y).
% E
e(1,"Russia").