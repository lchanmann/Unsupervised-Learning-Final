startup

% load data
load('d.mat');

% number of clusters
m = 103;

% number of unique words
w = 103;
% number of speakers
s = 10;

Z = linkage(d, 'weighted')
T = cluster(Z, 'maxclust', m);

S = reshape(T, w, s)

% c = cophenet(Z,d)
% I = inconsistent(Z)

figure;
dendrogram(Z);