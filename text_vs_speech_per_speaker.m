fid = fopen('pre/pronounciation.txt');
pronounciations = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
% number of unique words
w = length(pronounciations{1});

h=waitbar(0,'Computing word distance');
text_d=[];%text_d=inf(w*(w-1)/2);
for i=1:w
    h=waitbar((i*(i-1)/2)/(w*(w-1)/2),h,sprintf('Computing distance for word %d',i));
    for j=i+1:w
        text_d(end+1) = strdist(pronounciations{1}{i},pronounciations{1}{j});
    end
end
delete(h);
Text_Z= linkage(text_d, 'weighted');
figure
dendrogram(Text_Z)
title('Clustering for text transcriptions')

%%
all = false;

% number of speakers
s = 10;

for i=1:s
    % load data
    load(sprintf('d_%d.mat',i));
    
    Speech_Z = linkage(d, 'weighted');

    a  = zeros(w,1);
    mi = zeros(w,1);
figure
dendrogram(Speech_Z)
title(sprintf('Clustering for Speaker %d''s speech',i))
    for m = 1:w
        speech_clustering = cluster(Speech_Z, 'maxclust', m);
        text_clustering   = cluster(Text_Z, 'maxclust', m);
        a(m) = evaluate(speech_clustering,text_clustering);
        mi(m) = mutual_information(speech_clustering,text_clustering,'normalized');
    end
    
    if ~all
        figure
    end
    plot(a,'b')
    hold on
    plot(mi,'r')    
    if ~all
        title(sprintf('Similarity of speech clustering compared to text clustering for speaker %d',i))
        legend('Ratio of matches','Mutual information score','Location','southeast')
    end
end
if all
    xlabel('Number of word clusters')
    ylabel('Ratio')
    title('Similarity of speech clustering compared to text clustering for all speakers')
end

%% Manually found intersection points
scatter([24 28 27 29 25 27 25 30 32 31],[0.4409 0.4869 0.4561 0.4466 0.4238 0.4689 0.466 0.4621 0.4794 0.5395],'g','filled')
