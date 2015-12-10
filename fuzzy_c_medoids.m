function [ Theta, distortion, I ] = fuzzy_c_medoids( P, Theta, q )
% fuzzy_c_mean - run fuzzy c-medoids clustering algorithm 
%   on Dissimilarity matrix "P".
%
%       q : fuzzifier
%

    [~, m] = size(Theta);
    [n, ~] = size(P);
    % the number of data excluding clusters' representatives
    p = 1/(q-1);

    t = 0;
    distortion = [];

    while true
%         idx = 1:n; idx(Theta) = [];
%         P_tilde = P(idx, :);
%         D = P_tilde(:, Theta);
%         U = 1 ./ ((D.^p) .* (sum(D.^-p, 2)*ones(1, m)));
%         % medoids update
%         Theta_t = Theta_t = medoid_update(U, P_tilde, q);

        D = P(:, Theta);
        U = exp(-n/m*D) ./ (sum(exp(-n/m*D), 2)*ones(1, m));
%         U = exp(-D/n/m);
%         U = 1./(1+D.^p);
%         U = D == min(D, [], 2)*ones(1, m);
        
        % medoids update
        Theta_t = medoid_update(U, P, q);
        
        % total distortion
        t = t + 1;
        distortion(t) = sum( min(D, [], 2) );
        
        % convergence check
        if all(Theta == Theta_t)
            break;
        end
        Theta = Theta_t;
    end
    
    % cluster assignment
    [~, I] = min(P(:, Theta), [], 2);
end

function Theta = medoid_update( U, P, q )
%MEDOID_UPDATE update medoid to minimize weighted sum distance
%

    W = U'.^q * P;
    [~, Theta] = min(W, [], 2);
    Theta = Theta';
end
