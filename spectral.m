function [y, a, Z] = spectral( d, epsilon, sigma_squared )
%SPECTRAL Performs spectral clustering using minimum distance (epsilon)
%   and a Laplacian matrix (using sigma_squared)
%   to divide the data X into 2 clusters
%
%   Returns the resulting (unquantized) clusters (y)
%   the eigenvalues (a) and their corresponding eigenvectors (Z)

P = squareform(d.^2);

% construct sparse graph G(V,E)
G = P < epsilon;

% compute the strength of edge e_ij
W = G .* exp(-P/sigma_squared);

% since W is symmetric, dimension of sum doesn't matter.
D = sum(W);
D_05 = diag(1./sqrt(D));

% graph Laplacian matrix
L = diag(D) - W;
% normalized L
L_tilde = D_05 * L * D_05;

% eigen decomposition
[Z, a] = eig(L_tilde);

% re-arrange a and Z
[a, I] = sort( diag(a), 'ascend');
Z = Z(:, I);

% compute y
y = D_05 * Z(:, I(2:3));
