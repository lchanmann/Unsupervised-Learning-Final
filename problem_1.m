% load data
X = load('Circles.dat');

% design parameters
sigma2 = 2;
e = 1.5;

% construct sparse graph and W
[~, N] = size(X);
% strength of edges(e_ij)
W = zeros(N,N);
for i=1:N
    for j=i:N
        d = (X(:,i)-X(:,j))' * (X(:,i)-X(:,j));
        if d < e
            W(i,j) = exp(-d/sigma2);
        end
    end
end
W = W + triu(W, 1)';
% significance of the vertice
D = diag( sum(W) );
% graph Laplacian matrix
L = D - W;
% normalized L
L_tilde = D^-0.5 * L * D^-0.5;

% eigen decomposition
[V, A] = eig(L_tilde);
a = sort( diag(A) );

% compute y
y = D^-0.5 * V(:,2);
I = y < median(y);
C1 = X(:,I==1);
C2 = X(:,I==0);

% plot
figure, hold on;
scatter(C1(1,:), C1(2,:));
scatter(C2(1,:), C2(2,:), 'filled', 'g');
title('Spectral clustering on Circle.dat');

% print smallest 5 eigenvalues
display('The smallest 5 eigenvalues =');
display(' ');
fprintf('\t %0.4f \n', a(1:5));