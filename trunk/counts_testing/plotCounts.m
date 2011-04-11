%load file
load allOriginalCounts.mat;
M=100;

predCountsAll = zeros(218,9);
for p=1:9
    
    %get original counts
    voxelsSemF = originalCounts{p};
    
    %get top inds
    topInds = zeros(218,M);
    predCounts = zeros(218,1);
    for i=1:218
        [vals,inds] = getTopM(voxelsSemF(i,:),M);            
        topInds(i,:) = inds;
        predCounts(i,1) = sum(vals) /17700;
    end
    
    predCountsAll(:,p) = predCounts;
end

plot(mean(predCountsAll'),'s');
title('Percentage of 17700 counts covered by the top M=100 voxels (averaged over all participants)'); 
xlabel('Semantic Feature');
ylabel('Percentage of Counts covered by top M=100 voxels');

