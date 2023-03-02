% Part 1

% s --> foo,bar,wiggle.
% foo --> [choo].
% foo --> foo,foo.
% bar --> mar,zar.
% mar --> me,my.
% me --> [i].
% my --> [am].
% zar --> blar,car.
% blar --> [a].
% car --> [train].
% wiggle --> [toot].
% wiggle --> wiggle,wiggle. 


% s(A, D) :- foo(A, B), bar(B, C), wiggle(C, D).
% foo([choo|A], A).
% foo(A, C) :- foo(A, B), foo(B, C).
% bar(A, C) :- mar(A, B), zar(B, C).
% mar(A, C) :- me(A, B), my(B, C).
% me([i|A], A).
% my([am|A], A).
% zar(A, C) :- blar(A, B), car(B, C).
% blar([a|A], A).
% car([train|A], A).
% wiggle([toot|A], A).
% wiggle(A, C) :- wiggle(A, B), wiggle(B, C).

% ?- s(X,[]).
% X = [choo, i, am, a, train, toot] ;
% X = [choo, i, am, a, train, toot, toot] ;
% X = [choo, i, am, a, train, toot, toot, toot] ;



% Part 2

% s --> np,vp.
% np --> det,n.
% vp --> v,np.
% det --> [the].
% det --> [a].
% n --> [woman].
% n --> [man]
% v --> [hires].

% s(s(NP,VP)) --> np(NP), vp(VP). 
% np(np(Det,N)) --> det(Det), n(N).                   
% vp(vp(V,NP)) --> v(V), np(NP). 
% det(det(the)) --> [the].  
% det(det(a)) --> [a].               
% n(n(woman)) --> [woman].        
% n(n(man)) --> [man]. 
% v(v(hires)) --> [hires].

% ?- s(Tree, [a,man,hires,a,woman],[]).
% Tree = s(np(det(a), n(man)), vp(v(hires), np(det(a), n(woman)))).

% ?- s(Tree, [a,woman,hires,the,woman],[]).
% Tree = s(np(det(a), n(woman)), vp(v(hires), np(det(the), n(woman)))).



% Part 3

% s(s(NP,VP)) --> np(NP, Num), vp(VP, Num).
% np(np(Det, N), Num) --> det(Det, Num), n(N, Num).
% vp(vp(V, NP), Num) --> v(V, Num), np(NP, _).
% det(det(the), singular) --> [the].
% det(det(a), singular) --> [a].
% det(det(the), plural) --> [the].
% det(det(two), plural) --> [two].
% n(n(woman), singular) --> [woman].
% n(n(man), singular) --> [man].
% n(n(women), plural) --> [women].
% n(n(men), plural) --> [men].
% v(v(hires), singular) --> [hires].
% v(v(hire), plural) --> [hire].

% ?- s(Tree, [the,women,hire,the,man],[]).
% Tree = s(np(det(the), n(women)), vp(v(hire), np(det(the), n(man)))) .

% ?- s(Tree, [the,woman,hires,a,woman],[]).
% Tree = s(np(det(the), n(woman)), vp(v(hires), np(det(a), n(woman)))) .

% ?- s(Tree, [a,man,hires,the,women],[]).
% Tree = s(np(det(a), n(man)), vp(v(hires), np(det(the), n(women)))) .

% ?- s(Tree, [a,man,hire,the,women],[]).
% false.

% ?- s(Tree, [the,women,hires,the,men],[]).
% false.

% ?- s(Tree, [a,man,hires,the,woman],[]).
% Tree = s(np(det(a), n(man)), vp(v(hires), np(det(the), n(woman)))) .

% ?- s(Tree, [a,man,hires,the,women],[]).
% Tree = s(np(det(a), n(man)), vp(v(hires), np(det(the), n(women)))) .

% ?- s(Tree, [the,men,hire,the,woman],[]).
% Tree = s(np(det(the), n(men)), vp(v(hire), np(det(the), n(woman)))) .

% ?- s(Tree, [the,men,hire,the,women],[]).
% Tree = s(np(det(the), n(men)), vp(v(hire), np(det(the), n(women)))) .

% ?- s(Tree, [a,man,hires,the,woman],[]).
% Tree = s(np(det(a), n(man)), vp(v(hires), np(det(the), n(woman)))) .

% ?- s(Tree, [the,man,hires,the,woman],[]).
% Tree = s(np(det(the), n(man)), vp(v(hires), np(det(the), n(woman)))) .

% ?- s(Tree, [the,men,hire,the,woman],[]).
% Tree = s(np(det(the), n(men)), vp(v(hire), np(det(the), n(woman)))) .

% ?- s(Tree, [two,women,hire,a,man],[]).
% Tree = s(np(det(two), n(women)), vp(v(hire), np(det(a), n(man)))) .

% ?- s(Tree, [a,women,hire,the,man],[]).
% false.

% ?- s(Tree, [a,women,hires,the,man],[]).
% false.

% ?- s(Tree, [two,man,hires,the,man],[]).
% false.

% ?- s(Tree, [two,man,hire,the,man],[]).
% false.


% Part 4

s(s(NP, VP)) --> np(NP), vp(VP).

np(np(DET, N)) --> det(DET), n(N).

vp(vp(IV)) --> iv(IV).
vp(vp(V, NP)) --> v(V), np(NP).
vp(vp(V)) --> v(V).

det(det(Word)) --> [Word], {lex(Word, det)}.

n(n(Word)) --> [Word], {lex(Word, n)}.

iv(iv(Word)) --> [Word], {lex(Word, iv)}.

v(v(Word), NP) --> [Word], np(NP), {lex(Word, v)}.
v(v(Word)) --> [Word], {lex(Word, v)}.

lex(two, det).
lex(the, det).
lex(a, det).
lex(woman, n).
lex(women, n).
lex(man, n).
lex(men, n).
lex(hire, v).
lex(hires, v).
lex(fall, iv).
lex(falls, iv).
