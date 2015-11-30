function [ I, Mu, D ] = k_means( X, k )
%KMEANS Performs k-means clustering
%
%   I  - cluster assignment
%   Mu - cluster centroids
%   D  - total distortions
%

    [~, l] = size(X);
    % cluster centroids
    Mu = rand(l, k);
    t = 1;

    while true
        I = cluster_assignment(X, Mu);
        Mu = centroid_update(X, I);
        D(t) = distortion(X, Mu, I);
        if t > 1 && D(t) == D(t-1)
            break;
        end
        t = t + 1;
    end
end

%% cluster_assignment in k-mean algorithm
function [ I ] = cluster_assignment( X, Mu )

    [~, m] = size(Mu);
    [N, ~] = size(X);
    D = zeros(N, m);
    for i=1:m
        mu = ones(N, 1) * Mu(:, i)';
        D(:, i) = sum((X-mu).^2, 2);
    end
    [~, I] = min(D, [], 2);
end

%% centroid_update in k-mean algorithm
function [ Mu ] = centroid_update( X, I )

    [~, l] = size(X);
    K = unique(I)';
    Mu = zeros(l, length(K));
    
    for i=1:length(K)
        Mu(:,i) = mean(X(I == K(i), :))';
    end
end

%% distortion - total distortion of the predicted clusters center
function [ D ] = distortion( X, Mu, I )

    [~, m] = size(Mu);
    [N, l] = size(X);
    
    S = zeros(N, l);
    for i=1:m
        S(I==i,:) = ones(nnz(I==i), 1) * Mu(:, i)';
    end
    D = sum( sum( (X-S).^2 ) );
end