clc;
clear all;
close all;

% load data
load('MFCCs');

% generate distance matrix
N = 6;% length(MFCCs);
w = 30;
p = 1;

% compare pdist and manually computed matrix
d = pdist( MFCCs(1:N), dtw.new(w, p) );
D = squareform(d)

K = N*(N+1)/2 - N;
dk = zeros(1, K);
k = 1;
for i=1:N
    for j=i:N
        if i ~= j
            dk(k) = dtw.base(MFCCs{i}, MFCCs{j}, w, p);
            k = k + 1;
        end
    end
end
Dk = squareform(dk)

% tic;
% disp('Computing pairwise distance...');
% d = pdist( MFCCs(1:N), dtw.new(w, p) );
% Z = linkage(d, 'weighted');
% c = cluster(Z, 'maxclust', 21);
% 
% figure;
% dendrogram(Z);
% toc
