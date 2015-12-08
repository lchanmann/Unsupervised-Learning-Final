function [d, Y] = generate_d_by_word( index )
%GENERATE_D_BY_WORD 
%

% load data
load('MFCCs');

% number of word
w = 103;
% number of speaker
ss = 10;

mfccs = [];
Y = [];
for i=1:ss
    selected = (i-1)*w + index;
    mfccs = [mfccs; MFCCs(selected)];
    Y = [Y labels{selected, 2}];
end
N = length(mfccs);

% use 1 and 2 as gender
Y(Y=='f') = 1;
Y(Y=='m') = 2;
Y = Y+0;

K = ss*(ss+1)/2 - 10;
d = zeros(1, K);
k = 1;

fprintf('Generating distance...');
tic;
for i=1:N
    s = mfccs{i}(1:13);
    for j=i+1:N
        t = mfccs{j}(1:13);
        d(k) = dtw_c(s, t, w);
        k = k + 1;
        progress(k, K);
    end
end
toc
