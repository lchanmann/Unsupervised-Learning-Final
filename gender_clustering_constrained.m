startup

% number of unique words
w = 103;
% speakers
male = [3 4 6 8 9];
female = [1 2 5 7 10];

% number of clusters
m = 2;

% figure; hold on;
% colors = 'brkgm';
for s=1:5
    % load data
    load(['dY_' num2str(s) '.mat']);
%     [d, Y]= generate_d_by_speaker([male(s) female(s)]);
%     P = squareform(d);
    
    fprintf('Speaker pair = [%d, %d]\n', female(s), male(s));

    % %% Hierachical clustering
    display('Hierachical clustering:');
    Z = linkage(d, 'weighted');
    figure;
    dendrogram(Z);
    
    T = cluster(Z, 'maxclust', m);
    Sh = reshape(T, w, m);
    
    % compute normailized mutual information
    nmi = mutual_information(Y, T', 'normalized');
    fprintf('\tNormalized mutual information = %0.5f\n', nmi);
    % naive count accuracy
    acc = evaluate(Y, T');
    fprintf('\tNaive count accuracy = %0.5f\n', acc);
    
    % Cophenet correlation coefficients
    [cpcc, Pc] = cophenet(Z, d);
    fprintf('\tCophenet correlation coefficients = %0.5f\n%', cpcc);

%     % %% k-medoids clustering
%     display('K-Medoids clustering:');
%     [T, Theta, distortion] = k_medoids(P, m);
%     % Sk = reshape(T, w, m);
% 
%     % normailized mutual information
%     nmi = mutual_information(Y, T', 'normalized');
%     fprintf('\tNormalized mutual information = %0.5f\n', nmi);
%     % naive count accuracy
%     acc = evaluate(Y, T');
%     fprintf('\tNaive count accuracy = %0.5f\n', acc);
% 
%     % plot medoids distortion
%     figure;
%     plot(distortion);
%     xlabel('Medoid swaping iterations');
%     title(['K-Medoids clustering distortion (NMI = ' num2str(nmi) ')']);

%     % %% fuzzy c-medoids clustering
%     display('Fuzzy C-Medoids clustering:');
%     [N, ~] = size(P);
%     
%     % initialize  sequences
%     Theta = randperm(N, m);
%     
%     % fuzzyfier
%     q = 1.5;
%     
%     [Theta, distortion, T] = fuzzy_c_medoids(P, Theta, q);
%     Sf = reshape(T, w, m);
%     
%     % normailized mutual information
%     nmi = mutual_information(Y, T', 'normalized');
%     fprintf('\tNormalized mutual information = %0.5f\n', nmi);
%     % naive count accuracy
%     acc = evaluate(Y, T');
%     fprintf('\tNaive count accuracy = %0.5f\n', acc);
%     
%     figure;
%     plot(distortion);
%     xlabel('Iteration');
%     title(['Fuzzy C-Medoids clustering distortion (NMI = ' num2str(nmi) ')']);
    
%     % %% Spectral clustering
%     %  is more sensitive to epsilon than sigma
%     epsilon = 19; % choose according to sparseness=10% from spectral.m
%     sigma2 = 5; % try from between 1 -> 196
%     
%     y = spectral(d, epsilon, sigma2, m);
%     % normalization
%     z = zscore(y);
%     % k-means clustering
%     [T, distortion] = k_means(z, m);
%     Sk = reshape(T, w, m);
%     
%     % normailized mutual information
%     nmi = mutual_information(Y, T', 'normalized');
%     fprintf('\tNormalized mutual information = %0.5f\n', nmi);
%     % naive count accuracy
%     acc = evaluate(Y, T');
%     fprintf('\tNaive count accuracy = %0.5f\n', acc);
%     
%     % plot total distortion
%     plot(distortion, colors(s));
%     xlabel('Iterations');
%     title(['K-means distortion on Eigenmaps (NMI = ' num2str(nmi) ')']);
end