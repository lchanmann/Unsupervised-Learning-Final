function [ Theta, distortion, I ] = fuzzy_c_medoids( P, Theta, q )
% fuzzy_c_mean - run fuzzy c-medoids clustering algorithm 
%   on Dissimilarity matrix "P".
%
%       q : fuzzifier
%

    [~, m] = size(Theta);
    [n, ~] = size(P);
    % the number of data excluding clusters' representatives
%     N = n - m;
%     p = 1/(q-1);

    t = 0;
    distortion = [];

    while true
%         idx = 1:n; idx(Theta) = [];
%         P_tilde = P(idx, :);
%         D = P_tilde(:, Theta);
%         U = 1 ./ ((D.^p) .* (sum(D.^-p, 2)*ones(1, m)));

        D = P(:, Theta);
        U = exp(-n/m*D) ./ (sum(exp(-n/m*D), 2)*ones(1, m));
% %         U = exp(-D);
% %         U = 1./(1+D);
        
        % medoids update
        [~, Theta_t] = min((U'.^q * P)');
        
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
    [~, I] = min(D, [], 2);
end
