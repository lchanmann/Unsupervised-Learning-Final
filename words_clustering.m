startup

% load data
load('d.mat');

% numbers of clusters (numbers of words)
m = 103;
% numbers of speakers
s = 10;

Z = linkage(d, 'weighted');
T = cluster(Z, 'maxclust', m);

T = reshape(T, m, s);

% c = cophenet(Z,d)
% I = inconsistent(Z)

figure;
dendrogram(Z);