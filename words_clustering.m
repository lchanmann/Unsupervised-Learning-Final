clc;
clear all;
close all;

% load data
load('MFCCs');

% generate distance matrix
N = length(MFCCs);
% numbers of clusters
m = 21;
% DTW parameters
w = 30;
p = 1;

K = N*(N+1)/2 - N;
d = zeros(1, K);
k = 1;
tic;
fprintf('Computing pairwise distance');
for i=1:N
    for j=i:N
        if i ~= j
            d(k) = dtw.base(MFCCs{i}, MFCCs{j}, w, p);
            k = k + 1;
            progress(k, K);
        end
    end
end
fprintf('\nDone: ');
toc

Z = linkage(d, 'weighted');
c = cluster(Z, 'maxclust', m);

l = N/m;
C = reshape(C, m, l)

figure;
dendrogram(Z);

% % compare pdist and manually computed matrix
% d = pdist( MFCCs(1:N), dtw.new(w, p) );
% D = squareform(d)
% 
% K = N*(N+1)/2 - N;
% dk = zeros(1, K);
% k = 1;
% for i=1:N
%     for j=i:N
%         if i ~= j
%             dk(k) = dtw.base(MFCCs{i}, MFCCs{j}, w, p);
%             k = k + 1;
%         end
%     end
% end
% Dk = squareform(dk)

% tic;
% disp('Computing pairwise distance...');
% d = pdist( MFCCs(1:N), dtw.new(w, p) );
% Z = linkage(d, 'weighted');
% c = cluster(Z, 'maxclust', 21);
% 
% figure;
% dendrogram(Z);
% toc
