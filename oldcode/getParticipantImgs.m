function [finalData, words] = getParticipantImgs(info, data, meta, RED_DIM)
%pData is (wordID, trial, voxel) struct -- contains all brain image data
%sorted by word and trial for a single participant.

%params
numWords = 60;
numTrials=  6;
numVoxels = meta.nvoxels;
numExp = meta.ntrials;

%find set of unique words and create mapping of word to its index in
%words list we are producing.
wordSet = containers.Map({'lolz'},{1});
remove(wordSet,'lolz');
words = cell(numWords,1);
cnt=1;
for i=1:numExp
    cWord = info(i).word;
    if(~isKey(wordSet,cWord))
        words{cnt} = cWord;
        wordSet(cWord) = cnt;
        cnt = cnt  + 1;
    end    
end

%store brain images for those words
pData = zeros(numWords,numTrials,numVoxels);
trialIndex = ones(numWords,1);
for i=1:numExp
    
    %get current word
    cWord = info(i).word;
    
    %get current brain image
    image = data{i};
        
    %look up index of word
    wIndex = wordSet(cWord);
    
    %store in pData
    pData(wIndex,trialIndex(wIndex),:) = image;
    trialIndex(wIndex) = trialIndex(wIndex) + 1;
    
end

%average to create single image for each word
[trialsAvg] = normalizeData(pData);

%reduce dimensionality
voxelsToKeep = reduceDim(pData,RED_DIM);
finalData = zeros(numWords,RED_DIM);
for i=1:length(voxelsToKeep)
    
    %get index in old struct
    index = voxelsToKeep(i);
    
    %store in new struct
    finalData(:,i) = trialsAvg(:,index);
end

%{
%normalize each image in final data to be 0 mean and 1 var
%after reduction
for i=1:numWords
        
    %get image
    image = finalData(i,:);
        
    %normalize image to be 0 mean and 1 var
    image_mean = mean(image);
    image_var = var(image);
    normalized_image = (image-image_mean)/image_var;
        
    %store normalized image
    finalData(i,:) = normalized_image;
end    

%create zero mean voxels (cols)
for i=1:RED_DIM
    
    %create zero mean
    voxelVals = finalData(:,i);
    mean_vals = mean(voxelVals);
    voxelVals = voxelVals - mean_vals;
    
    %store
    finalData(:,i) = voxelVals;    
end
%}

