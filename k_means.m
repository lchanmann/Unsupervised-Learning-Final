function [ I, D ] = k_means( X, m )
%KMEANS Performs k-means clustering
%
%   I  - cluster assignment
%   Theta - cluster centroids
%   D  - total distortion
%

    [~, l] = size(X);
    Theta = rand(l, m);
    D = [];
    t = 1;

    while true
        I  = cluster_assignment(X, Theta);
        D(t) = distortion(X, Theta, I);
        if t > 1 && D(t) >= D(t-1)
            break;
        end
        Theta = centroid_update(X, I);
        t = t + 1;
    end
end

function [ I ] = cluster_assignment( X, Theta )
% cluster_assignment in k-mean algorithm

    [~, m] = size(Theta);
    [N, ~] = size(X);
    D = zeros(N, m);
    for i=1:m
        mu = ones(N,1) * Theta(:,i)';
        D(:, i) = sum((X-mu).^2, 2);
    end
    [~, I] = min(D, [], 2);
end

function [ Theta ] = centroid_update( X, I )
% centroid_update in k-mean algorithm
%       X - dataset
%       I - clusters assignment

    [~, d] = size(X);
    C = unique(I)';
    Theta = zeros(d, length(C));
    
    for j=1:length(C)
        Theta(:,j) = mean(X(I==C(j), :), 1)';
    end
end

function [ D ] = distortion( X, Theta, I )
% distortion - total distortion of the predicted clusters center
%       X  - dataset
%       Mu - clusters centroid
%       I  - clusters assignment

    [~, m] = size(Theta);
    [N, l] = size(X);
    K = unique(I)';
    
    S = zeros(N, l);
    for i=1:length(K)
        S(I==K(i),:) = ones(nnz(I==K(i)), 1) * Theta(:, i)';
    end
    D = sum( sum( (X-S).^2 ) );
end
