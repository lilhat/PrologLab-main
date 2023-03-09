s(s(NP, VP)) --> np(NP, Num, Person, subject, Anim), vp(VP, Num, Person, object, Anim).

np(np(Det, N), Num, _, _, Anim) --> det(Det, Num), nbar(N, Num, Anim).
np(np(Pro), Num, Person, Role, Anim) --> pro(Pro, Num, Person, Role, Anim).
np(np(Det, Adj, N), Num, _, _, Anim) --> det(Det, Num), jp(Adj, Num), nbar(N, Num, Anim).
np(np(Det, N, PP), Num, _, _, Anim) --> det(Det, Num), nbar(N, Num, Anim), pp(PP).

nbar(nbar(JP, NBar), Num, Anim) --> jp(JP, Num), nbar(NBar, Num, Anim).
nbar(nbar(JP, NBar), Num, Anim) --> jp(JP, Num), nbar(NBar, Num, Anim).
nbar(n(N), Num, Anim) --> n(N, Num, Anim).
nbar(np(NP, Num, Anim)) --> np(NP, Num, _, Anim).

jp(jp(Adj), Num) --> adj(Adj, Num).
jp(jp(Adj, JP), Num) --> adj(Adj, Num), jp(JP, Num).

vp(vp(V, NP), Num, Person, Role, Anim) --> v(V, Num, Person, Anim), np(NP, _, _, Role, _).
vp(vp(V), Num, Person, _, Anim) --> iv(V, Num, Person, Anim).
vp(vp(V, NP, PP), Num, Person, _, Anim) --> v(V, Num, Person, Anim), np(NP, _, _, _, Anim), pp(PP).

pp(pp(P, NP)) --> prep(P), np(NP, _, _, _, _).

det(det(Word), Num) --> [Word], {lex(Word, det, Num)}.

pro(pro(Word), Num, Person, Role, Anim) --> [Word], {lex(Word, pro, Num, Person, Role, Anim)}.

n(n(Word), Num, Anim) --> [Word], {lex(Word, n, Num, Anim)}.

iv(iv(Word), Num, Person, Anim) --> [Word], {lex(Word, iv, Num, Person, Anim)}.

v(v(Word), Num, Person, Anim) --> [Word], {lex(Word, tv, Num, Person, Anim)}.

adj(adj(Word), _) --> [Word], {lex(Word, adj)}.

prep(prep(Word)) --> [Word], {lex(Word, prep)}.


lex(the,det,_).
lex(a,det,singular).
lex(two,det,plural).

lex(man,n,singular,animate).
lex(woman,n,singular,animate).
lex(apple,n,singular,inanimate).
lex(chair,n,singular,inanimate).
lex(room,n,singular,inanimate).
lex(men,n,plural,animate).
lex(women,n,plural,animate).
lex(apples,n,plural,inanimate).
lex(chairs,n,plural,inanimate).
lex(rooms,n,plural,inanimate).

lex(i,pro,singular,1,subject,animate).
lex(you,pro,singular,2,subject,animate).
lex(he,pro,singular,3,subject,animate).
lex(she,pro,singular,3,subject,animate).
lex(it,pro,singular,3,subject,inanimate).
lex(we,pro,plural,1,subject,animate).
lex(you,pro,plural,2,subject,animate).
lex(they,pro,plural,3,subject,animate).
lex(me,pro,singular,1,object,animate).
lex(you,pro,singular,2,object,animate).
lex(him,pro,singular,3,object,animate).
lex(her,pro,singular,3,object,animate).
lex(it,pro,singular,3,object,inanimate).
lex(us,pro,plural,1,object,animate).
lex(you,pro,plural,2,object,animate).
lex(them,pro,plural,3,object,animate).

lex(know,tv,singular,1,animate).
lex(know,tv,singular,2,animate).
lex(knows,tv,singular,3,animate).
lex(know,tv,plural,_,animate).
lex(see,tv,singular,1,animate).
lex(see,tv,singular,2,animate).
lex(sees,tv,singular,3,animate).
lex(see,tv,plural,_,animate).
lex(hire,tv,singular,1,animate).
lex(hire,tv,singular,2,animate).
lex(hires,tv,singular,3,animate).
lex(hire,tv,plural,_,animate).
lex(fall,iv,singular,1,_).
lex(fall,iv,singular,2,_).
lex(falls,iv,singular,3,_).
lex(fall,iv,plural,_,_).
lex(sleep,iv,singular,1,animate).
lex(sleep,iv,singular,2,animate).
lex(sleeps,iv,singular,3,animate).
lex(sleep,iv,plural,_,animate).

lex(old,adj).
lex(young,adj).
lex(red,adj).
lex(short,adj).
lex(tall,adj).

lex(on,prep).
lex(in,prep).
lex(under,prep).