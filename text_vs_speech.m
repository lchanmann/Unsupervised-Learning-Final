fid = fopen('pre/pronounciation.txt');
pronounciations = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
text_d=[];
% number of unique words
w = length(pronounciations{1});

h=waitbar(0,'Computing word distance');
for i=1:w
    h=waitbar((i(i+1)/2)/(w(w+1)/2),h,sprintf('Computing distance for word %d',i));
    for j=i+1:w
        text_d(end+1) = strdist(pronounciations{1}{i},pronounciations{1}{j});
    end
end
delete(h);
Text_Z= linkage(text_d, 'weighted');

% load data
load('d_1.mat');

% number of speakers
s = 1;%10;

%%

%for(i=1:s)
    Speech_Z = linkage(d, 'weighted');

    a  =zeros(w,1);
    mi =zeros(w,1);
    for m = 1:w
        speech_clustering = cluster(Speech_Z, 'maxclust', m);
        text_clustering   = cluster(Text_Z, 'maxclust', m);
        a(m) = evaluate(speech_clustering,text_clustering);
        mi(m) = mutual_information(speech_clustering,text_clustering,'normalized');
    end
    [best_accuracy, best_clustering] = max(a)
    [worst_accuracy, worst_clustering] = min(a)
 %end
 
 plot(a)
 hold on
 plot(mi)
 xlabel('Number of word clusters')
 ylabel('Ratio')
 title('Similarity of speech clustering compared to text clustering')
 legend('Ratio of matches','Mutual information score','Location','southeast')