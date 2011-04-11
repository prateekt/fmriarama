function [minDistSF, voxelsSemF] = runFeatureSim(participantID, L, M, N)

%params 
method = 2;
lambda = 1;

%cross validation and get l2o weight matrices for participant
CVAL=1
[X,F, pRankedVoxels] = loadNewData(participantID);
[acc, W_all] = l2cv_new(X,F,pRankedVoxels, method, lambda);

%analyze weights to create counts matrix for top L activation weights.
ANALYZE_WEIGHTS=1
voxelsSemF = analyzeWeights(W_all, pRankedVoxels,L);

%find top M in counts matrix
minDistSF = sim_TopInds(voxelsSemF, M, N);