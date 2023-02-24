% Code for an Expert System Shell: 
 
% See Bratko pages 353-356. 
%  
% The code below is for the expert system shell. This is the shell that you need to use 
% to write your own expert system; that is, your task will be to write the rules 
% which use the shell. Get the shell running in Prolog and test using Bratko’s 
% examples. 
% 
% Interaction with user and why and how explanation 
 
% Operators for easy to read rules. 
 
:-  op( 800, fx, if). 
:-  op( 700, xfx, then). 
:-  op( 300, xfy, or). 
:-  op( 200, xfy, and). 
:-  op( 800, xfx, <=). 
 
%%%% 
% Adam Wyner 
% Added the dynamic fact predicate as there were otherwise errors. 
% p. 351 in Bratko book. 
 
:- dynamic( fact/1). 
 
% is_true( P, Proof): Proof is a proof that P is true 
 
is_true( P, Proof)  :- 
   explore( P, Proof, []). 
 
%  explore( P, Proof, Trace): 
%     Proof is an explanation for P, Trace is a chain of rules between Ps ancestor goals 
 
explore( P, P, _)  :- 
   fact( P).            %  P is a fact 
 
explore( P1 and P2, Proof1 and Proof2, Trace)  :-  !, 
   explore( P1, Proof1, Trace), 
   explore( P2, Proof2, Trace). 
 
explore( P1 or P2, Proof, Trace)  :-  !, 
   ( 
      explore( P1, Proof, Trace) 
      ; 
      explore( P2, Proof, Trace) 
   ). 
 
explore( P, P <= CondProof, Trace)  :- 
   if Cond then P,          %  A rule relevant to P  
   explore( Cond, CondProof, [ if Cond then P | Trace]). 
 
explore( P, Proof, Trace)  :- 
   askable( P),            % P may be asked of user 
   \+ fact( P),            % P not already known fact 
   \+ already_asked( P),                % P not yet asked of user 
   ask_user( P, Proof, Trace). 
 
ask_user( P, Proof, Trace)  :- 
   nl, write( 'Is it true:'), write( P), write(?), nl, write( 'Please answer yes, no, or why'), nl, 
   read( Answer), 
   process_answer( Answer, P, Proof, Trace).   % Process users answer 
    
process_answer( yes, P, P  <= was_told, _)  :-  % User told P is true 
   asserta( fact(P)), 
   asserta( already_asked( P)). 
 
process_answer( no, P, _, _)  :- 
   asserta( already_asked( P)),       % Make sure not to ask again about P 
   fail.                        % User told P is not true 
 
process_answer( why, P, Proof, Trace)  :-    % User requested why-explanation 
   display_rule_chain( Trace, 0), nl, 
   ask_user( P, Proof, Trace).        % Ask about P again 
    
display_rule_chain( [], _). 
 
display_rule_chain( [if C then P | Rules], Indent)  :- 
   nl, write( 'To explore whether '), write( P), write(' is true, using rule:'),  
   nl, write( if C then P), 
   NextIndent is Indent + 2, 
   display_rule_chain(  Rules, NextIndent). 
 
:- dynamic(already_asked/1). 
 
 % --------------------------------------------------------------------------------

% Rule 1: You are healthy if you have self-isolated for two weeks and you have had no symptoms for two weeks.
is_true(you_are_healthy, Proof) :-
   explore(you_have_self_isolated_for_two_weeks and you_have_had_no_symptoms_for_two_weeks, Proof, []).

% Rule 2: You may be infected if you went to a large party and a person at the party tested positive.
is_true(you_may_be_infected, Proof) :-
   explore(you_went_to_a_large_party and a_person_at_the_party_tested_positive, Proof, []).

% Rule 3: You may not be immune if you are not vaccinated or you have not previously been ill with coronavirus.
is_true(you_may_not_be_immune, Proof) :-
   explore(you_are_not_vaccinated or you_have_not_previously_been_ill_with_coronavirus, Proof, []).

% Rule 4: You should get tested if you may be infected and you may not be immune and you have symptoms.
is_true(you_should_get_tested, Proof) :-
   explore(you_may_be_infected and you_may_not_be_immune and you_have_symptoms, Proof, []).

% Rule 1: You are healthy if you have self-isolated for two weeks and you have had no symptoms for two weeks.
healthy :-
  self_isolated,
  no_symptoms.

% Rule 2: You may be infected if you went to a large party and a person at the party tested positive.
infected :-
  went_to_party,
  person_tested_positive.

% Rule 3: You may not be immune if you are not vaccinated or you have not previously been ill with coronavirus.
not_immune :-
  not(vaccinated);
  not(previously_ill_with_coronavirus).

% Rule 4: You should get tested if you may be infected and you may not be immune and you have symptoms.
should_get_tested :-
  infected,
  not_immune,
  symptoms.

% Askables
askable(self_isolated).
askable(no_symptoms).
askable(went_to_party).
askable(person_tested_positive).
askable(vaccinated).
askable(previously_ill_with_coronavirus).
askable(symptoms).


% Negation-as-failure cannot be used in this context because of the closed-world assumption in Prolog.
% In Prolog, if something is not known to be true, it is assumed to be false. So, if we have a rule that 
% says "You are not infected if you did not go to a large party and a person at the party tested positive,"
% Prolog would assume that you are not infected if it does not know whether you went to the party or not, 
% which is not necessarily true. To avoid this problem, we need to include negated expressions in the Prolog 
% predicates explicitly.