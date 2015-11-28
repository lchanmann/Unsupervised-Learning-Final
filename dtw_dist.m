function d = dtw_dist( XI, XJ, varargin )
% DTW_DIST dtw distance function to use with pdist

d = dtw.base(XI{1}, XJ{1}, varargin{:});
