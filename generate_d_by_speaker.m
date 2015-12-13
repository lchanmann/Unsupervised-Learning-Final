function [d, Y] = generate_d_by_speaker( S )
%GENERATE_D_BY_SPEAKER 
%

S = unique(S);
S(S<1) = [];
S(S>10) = [];

n = length(S);
if n == 0
    error('You must specify at least one speaker from 1 to 10');
end

% load mfcc
load('MFCCs.mat');

% number of unique words
w = 103;

K = w*n*(w*n+1)/2 - w*n;
d = zeros(1, K);
k = 1;

mfccs = [];
Y = [];
for c=1:n
    from = (S(c)-1) * w + 1;
    to = from + w - 1;

    mfccs = [mfccs; MFCCs(from:to)];
    % extract labels
    Y = [Y cell2mat(labels(from:to, 2))'];
end
% use 1 and 2 as gender
Y(Y=='f') = 1;
Y(Y=='m') = 2;
Y = Y+0;

fprintf('Generating distance...');
tic;
N = length(mfccs);
for i=1:N
    s = mfccs{i};
    for j=i+1:N
        t = mfccs{j};
        d(k) = dtw_c(s, t, w);
        k = k + 1;
        progress(k, K);
    end
end
toc