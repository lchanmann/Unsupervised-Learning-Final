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
