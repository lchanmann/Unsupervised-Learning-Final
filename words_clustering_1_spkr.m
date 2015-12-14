startup

% number of unique words
w = 103;

% number of clusters vary
m = 103;

% classes for evaluation
Y = 1:w;

%% Hierachical clustering

for i=1:10
    % load data
    load(['d_' num2str(i) '.mat']);
    header = sprintf('Speaker %d:', i);

    Z = linkage(d, 'weighted');
    
    figure('Name', header, 'NumberTitle' , 'off');
    dendrogram(Z, w);
    title(header);

    T = cluster(Z, 'maxclust', m);

    fprintf('%s\n', header);
    % Cophenet correlation coefficients
    [cpcc, Pc] = cophenet(Z, d);
    fprintf('\tCophenet correlation coefficients = %0.5f\n%', cpcc);
end
