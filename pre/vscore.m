function V = vscore( X )
%VSCORE - compute column-wise unit variance score
%

[n, ~] = size(X);
% variance
vs = var(X);
V = X ./ (ones(n, 1) * vs);
