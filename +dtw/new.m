%Copyright 2015 Fernando Torre-Mora <fthc8@mail.missouri.edu>
%Please notify me of any reuse

function fxn = new(w,p)
% Creates a two-parameter dtw function
% (assuming the vectors to be compared to be contained in cells)
% filling in the other parameters with those provided to dtw.new()
% w: window parameter (optional)
% p: norm to use (optional)
% see dtw.base() for these parameters' default values
    import dtw.base
    if nargin<1
        fxn = @(s,t)base(cell2mat(s),cell2mat(t));
    else
        if nargin<2
            fxn = @(s,t)base(cell2mat(s),cell2mat(t),w);
        else
            fxn = @(s,t)base(cell2mat(s),cell2mat(t),w,p);
        end
    end
end

