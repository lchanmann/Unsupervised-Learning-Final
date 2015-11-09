clc;
clear all;
close all;

files = dir('wav/*.wav');
C = length(files);
ids = [20 0:19];

for i=1:C
    name = files(i).name;
    l = length(name);
    id = sprintf('%2.0f', ids(mod(i, 21) + 1));
    id(id==32) = 48;
    
    movefile(['wav/' name], ['wav/' name(1:l-7) id '.wav']);
    disp(['wav/' name(1:l-7) id '.wav']);
end