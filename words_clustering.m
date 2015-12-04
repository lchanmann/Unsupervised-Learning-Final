startup

% load data
load('d.mat');

% number of unique words
w = 103;
% number of speakers
s = 10;

% number of clusters
m = 103;

%% Hierachical clustering
Z = linkage(d, 'weighted');
figure;
dendrogram(Z);

T = cluster(Z, 'maxclust', m);
S = reshape(T, w, s)

% compute normailized mutual information
Y = [];
for i=1:s
    Y = [Y 1:103];
end
nmi = mutual_information(Y, T', 'normalized');
fprintf('Normalized mutual information = %0.5f\n', nmi);

% Cophenet correlation coefficients
[cpcc, Pc] = cophenet(Z, d);
fprintf('Cophenet correlation coefficients = %0.5f\n%', cpcc);

%% Spectral clustering
epsilon = 180;
sigma2 = 625;

y = spectral(d, epsilon, sigma2);

% quantize y's components and repeat until the number of desired clusters
% is reached
Sc = reshape(y > median(y), w, s)
fprintf('%d out of %d y''s > median\n', sum(y > median(y)), length(y));


%% fuzzy c-mean clustering
Theta = rand(l, m);
q = 2;

[Theta, distortion] = fuzzy_c_mean(X, Theta, q);
I = fcm_cluster_assignment(X, Theta);