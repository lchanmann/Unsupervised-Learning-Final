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
    epsilon = 1e-3;

    while true
        idx = 1:n; idx(Theta) = [];
        P_tilde = P(idx,:);
        
        D = P_tilde(:, Theta);
        U = 1 ./ ((D.^p) .* (sum(D.^-p, 2)*ones(1, m)));
        
%         for i=1:N
%             D = distance_from_Theta(X{i}, Theta);
%             for j=1:m
%                 U(i,j) = 1/(sum( (D(j)./D).^p ));
%             end
%         end
        t = t + 1;
%         Theta_t = zeros(1, m);
%         % parameter update
%         for j=1:m
%             
%         end
        
        [~, Theta_t] = min(U.^q .* D);
        
%         Theta_t = P_tilde{j};

        % check for termination
        % : if change in Theta is smaller than epsilon
        c = Theta(:) - Theta_t(:);
        if sqrt(c'*c) < epsilon
            break;
        end
        Theta = Theta_t;
        % total distortion
        distortion(t) = total_distortion(P_tilde, Theta);
    end
end

function D = distance_from_Theta( x, Theta )
% compute distance from x to all centroids Theta
%

    % DTW window parameter
    w = 50;

    [m, ~] = size(Theta);
    D = zeros(m, 1);

    for j=1:m
        D(j) = dtw_c(x, Theta{j}, w);
    end
end