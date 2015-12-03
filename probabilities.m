function [ Pij, Pj, Pi, I ] = probabilities( Y, C )
%PROBABILITIES compute probabilities that
%      x is assigned to cluster j and it belongs to class i = Pij
%      x belongs to class i = Pi
%      x is assigned to cluster j = Pj
%
%   Y - classes in row vector of size n
%   C - clusterings in row vector of size n
%
% Assume that Y and C have the same possible values

n = length(Y);
I = unique(Y);
l = length(I);

Ci = zeros(l, n);
Cj = zeros(l, n);
for i=1:l
    Ci(i,:) = Y == I(i);
    Cj(i,:) = C == I(i);
end
Pi = sum(Ci,2)/n;
Pj = sum(Cj,2)/n;

Pij = zeros(l,l);
for i=1:l
    for j=1:l
        Pij(i,j) = sum(Ci(i,:) .* Cj(j,:))/n;
    end
end