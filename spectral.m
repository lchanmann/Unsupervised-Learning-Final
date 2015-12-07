function [y, D, W] = spectral( d, epsilon, sigma_squared, m )
%SPECTRAL Performs spectral clustering using minimum distance (epsilon)
%   and a Laplacian matrix (using sigma_squared)
%   to divide the data X into 2 clusters
%
%   Returns the resulting (unquantized) clusters (y)
%   the eigenvalues (a) and their corresponding eigenvectors (Z)

P = squareform(d.^2);

% construct sparse graph G(V,E)
G = P < epsilon;

% g = G(:);
% fprintf('Sparseness of G = %0.4f\n', sum( (g==0) ) / length(g));

% compute the strength of edge e_ij
W = G .* exp(-P/sigma_squared);

% since W is symmetric, dimension of sum doesn't matter.
D = sum(W);
D_05 = diag(1./sqrt(D));

% graph Laplacian matrix
D = diag(D);
L = D - W;
% normalized L
L_tilde = D_05 * L * D_05;

% eigen decomposition
[Z, a] = eig(L_tilde);

% re-arrange a and Z
[a, I] = sort( diag(a), 'ascend');
Z = Z(:, I);

% compute y
y = D_05 * Z(:, I(end-m+1:end));
