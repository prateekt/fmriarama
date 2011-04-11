function [catScores, w1s,w2s] = investigateCat(category)

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

%create categories index map
uniqueCat = unique(wordCat.values);
C = length(uniqueCat);
catInd = containers.Map('loz',1);
remove(catInd,'loz');
for i=1:C
    catInd(uniqueCat{i}) = i;
end

%create structure
catScores = zeros(10,3);
cnt=1;
for i=1:1770
    
    %get leave out indices
    lo_indices = uniquePairs{i};
    
    %get words
    w1 = words{lo_indices(1)};
    w2 = words{lo_indices(2)};
    
    %get categories
    c1 = wordCat(w1);
    c2 = wordCat(w2);
    
    %if same category
    if(strcmp(c1,c2)==1 && strcmp(c1,category)==1)
                
        %update for each person seperately
        for j=1:9
            
            %get participant performance
            pResults = Result_exp_all{j};
            
            %add result
            catScores(cnt,1) = catScores(cnt,1) + pResults(i);
            catScores(cnt,2) = catScores(cnt,2) + (1-pResults(i));
            
        end
        
        w1s{cnt} = w1;
        w2s{cnt} = w2;
        
        %update cnt
        cnt = cnt + 1;

    end
end

%compute accs
for j=1:10
    catScores(j,3) = catScores(j,1) / (catScores(j,1) + catScores(j,2));
end