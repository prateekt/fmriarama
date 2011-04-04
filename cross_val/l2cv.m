function acc = l2cv(X,F,method, lambda)

%size calc
numImages = size(X,1);
image_d = size(X,2);
numFeatures = size(F,2);

%compute unique ways to leave 2 out
realCnt=0;
pairs = zeros(numImages,numImages);
for i=1:numImages
    for j=1:numImages
        
        %freebie
        if(i==j)
            continue;
        end
        
        %see if pair contained
        if(pairs(i,j)==1 || pairs(j,i)==1)
            continue;
        end
        
        %update
        pairs(i,j) = 1;
        pairs(j,i) = 1;
        
        realCnt = realCnt + 1;
        uniquePairs{realCnt} = [i,j];
    end    
end

%perform each leave 2 out experiment
overallCorrect=0;
for i=1:length(uniquePairs)
    
    %get leave out pair
    leaveOutPair = uniquePairs{i};
    
    %create X_exp and F_exp
    X_exp = zeros(numImages-2,image_d);
    F_exp = zeros(numImages-2,numFeatures);
    cnt=1;
    for j=1:numImages
        
        %leave them out
        if(j==leaveOutPair(1) || j==leaveOutPair(2))
            continue;
        end
        
        %populate structures
        X_exp(cnt,:) = X(j,:);
        F_exp(cnt,:) = F(j,:);
        cnt = cnt+1;
        
    end
        
    %training    
    W_exp = learnWeights(X_exp,F_exp,method, lambda);
    
    %predict F for left examples
    X_lf = [X(leaveOutPair(1),:); X(leaveOutPair(2),:)];
    F_pred_lf = predictF(X_lf,W_exp);
    F_gt_lf = [F(leaveOutPair(1),:); F(leaveOutPair(2),:)];
    
    %compute boolean result
    p1 = F_pred_lf(1,:);
    p2 = F_pred_lf(2,:);
    s1 = F_gt_lf(1,:);
    s2 = F_gt_lf(2,:);
    
    result = (pdist([p1;s1]) + pdist([p2;s2])) < (pdist([p1;s2]) + pdist([p2;s1]));

    %accumulate total
    overallCorrect = overallCorrect + result;
    [overallCorrect,i]
end

%compute acc
acc = overallCorrect / length(uniquePairs);
overallCorrect