startup

% import dtw C module
mex +dtw/dtw_c.c;

% load data
load('MFCCs');

% generate distance matrix
N = length(MFCCs);
% number of dimensions used
l = 13;

%% generate all words distances

% DTW window parameter
w = 50;

K = N*(N+1)/2 - N;
d = zeros(1, K);
k = 1;

tic;
fprintf('Computing pairwise distance...');
for i=1:N
    s = MFCCs{i}(1:13);
    for j=i+1:N
        t = MFCCs{j}(1:13);
        d(k) = dtw_c(s, t, w);
        k = k + 1;
        progress(k, K);
    end
end
fprintf('done!\n');
toc

save('d13.mat', 'd');

%% generate words distances by speaker

w = 103;
K = w*(w+1)/2 - w;
d = zeros(1, K);

for c=1:10
    d = 0;
    k = 1;
    
    from = (c-1) * w + 1;
    to = from + w - 1;
    
    mfccs = MFCCs(from:to);
    tic;
    fprintf('\nSpeaker %d. Computing pairwise distance...', c);
    for i=1:w
        s = mfccs{i}(1:13);
        for j=i+1:w
            t = mfccs{j}(1:13);
            d(k) = dtw_c(s, t, w);
            k = k + 1;
            progress(k, K);
        end
    end
    fprintf('done!\n');
    toc

    save(['d_' num2str(c) '.mat'], 'd');
end
