function [ H ] = entropy( P )
% ENTROPY compute entropy of distribution P

P = P(:);
H = sum( -P .* log2(P) );