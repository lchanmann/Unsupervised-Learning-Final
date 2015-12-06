function [ I, Theta, J ] = k_medoids( P, m )
%KMEANS Performs k-medoids CLARANS clustering
%   CLARAN - Clustering Large Application based on RANdomized Search
%   Ref: https://www.youtube.com/watch?v=OWpRBCrx5-M
%
%   I  - cluster assignment
%   Theta - cluster centroids
%   J  - cost of the objective function
%

    [n, ~] = size(P);
%     N = n - m;
    % clusters' medoids
    Theta = randperm(n, m);
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
        Theta = medoid_swap(P, Theta, I, J(t));
        t = t + 1;
    end
end

function Theta = medoid_swap( P, Theta, I , J )
    [n, ~] = size(P);
    [~, m] = size(Theta);
    S = randperm(n, randi([1, 0.8*n]));
    N = length(S);
    for i=1:N
        Si = S(i);
        if ~any(Theta == Si)
            j = I( Si );
            Theta_j = Theta(j);
            Theta(j) = Si;
            
            % compute cost
            D = P(:, Theta);
            U = D == min(D, [], 2)*ones(1, m);
            if J > cost(D, U)
                break;
            else
                Theta(j) = Theta_j;
            end
        end
    end
end

%% cluster_assignment in k-mean algorithm
function [ I ] = cluster_assignment( D )

    [~, I] = min(D, [], 2);
end

% %% centroid_update in k-mean algorithm
% function [ Theta ] = centroid_update( P, I )
% 
%     [N, ~] = size(P);
%     ind = 1:N;
%     c = unique(I)';
%     m = length(c);
%     Theta = zeros(1, m);
%     
%     for j=1:m
%         % rows assigned to cluster j and their indices
%         n = I==c(j);
%         r = ind(n);
%         % closest point to all points in cluster j
%         [~, k] = min( sum(P(n, n)) );
%         Theta(j) = r(k);
%     end
% end

%% cost - compute cost of medoids set Theta
function [ C ] = cost( P, U )
    C = sum( sum(U .* P) );
end
