fprintf('Loading MFCCs...\n');
load('MFCCs');
samples = 1:21; %floor(rand(1,15)*length(MFCCs));
window_size  = 30;
norm = 1; %manhattan

tic;
fprintf('Computing pairwise distance...\n');
dist_mtx = pdist( MFCCs(samples), dtw.new(window_size,norm) );
t=toc;
fprintf('starting clustering after %d h, %d min, %f sec\n',floor(t/60^2),floor(t/60),rem(t,60));
cluster_tree = linkage(dist_mtx, 'weighted');
t=toc;
fprintf('clustering complete after %d h, %d min, %f sec\n',floor(t/60^2),floor(t/60),rem(t,60));

dendrogram(cluster_tree);
