byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(losAngeles,auckland).

directTrain(saarbruecken,dudweiler).
directTrain(forbach,saarbruecken).
directTrain(freyming,forbach).
directTrain(stAvold,freyming).
directTrain(fahlquemont,stAvold).
directTrain(metz,fahlquemont).
directTrain(nancy,metz).


% Part 1 - travel/2

travel(A,B) :-
    byCar(A,B).
travel(A,B) :-
    byTrain(A,B).
travel(A,B) :-
    byPlane(A,B).
travel(A,B) :-
    byCar(A,C),
    travel(C,B).
travel(A,B) :-
    byTrain(A,C),
    travel(C,B).
travel(A,B) :-
    byPlane(A,C),
    travel(C,B).


% Part 2 - travel/3

travel(A,B,go(A,B)) :- byCar(A,B).
travel(A,B,go(A,B)) :- byTrain(A,B).
travel(A,B,go(A,B)) :- byPlane(A,B).

travel(A,B,go(A,C,Path)) :-
    byCar(A,C),
    travel(C,B,Path).

travel(A,B,go(A,C,Path)) :-
    byTrain(A,C), 
    travel(C,B,Path).

travel(A,B,go(A,C,Path)) :-
    byPlane(A,C),
    travel(C,B,Path).


% if theres a direct connection from A to B, 
% can just take that path and go directly from A to B.

% if theres no direct connection between A and B, but a connection between A and C, 
% then can get from A to B by going from A to C using the same method recursively, 
% then connecting from C to B. Keep doing this until a path is found from A to B.

% Part 3 - trainConnection/2

trainConnection(A,B) :- directTrain(A,B).
trainConnection(A,B) :- directTrain(B,A).


% Part 3 - route/3

route(X, Y, Route) :- route(X, Y, [X], Route).

route(X, X, Vis, Route) :- reverse(Vis, Route).
route(X, Y, Vis, Route) :-
    trainConnection(X, Z),
    \+ member(Z, Vis),
    route(Z, Y, [Z|Vis], Route).


% route takes in two places, X and Y, and a list of places called Route,
% that shows the path you need to take to get from X to Y

% to find route, uses other rules of route. This searches for a path between 
% X and Y using recursion, keeping track of the places visited in a list called Vis

% first rule says that if X and Y are the same, then route is found, and returns 
% the reversed list of Vis as the route

% second rule checks if theres a direct train connection between X and some other place Z, 
% and that Z is not a member of Vis list. If both of these are true, route called recursively, 
% with Z as the new starting location and Z added to the start of the Vis list

% continues until the function either finds a path from X to Y, so rule 1 succeeds
% or checks all possible paths without finding a route, and rule 2 fails