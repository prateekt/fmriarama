function voxelsToKeep = reduceDim(pData, d)
%pData is (wordID, trial, voxel)
%d is the number of dimensions to reduce to
%takes about a minute to run

%size calc
numWords = size(pData,1);
numTrials = size(pData,2);
numVoxels = size(pData,3);

%compute stability scores
stabilityScores = zeros(numVoxels,2);
for i=1:numVoxels

   %create 6x60 matrix for this voxel
   voxelMatrix = zeros(numTrials, numWords);
   for j=1:numTrials
       for k=1:numWords
           voxelMatrix(j,k) = pData(k,j,i);
       end
   end
      
   %compute pairwise correlation between rows (6x6 matrix)
   corrMat = corr(voxelMatrix');
   
   %find average pairwise correlation
   totalSum = sum(sum(corrMat)) - numTrials; %subtract out the ones on the diagonal
   averageCorr = totalSum/(30);

   %store in structure
   stabilityScores(i,1) = i;
   stabilityScores(i,2) = averageCorr;       
end

%sort in descending order
stabilityScores = sortrows(stabilityScores,-2);

%voxels to keep
voxelsToKeep = stabilityScores(1:d,1);
