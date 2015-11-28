fprintf('Loading MFCCs...\n');
load('MFCCs');
samples = 1:11; %floor(rand(1,61)*length(MFCCs));
window_size  = 50;
p = 2; % euclidean works better than manhattan

tic;
fprintf('Computing pairwise distance...\n');
dist_mtx = pdist( MFCCs(samples), @dtw_dist, window_size, p );
t=toc;
fprintf('starting clustering after %d h, %d min, %f sec\n',floor(t/60^2),floor(t/60),rem(t,60));
cluster_tree = linkage(dist_mtx, 'weighted')
t=toc;
fprintf('clustering complete after %d h, %d min, %f sec\n',floor(t/60^2),floor(t/60),rem(t,60));

figure;
dendrogram(cluster_tree);
