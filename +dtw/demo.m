% Copyright (C) 2013 Quan Wang <wangq10@rpi.edu>,
% Signal Analysis and Machine Perception Laboratory,
% Department of Electrical, Computer, and Systems Engineering,
% Rensselaer Polytechnic Institute, Troy, NY 12180, USA

% this is a demo showing the use of our dynamic time warping package 
% we provide both Matlab version and C/MEX version
% the C/MEX version is much faster and highly recommended
import dtw.*
%clear;clc;close all;

%mex dtw_c.c;

a=rand(500,3);
b=rand(520,3);
w=50;

tic;
d1=base(a,b,w);
t1=toc;

%tic;
%d2=c(a,b,w);
%t2=toc;

tic;
f=new(w);
d3=f({a},{b});
t3=toc;

fprintf('Using base Matlab version: distance=%f, running time=%f\n',d1,t1);
%fprintf('Using C/MEX version: distance=%f, running time=%f\n',d2,t2);
fprintf('Using constructor version with cells: distance=%f, running time=%f\n',d3,t3);

