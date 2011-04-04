function F = createF(imgWords, featureWords, oldF)

%size calc
numWords = length(imgWords);
numFeatures = size(oldF,2);

%create mapping of img words to index
indexMap = containers.Map('lolz',1);
remove(indexMap,'lolz');
for i=1:numWords
    cWord= imgWords{i};
    indexMap(cWord) = i;
end
indexMap

%order F according to the mapping
F = zeros(numWords,numFeatures);
for i=1:numWords
    
    %look up word index
    cWord = featureWords{i};
    index = indexMap(cWord);
    
    %store appropriate row of oldF in F
    F(i,:) = oldF(index,:);
    
    %normalize the row to have length 1
    F(i,:) = F(i,:)/sqrt(sum(F(i,:).^2));    
end