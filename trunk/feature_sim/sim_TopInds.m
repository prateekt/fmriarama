function QStruct = sim_TopInds(voxelsSemF, M, N)
%M for number of top indices to rank voxel features on
%N the number of similiar semantic categories to find for a semantic
%category

%get top inds
topInds = zeros(218,M);
for i=1:218
    [vals,inds] = getTopM(voxelsSemF(i,:),M);
    topInds(i,:) = inds;
end

%find lowest distance semantic features to current semantic feature i
% in terms of top-voxel-actication-space-for-a-sematic-feature.
minDistSF = zeros(218,N);
for i=1:218
    
    %get top inds
    inds1 = topInds(i,:);
    
    distToFeatures = zeros(218,2);    
    for j=1:218
        
        %freebie
        if(i==j)
            distToFeatures(j,1) = inf;
            distToFeatures(j,2) = i;
            continue;
        end
        
        %get top inds
        inds2 = topInds(j,:);
        
        %compare them
        dist = 0;
        for k=1:length(inds1)
            
            minDist=inf;
            for m=1:length(inds2)
                cDist = abs(inds1(k)-inds2(m));
                if(cDist < minDist)
                    minDist = cDist;
                end
            end
            dist = dist + minDist;
        end
        
        distToFeatures(j,1) = dist;
        distToFeatures(j,2) = j;
    end
    
    %sort distance to features
    distToFeatures = sortrows(distToFeatures,1);
    
    %store
    minDistSF(i,:) = distToFeatures(1:N,2);
end

%convert to q's mat
load Intel218Questions.mat;
Q1 = cell(218,1);
Q2 = cell(218,1);
Q3 = cell(218,1);
Q4 = cell(218,1);
Q5 = cell(218,1);
Q6 = cell(218,1);
for i=1:218
    Q1{i} = Intel218Questions(i);
    resultQs = Intel218Questions(minDistSF(i,:));
    Q2{i} = resultQs{1};
    Q3{i} = resultQs{2};
    Q4{i} = resultQs{3};
    Q5{i} = resultQs{4};
    Q6{i} = resultQs{5};
end
QStruct = struct('orig',Q1,'Q2',Q2, 'Q3', Q3, 'Q4', Q4, 'Q5', Q5, 'Q6', Q6);