clc;
clear all;
close all;

files = dir('tmp/mfc/*.mfc');
C = length(files);
MFCCs = cell(1, C);

fprintf('Start converting mfc files');
for i=1:C
    name = files(i).name;
    MFCCs{i} = readhtk_lite( ['tmp/mfc/' name] );
    progress(i, C);
end
save('../MFCCs.mat', 'MFCCs');

exit;