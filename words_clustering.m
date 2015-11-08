clc;
clear all;
close all;

% load data
load('MFCCs');

% generate distance matrix
N = 21*4;% length(MFCCs);

tic;
disp('Computing pairwise distance...');
D = pdist( MFCCs(1:N), dtw.new );
Z = linkage(D, 'single');
c = cluster(Z, 'maxclust', 21)
dendrogram(Z);
toc
