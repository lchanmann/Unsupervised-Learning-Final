% load data
load('d.mat');

% number of unique words
w = 103;
% number of speakers
s = 10;

Z = linkage(d, 'weighted');
figure;
dendrogram(Z);

%% cluster by word (hopefully)
T_W = cluster(Z, 'maxclust', w);

S_W = reshape(T_W, w, s);

%evaluate this clustering
[word_accuracy, word_mapping] = evaluate(T_W, repmat([1:w]',s,1));
word_accuracy

%{
%Find cluster each word is being put into
C_W = mode(S_W,2);
%find how many speakers' words were put into that cluster
SC_W = sum(S_W==repmat(C_W,1,s),2);
%Compute average accuracy
average_accuracy_words = mean(SC_W/s)
%}

%%  cluster by gender (hopefully)
T_S = cluster(Z, 'maxclust', 2);

%evaluate this clustering
[gender_accuracy, gender_mapping] = evaluate(T_S, [repmat('f',w,1);repmat('f',w,1);repmat('m',w,1);repmat('m',w,1);repmat('f',w,1);repmat('m',w,1);repmat('f',w,1);repmat('m',w,1);repmat('m',w,1);repmat('f',w,1)]);
gender_accuracy

%{
%%  cluster by speaker (hopefully)
T_S = cluster(Z, 'maxclust', 2);

S_S = reshape(T_S, w, s);

%Find cluster each word is being put into
C_S = mode(S_S,1);
%find how many speakers' words were put into that cluster
SC_S = sum(S_S==repmat(C_S,m,1),1);
%Compute average accuracy
average_accuracy_speakers = mean(SC_W/m)
%}