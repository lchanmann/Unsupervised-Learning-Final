startup

% load data
load('d.mat');

% number of clusters
m = 103;

%% Hierachical clustering
% number of unique words
w = 103;
% number of speakers
s = 10;
 
Z = linkage(d, 'weighted');
figure;
dendrogram(Z);

T = cluster(Z, 'maxclust', 2);
S2 = reshape(T, w, s)

% c = cophenet(Z,d)
% I = inconsistent(Z)

%% Spectral clustering
epsilon = 180;
sigma2 = 625;

y = spectral(d, epsilon, sigma2)
% quantize y's components using k-means
% [I, M, D] = k_means(y, 10);
% 
% reshape(I, 103, 10)