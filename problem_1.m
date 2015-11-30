% load data
X = load('Circles.dat');

% design parameters
sigma2 = 2;
e = 1.5;

[y, a] = spectral(pdist(X), e, sigma2);
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