function progress( current, total )
%PROGRESS - Print progress
%
% SP_Lab - University of Missouri-Columbia
% Chanmann Lim
% 09/29/2015

percentage = floor(total * (1:100) / 100);
if nnz(percentage == current)
    fprintf('.');
end