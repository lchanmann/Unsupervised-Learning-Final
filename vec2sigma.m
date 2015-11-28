function [ S ] = vec2sigma( v, l )
% vec2sigma Convert vector to l*l symmetric matrix

if l*(l+1)/2 ~= length(v)
    error('The required elements mismatch with the dimensionalty.');
end

S = zeros(l, l);
index = 1;
for i=1:l
    for j=i:l
        S(i, j) = v(index);
        index = index + 1;
    end
end

% clone upper-triangle off-diagonal to the lower
S = S + triu(S, 1)';