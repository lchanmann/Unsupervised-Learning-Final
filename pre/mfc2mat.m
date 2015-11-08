clc;
clear all;
close all;

files = dir('tmp/mfc/*.mfc');
C = length(files);
MFCCs = cell(1, C);
labels = zeros(C, 3);

fprintf('Start converting mfc files');
for i=1:C
    name = files(i).name;
    MFCCs{i} = readhtk_lite( ['tmp/mfc/' name] );
    
    % labels = [speaker gender word]
    l = length(name);
    labels(i,:) = [ceil(i/21) name(l-12) str2double(name(l - [5 4]))];
    progress(i, C);
end
save('../MFCCs.mat', 'MFCCs', 'labels');

exit;