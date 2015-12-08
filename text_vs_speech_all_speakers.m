fid = fopen('pre/pronounciation.txt');
pronounciations = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
% number of unique words
w = length(pronounciations{1});
% number of speakers
s = 10;

h=waitbar(0,'Computing word distance...');
text_d=[];%text_d=inf(w*(w-1)/2);
for i=1:w
    h=waitbar((i*(i-1)/2)/(w*(w-1)/2),h,sprintf('Computing distance for word %d',i));
    for j=i+1:w
        text_d(end+1) = strdist(pronounciations{1}{i},pronounciations{1}{j});
    end
end
h=waitbar(1,h,'Finalizing...');
text_d = squareform(repmat(squareform(text_d,'tomatrix'),10),'tovector');
Text_Z = linkage(text_d, 'weighted');
delete(h);

word_accuracy = evaluate(cluster(Text_Z,'maxclust',103), repmat([1:w]',s,1))

%%
% load data
load('d13.mat');

Speech_Z = linkage(d, 'weighted');

a  =zeros(w,1);
mi =zeros(w,1);
for m = 1:w
    speech_clustering = cluster(Speech_Z, 'maxclust', m);
    text_clustering   = cluster(Text_Z, 'maxclust', m);
    a(m) = evaluate(speech_clustering,text_clustering);
    mi(m) = mutual_information(speech_clustering,text_clustering,'normalized');
end

figure
plot(a)
hold on
plot(mi)
xlabel('Number of word clusters')
ylabel('Ratio')
title('Similarity of speech vs text clustering, trained with all speakers')
legend('Ratio of matches','Mutual information score','Location','southeast')
