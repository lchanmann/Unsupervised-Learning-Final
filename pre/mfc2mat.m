clc;
clear all;
close all;

% generate Mel-Frequency cepstral coefficients (MFCC)
% bash -v ./mfcc.sh

files = dir('tmp/mfc/*.mfc');
C = length(files);
MFCCs = cell(C, 1);
labels = zeros(C, 3);

fprintf('Start converting mfc files');
for i=1:C
    name = files(i).name;
    MFCCs{i} = readhtk_lite( ['tmp/mfc/' name] );
    
    % labels = [speaker gender word]
    l = length(name);
    labels(i,:) = [ceil(i/103) name(l-12) str2double(name(l - [5 4]))];
    progress(i, C);
end
save('../MFCCs.mat', 'MFCCs', 'labels');

display('done!');