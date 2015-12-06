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

%% k-medoids clustering
P = squareform(d);

[T, Theta, distortion] = k_medoids(P, m);
Sk = reshape(T, w, s)

% normailized mutual information
nmi = mutual_information(Y, T', 'normalized');
fprintf('Normalized mutual information = %0.5f\n', nmi);

% plot medoids distortion
figure;
plot(distortion);
xlabel('Medoid swaping iterations');
title(['K-Medoids clustering distortion (NMI = ' num2str(nmi) ')']);

%% fuzzy k-means clustering (medoid-based)
P = squareform(d);
[N, ~] = size(P);

% initialize  sequences
% Theta = randperm(N, m);
Theta = [131,71,813,453,58,222,451,29,773,97,262,648,656,148,302,401,322,624,702,791,631,664,159,828,652,774,200,266,700,769,809,770,567,214,726,873,754,514,283,675,406,695,41,808,394,503,840,593,485,839,377,210,517,12,796,571,881,151,697,586,298,676,307,62,411,221,78,146,452,494,577,113,910,156,510,668,187,2,500,8,416,590,256,836,155,659,658,328,27,63,255,147,218,903,722,495,227,498,309,677,847,119,681];

% fuzzyfier
q = 1.5;

[Theta, distortion] = fuzzy_c_mean(P, Theta, q);
plot(distortion);
% I = fcm_cluster_assignment(X, Theta);

%% Spectral clustering
epsilon = 180;
sigma2 = 625;

y = spectral(d, epsilon, sigma2);

% quantize y's components and repeat until the number of desired clusters
% is reached
Sc = reshape(y > median(y), w, s)
fprintf('%d out of %d y''s > median\n', sum(y > median(y)), length(y));

