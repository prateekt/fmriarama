function voxelsSemF = analyzeWeights(W_all, pRankedVoxels, L)

%compute unique ways to leave 2 out
numImages=60;
realCnt=1;
for i=1:numImages
    for j=(i+1):numImages
        uniquePairs{realCnt} = [i,j];
        realCnt = realCnt + 1;
    end    
end

%aggregate counts of voxels in terms of how many times a voxel is a 'top-L
%activation voxel' for a semantic feature.
voxelsSemF = zeros(218,21764);
for i=1:length(uniquePairs)
        
    %get voxels used
    voxelsUsed = pRankedVoxels{i};
    
    %get weights
    weightsUsed = W_all{i};
    
    %find maximum of weights used and indices for a given feature
    maxWeightInd = zeros(218,L);
    for j=1:218
        
        %get weights and indices
        currentWeights = zeros(500,2);
        currentWeights(:,1) = weightsUsed(:,j);
        currentWeights(:,2) = voxelsUsed;
        currentWeights = sortrows(currentWeights,-1);
        
        %update
        maxWeightInd(j,:) = currentWeights(1:L,2);
    end
    
    %look through max inds and update for each feature
    for j=1:size(maxWeightInd,1)
        for k=1:L
            voxelsSemF(j,maxWeightInd(j,k)) = voxelsSemF(j,maxWeightInd(j,k)) + 1;
        end
    end
    
    i
end