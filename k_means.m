function [ I, Theta, distortion ] = k_means( P, m )
%KMEANS Performs k-means clustering
%
%   I  - cluster assignment
%   Theta - cluster centroids
%   distortion  - total distortion
%

    [n, ~] = size(P);
    N = n - m;
    % clusters' medoids
    Theta = randperm(N, m);
    t = 1;

    while true
        I = cluster_assignment(P(:, Theta));
        Theta = centroid_update(P, I);
        distortion(t) = total_distortion(P, Theta, I);
        if t > 1 && distortion(t) == distortion(t-1)
            break;
        end
        t = t + 1;
    end
end

%% cluster_assignment in k-mean algorithm
function [ I ] = cluster_assignment( D )

    [~, I] = min(D, [], 2);
end

%% centroid_update in k-mean algorithm
function [ Theta ] = centroid_update( P, I )

    [N, ~] = size(P);
    ind = 1:N;
    c = unique(I)';
    m = length(c);
    Theta = zeros(1, m);
    
    for j=1:m
        % rows assigned to cluster j and their indices
        n = I==c(j);
        r = ind(n);
        % closest point to all points in cluster j
        [~, k] = min( sum(P(n, n)) );
        Theta(j) = r(k);
    end
end

%% distortion - total distortion of the predicted clusters center
function [ D ] = total_distortion( P, Theta, I )

    [N, ~] = size(P);
    c = unique(I)';
    m = length(c);
    
    S = zeros(N, 1);
    for j=1:m
        n = I==c(j);
        S(n) = P(n, Theta(j));
    end
    D = sum( S );
end
