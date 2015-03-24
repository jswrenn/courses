% Infix operators for shorthand
:- op(500, xf,∗). % Kleene Star
:- op(510,yfx,•). % Concatenation
:- op(520,yfx,∪). % Union
:- op(530,yfx,∩). % Intersection

% Notes on names:
% P     Pattern
% I     Input
% Subscripts ᵢ and ⱼ are used to differentiate two things of the same
%   type, e.g., two patterns, or two inputs.
% The subscript ᵨ denotes that the variable is an array. 

% Epsilon matches empty
regex(ε,[]).

% Primitive
regex(P,[P])
 :- atom(P).
 
% Union
regex(∪(Pᵢ,Pⱼ),Iᵨ)
 :- regex(Pᵢ,Iᵨ)
  ; regex(Pⱼ,Iᵨ).
  
% Intersection
regex(∩(Pᵢ,Pⱼ),Iᵨ)
 :- regex(Pᵢ,Iᵨ)
  , regex(Pⱼ,Iᵨ).
 
% Concatenation
regex(•(Pᵢ,Pⱼ),Iᵨ)
 :- append(Iᵢ,Iⱼ,Iᵨ)
  , regex(Pᵢ,Iᵢ)
  , regex(Pⱼ,Iⱼ).
  
% Kleene Star
regex(∗(_),[]).
regex(∗(Pᵢ),Iᵨ)
 :- append(Iᵢ,Iⱼ,Iᵨ)
  , regex(Pᵢ,Iᵢ)
  , regex(∗(Pᵢ),Iⱼ).
  
% Examples
:- regex(a•b,[a,b]).
    % True
    
:- P = (a∪b), regex(P,[a]), regex(P,[b]).
    % True
    
:- P = ((a∪b)∩(b∪c)), regex(P,[b]).
    % True.

:- regex(a∗,[]), regex(a∗,[a]), regex(a∗,[a,a]).
    % True
















