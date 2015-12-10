function [ I, Theta, J, I1 ] = k_medoids( P, m )
%KMEANS Performs k-medoids CLARANS clustering
%   CLARAN - Clustering Large Application based on RANdomized Search
%   Ref: https://www.youtube.com/watch?v=OWpRBCrx5-M
%
%   I  - cluster assignment
%   Theta - cluster centroids
%   J  - cost of the objective function
%

    [n, ~] = size(P);
    % clusters' medoids
%     load('I_Theta.mat');
    Theta = randperm(n, m);
    t = 0;

    while true
        D = P(:, Theta);
        U = D == min(D, [], 2)*ones(1, m);
        
        % cost of objective function
        t = t + 1;
        J(t) = cost(D, U);
        if t > 1 && J(t) >= J(t-1)
            break;
        end
        
        I = cluster_assignment(D);
        if t==1
            I1 = I;
        end
        Theta = medoid_swap(P, Theta, I, J(t));
    end
end

function Theta = medoid_swap( P, Theta, I , J )
    [n, ~] = size(P);
    [~, m] = size(Theta);
    S = randperm(n, randi([1, round(0.8*n)]));
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

%% cost - compute cost of medoids set Theta
function [ C ] = cost( P, U )
    C = sum( sum(U .* P) );
end
