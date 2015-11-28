% clean matlab environment
clear;clc;close all;

% import dtw C module
mex +dtw/dtw_c.c;