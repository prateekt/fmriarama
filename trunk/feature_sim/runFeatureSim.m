function minDistSF = runFeatureSim(participantID)

%params 
method = 2;
lambda = 1;

%cross validation and get l2o weight matrices for participant
CVAL=1
[X,F, pRankedVoxels] = loadNewData(participantID);
[acc, W_all] = l2cv_new(X,F,pRankedVoxels, method, lambda);

%analyze weights
ANALYZE_WEIGHTS=1
voxelsSemF = analyzeWeights(W_all, pRankedVoxels);

%return
M=10;
N=10;
minDistSF = sim_TopInds(voxelsSemF, M, N);