function [X,F] = loadData(dudeID)

%PARAMS
RED_DIM=500;

tic
%load brain images
fileStr = strcat('data-science-P',num2str(dudeID),'.mat');
load(fileStr);

%load human features
load Intel218Data60.mat;
load wordStrings60.mat;
toc

%load participant images in nice structure X
tic
[X, imgWords] = getParticipantImgs(info1, data, meta, RED_DIM);
toc

%create F
tic
F = createF(imgWords, words, Intel218Data60mean0);
toc