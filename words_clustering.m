startup

display('-------------------');
display('  Word clustering');
display('-------------------');

% load data
load('d13.mat');

% number of unique words
w = 103;
% number of speakers
s = 10;

% number of clusters
m = 103;

% classes for evaluation
Y = [];
for i=1:s
    Y = [Y 1:w];
end

%% Hierarchical clustering
display('Hierarchical clustering:');

Z = linkage(d, 'weighted');
figure('Name', 'Hierarchical clustering', 'NumberTitle', 'off');
dendrogram(Z);

T = cluster(Z, 'maxclust', m);
% Sh = reshape(T, w, s);

% compute normailized mutual information
nmi = mutual_information(Y, T', 'normalized');
fprintf('\t\tNormalized mutual information = %0.5f\n', nmi);
% naive count accuracy
acc = evaluate(Y, T');
fprintf('\t\tNaive count accuracy = %0.5f\n', acc);

% Cophenet correlation coefficients
[cpcc, Pc] = cophenet(Z, d);
fprintf('\t\tCophenet correlation coefficients = %0.5f\n%', cpcc);

%% k-medoids clustering
display('K-medoids:');

P = squareform(d);
[T, Theta, distortion] = k_medoids(P, m);
% Sk = reshape(T, w, s);

% normailized mutual information
nmi = mutual_information(Y, T', 'normalized');
fprintf('\tNormalized mutual information = %0.5f\n', nmi);
% naive count accuracy
acc = evaluate(Y, T');
fprintf('\tNaive count accuracy = %0.5f\n', acc);

% plot medoids distortion
figure('Name', 'K-medoids clustering', 'NumberTitle' , 'off');
plot(distortion);
xlabel('Medoid swaping iterations');
title(['K-Medoids clustering distortion (NMI = ' num2str(nmi) ')']);

%% fuzzy k-medoids clustering
display('Fuzzy K-medoids:');

P = squareform(d);
[N, ~] = size(P);

% initialize  sequences
% load('I_Theta.mat');
Theta = randperm(N, m);

% fuzzyfier
q = 1.8;

[Theta, distortion, T] = fuzzy_c_medoids(P, Theta, q);
Sf = reshape(T, w, s);

% normailized mutual information
nmi = mutual_information(Y, T', 'normalized');
fprintf('\tNormalized mutual information = %0.5f\n', nmi);
% naive count accuracy
acc = evaluate(Y, T');
fprintf('\tNaive count accuracy = %0.5f\n', acc);

figure('Name', 'Fuzzy c-medoids clustering', 'NumberTitle' , 'off');
plot(distortion);
xlabel('Iteration');
title(['Fuzzy C-Medoids clustering distortion (NMI = ' num2str(nmi) ')']);

%% Spectral clustering
%  is more sensitive to epsilon than sigma
display('Spectral clustering:');

epsilon = Inf;%8;%.16;%38; % choose according to sparseness around 10% from spectral.m
sigma2 = 24;%24;%2;%24; % try from between 1 -> 196 and pick the one that give the best NMI
fprintf('\t[epsilon, sigma2] = [%0.4f %0.4f]\n', epsilon, sigma2);

s = 1./d;
y = spectral(s, epsilon, sigma2, m);
% normalization
z = zscore(y);
% k-means clustering
[T, distortion] = k_means(z, m);
% Sk = reshape(T, w, s);

% normailized mutual information
nmi = mutual_information(Y, T', 'normalized');
fprintf('\tNormalized mutual information = %0.5f\n', nmi);
% naive count accuracy
acc = evaluate(Y, T');
fprintf('\tNaive count accuracy = %0.5f\n', acc);

% plot total distortion
figure('Name', 'Spectral clustering + K-means', 'NumberTitle' , 'off');
plot(distortion);
xlabel('Iterations');
title(['K-means distortion on Eigenmap (NMI = ' num2str(nmi) ')']);
