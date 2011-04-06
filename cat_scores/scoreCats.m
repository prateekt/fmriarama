function [catScores, uniqueCat] = scoreCats()

%load files
load allCVData.mat;
load wordStrings60.mat;

%load categories
wordCat = extractWordToCat();

%compute unique ways to leave 2 out
numImages = 60;
realCnt=1;
for i=1:numImages
    for j=(i+1):numImages
        uniquePairs{realCnt} = [i,j];
        realCnt = realCnt + 1;
    end    
end

%add up all results over participants
allWordScores = zeros(1770,1);
for i=1:length(Result_exp_all)
    allWordScores = allWordScores + Result_exp_all{i};
end

%create categories index map
uniqueCat = unique(wordCat.values);
C = length(uniqueCat);
catInd = containers.Map('loz',1);
remove(catInd,'loz');
for i=1:C
    catInd(uniqueCat{i}) = i;
end

%create categories matrix
catScores = zeros(C,3);
for i=1:length(allWordScores)
    
    %get leave out indices
    lo_indices = uniquePairs{i};
    
    %get words
    w1 = words{lo_indices(1)};
    w2 = words{lo_indices(2)};
    
    %get categories
    c1 = wordCat(w1);
    c2 = wordCat(w2);
    
    %if same category
    if(strcmp(c1,c2)==1)
        
        %get index of common category
        cInd = catInd(c1);
        
        %update
        catScores(cInd,1) = catScores(cInd,1) + allWordScores(i);
        catScores(cInd,2) = catScores(cInd,2) + (9-allWordScores(i));        
    end
end

%compute accs
for i=1:C
    catScores(i,3) = catScores(i,1) / (catScores(i,1) + catScores(i,2));
end