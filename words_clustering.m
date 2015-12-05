startup

% load data
load('d.mat');

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

%% Hierachical clustering
Z = linkage(d, 'weighted');
figure;
dendrogram(Z);

T = cluster(Z, 'maxclust', m);
S = reshape(T, w, s)

% compute normailized mutual information
nmi = mutual_information(Y, T', 'normalized');
fprintf('Normalized mutual information = %0.5f\n', nmi);

% Cophenet correlation coefficients
[cpcc, Pc] = cophenet(Z, d);
fprintf('Cophenet correlation coefficients = %0.5f\n%', cpcc);

%% k-means clustering (medoid-based)
P = squareform(d);

[T, Theta, distortion] = k_means(P, m);
Sk = reshape(T, w, s)

% normailized mutual information
nmi = mutual_information(Y, T', 'normalized');
fprintf('Normalized mutual information = %0.5f\n', nmi);

%% fuzzy k-means clustering (medoid-based)
P = squareform(d);
[N, ~] = size(P);

% initialize  sequences
Theta = randperm(N, m);

% fuzzyfier
q = 2;

% [Theta, distortion] = fuzzy_c_medoid(P, Theta, q);
% I = fcm_cluster_assignment(X, Theta);

%% Spectral clustering
epsilon = 180;
sigma2 = 625;

y = spectral(d, epsilon, sigma2);

% quantize y's components and repeat until the number of desired clusters
% is reached
Sc = reshape(y > median(y), w, s)
fprintf('%d out of %d y''s > median\n', sum(y > median(y)), length(y));

