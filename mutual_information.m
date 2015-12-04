function mi = mutual_information( Y, C, normalized )
%MUTUAL_INFORMATION compute mutual information of clustering C comparing to
% truth class Y
%

    [P_ij, P_j, P_i] = probabilities(Y, C);
    [n, m] = size(P_ij);

    Pr = P_ij ./ (P_i*ones(1, m)) ./ (P_j*ones(1, n))';
    Pr(Pr==0) = 1;

    mi = sum( sum(P_ij .* log2(Pr)) );

    % normalized mutual information
    if (nargin == 3) && strcmpi(normalized, 'normalized')
        mi = mi / sqrt(entropy(P_i) * entropy(P_j));
    end
end

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

    if length(Y) ~= length(C)
        error('Y and C must be the same length.');
    end

    n = length(Y);
    I = unique(Y);
    l = length(I);
    J = unique(C);
    k = length(J);

    Ci = zeros(l, n);
    Cj = zeros(k, n);
    for i=1:l
        Ci(i,:) = Y == I(i);
    end
    for j=1:k
        Cj(j,:) = C == J(j);
    end

    Pi = sum(Ci, 2)/n;
    Pj = sum(Cj, 2)/n;

    Pij = zeros(l, k);
    for i=1:l
        for j=1:k
            Pij(i,j) = sum(Ci(i,:) .* Cj(j,:))/n;
        end
    end
end