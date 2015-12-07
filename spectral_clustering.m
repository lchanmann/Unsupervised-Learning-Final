function Q = spectral_clustering( D, W, m )
%SPECTRAL_CLUSTERING perform Scott Longuet Higgins clustering
%

W_tilde = D^-0.5 * W * D^-0.5;

% eigen decomposition
[U, A] = eig(W_tilde);

% re-arrange eigenvalues and eigenvectors in decending order
[A, I] = sort( diag(A), 'descend');
U = U(:, I);

% construct V matrix with m vectors from U
V = U(:, 1:m);

% normalization
[N, ~] = size(V);
V_tilde = zeros(N, m);
for i=1:N
    V_tilde(i, :) = V(i,:) ./ norm(V(i,:));
end

% bond orders matrix Q
Q = V_tilde * V_tilde';
