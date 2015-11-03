function progress( current, total )
% PROGRESS Print progress

percentage = floor(total * (1:100) / 100);
if nnz(percentage == current)
    fprintf('.');
end