function [trialsAvg] = normalizeData(pData)

%size calc
numWords = size(pData,1);
numTrials = size(pData,2);
numVoxels = size(pData,3);

%normalize each of the 360 images
for i=1:numWords
    for j=1:numTrials
        
        %get image
        image = pData(i,j,:);
        
        %normalize image to be 0 mean and 1 var
        image_mean = mean(image);
        image_var = var(image);
        normalized_image = (image-image_mean)/image_var;
        
        %store normalized image
        pData(i,j,:) = normalized_image;

    end
end    

%average each of the trials
trialsAvg = zeros(numWords,numVoxels);
for i=1:numWords
    
    %average trials for word
    wordSum = zeros(numVoxels,1);
    for j=1:numTrials
        wordSum = wordSum + reshape(pData(i,j,:),numVoxels,1);
    end
    wordSum = wordSum / numTrials;
    
    %store trial average
    trialsAvg(i,:) = wordSum;    
end

%create zero mean voxels (cols)
for i=1:numVoxels
    
    %create zero mean
    voxelVals = trialsAvg(:,i);
    mean_vals = mean(voxelVals);
    voxelVals = voxelVals - mean_vals;
    
    %store
    trialsAvg(:,i) = voxelVals;    
end