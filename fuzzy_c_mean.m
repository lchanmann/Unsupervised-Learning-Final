function [ Theta, distortion ] = fuzzy_c_mean( P, Theta, q )
% fuzzy_c_mean - run fuzzy c-medoid clustering algorithm 
%   on Dissimilarity matrix "P".
%
%       q : fuzzifier
%

    [~, m] = size(Theta);
    [n, ~] = size(P);
    % the number of data excluding clusters' representatives
    N = n - m;
    p = 1/(q-1);

    t = 0;
    distortion = [];

    while true
        idx = 1:n; idx(Theta) = [];
        
        D = P(idx, Theta);
        U = 1 ./ ((D.^p) .* (sum(D.^-p, 2)*ones(1, m)));
        
        % medoids update
        Theta_1 = U(:,1).^q .* D(:,1)
        [~, Theta_t] = min(U.^q .* D);
        
        t = t + 1;
        % compute total distortion
        distortion(t) = sum( sum(D) );
        if t > 1 && distortion(t) >= distortion(t-1)
            break;
        end
        Theta = Theta_t;
    end
end
