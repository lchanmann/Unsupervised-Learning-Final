startup

% import dtw C module
mex +dtw/dtw_c.c;

% load data
load('MFCCs');

% generate distance matrix
N = length(MFCCs);

% DTW window parameter
w = 50;

K = N*(N+1)/2 - N;
d = zeros(1, K);
k = 1;

tic;
fprintf('Computing pairwise distance...');
for i=1:N
    for j=i+1:N
        d(k) = dtw_c(MFCCs{i}, MFCCs{j}, w);
        k = k + 1;
        progress(k, K);
    end
end
fprintf('done!\n');
toc

save('d.mat', 'd');