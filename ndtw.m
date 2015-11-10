function d = ndtw( s,t )
% NDTW normalized dynamic time warping of two signals

ns=size(s,1);
nt=size(t,1);

D = zeros(ns+1,nt+1) + Inf;
D(1,1) = 0;

P = zeros(ns+1,nt+1) + Inf;
P(1,1) = 0;

for i=1:ns
    for j=1:nt
        cost = norm(s(i,:)-t(j,:), 2);
        [m, p] = min( [D(i,j+1), D(i+1,j), D(i,j)] );
        D(i+1,j+1) = cost + m;
        
        Ps = [P(i,j+1), P(i+1,j), P(i,j)];
        P(i+1,j+1) = 1+Ps(p);
    end
end
d = D(ns+1,nt+1)/P(ns+1,nt+1);
