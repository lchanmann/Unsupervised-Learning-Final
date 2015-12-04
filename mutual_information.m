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