function QStruct_gt = getGroundTruthQStruct(N) 

%load data
load Intel218Questions.mat;
load Intel218Data60.mat;

%create correlation matrix out of semantic features.
%Basically, figure out how different semantic features are correlated
%in terms of the values they take on in the 60 word set.
corrMat = corr(Intel218Data60mean0);

%replace all nans with -inf so they don't get selected.
for i=1:size(corrMat,1)
    for j=1:size(corrMat,2)
        if(isnan(corrMat(i,j)))
            corrMat(i,j) = -inf;
        end
    end
end

%for each semantic feature, find the top N correlated other semantic
%features
mostCorrSM = zeros(218,N);
for i=1:218
    
    %look at correlations for current feature with respect to other
    %features.
    featureCorr = [corrMat(i,:)', [1:218]'];
    featureCorr(i) = -inf; %make sure to set that stupid diagonal entry to -inf.
        
    %sort features
    featureCorr = sortrows(featureCorr,-1);
    
    %put into struct
    mostCorrSM(i,:) = featureCorr(1:N,2);
    
end

%convert to QStruct
Q1 = cell(218,1);
Q2 = cell(218,1);
Q3 = cell(218,1);
Q4 = cell(218,1);
Q5 = cell(218,1);
Q6 = cell(218,1);
for i=1:218
    Q1{i} = Intel218Questions(i);
    resultQs = Intel218Questions(mostCorrSM(i,:));
    Q2{i} = resultQs{1};
    Q3{i} = resultQs{2};
    Q4{i} = resultQs{3};
    Q5{i} = resultQs{4};
    Q6{i} = resultQs{5};
end
QStruct_gt = struct('orig',Q1,'Q2',Q2, 'Q3', Q3, 'Q4', Q4, 'Q5', Q5, 'Q6', Q6);
