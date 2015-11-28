clc;
clear all;
close all;

% generate Mel-Frequency cepstral coefficients (MFCC)
% bash -v ./mfcc.sh

files = dir('tmp/mfc/*.mfc');
C = length(files);
MFCCs = cell(C, 1);
labels = cell(C, 3);

% read lables from pronounciation.txt
fid = fopen('pronounciation.txt');
pronouciations = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
% number of words
w = 103;
wid = [103 1:102];

fprintf('Start converting mfc files');
for i=1:C
    name = files(i).name;
    MFCCs{i} = readhtk_lite( ['tmp/mfc/' name] );
    
    % labels = [speaker gender]
    l = length(name);
    labels(i,:) = { ceil(i/w), name(l-13), pronouciations{1}{ wid(mod(i, w) + 1) } };
    progress(i, C);
end
save('../MFCCs.mat', 'MFCCs', 'labels');

display('done!');