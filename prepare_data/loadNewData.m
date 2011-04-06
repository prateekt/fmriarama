function [X,F, pRankedVoxels] = loadNewData(participantID)

%load files
load mri_examples_all.mat;
load rankedVoxels_leave2out.mat;
load Intel218Data60.mat;

%load X
X = mri_examples_all{participantID};

%load pRankedVoxels
pRankedVoxels = rankedVoxels{participantID};

%load F
F = Intel218Data60mean0;