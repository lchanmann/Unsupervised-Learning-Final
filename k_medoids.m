function [ I, Theta, J ] = k_medoids( P, m )
%KMEANS Performs k-medoids PAM clustering
%
%   I  - cluster assignment
%   Theta - cluster centroids
%   J  - cost of the objective function
%

    [n, ~] = size(P);
    N = n - m;
    % clusters' medoids
%     Theta = [131,71,813,453,58,222,451,29,773,97,262,648,656,148,302,401,322,624,702,791,631,664,159,828,652,774,200,266,700,769,809,770,567,214,726,873,754,514,283,675,406,695,41,808,394,503,840,593,485,839,377,210,517,12,796,571,881,151,697,586,298,676,307,62,411,221,78,146,452,494,577,113,910,156,510,668,187,2,500,8,416,590,256,836,155,659,658,328,27,63,255,147,218,903,722,495,227,498,309,677,847,119,681];
    Theta = randperm(N, m);
    t = 1;

    while true
        D = P(:, Theta);
        U = D == min(D, [], 2)*ones(1, m);
        
        % cost of objective function
        J(t) = cost(D, U);
        if t > 1 && J(t) >= J(t-1)
            break;
        end
        
        I = cluster_assignment(D);
        Theta = centroid_update(P, I);
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

%% cost - compute cost of medoids set Theta
function [ C ] = cost( P, U )

    C = sum( sum(U .* P) );
end
