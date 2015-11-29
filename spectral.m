function [y,e] = spectral( X, epsilon, sigma_squared )
%Performs spectral clustering using minimum distance (epsilon)
%and a Laplacian matrix (using sigma_squared)
%to divide the data X into 2 clusters
%returns the resulting (unquantized) clusters (y)
%and the eigenvalues found (e)
d = squareform(pdist(X).^2);
G = d < epsilon;
W = G .* exp(- d ./ sigma_squared);
D = sum(W); %Since W is symmetric, dimension of sum doesn’t matter
dee = diag(1./sqrt(D));
L = diag(D) - W;
L_tilde = dee * L * dee;
[z,lambda] = eig(L_tilde);
[e,I] = sort(diag(lambda),'ascend');
y = dee * z(:,I(2));
end

