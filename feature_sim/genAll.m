function [QStructs,accs] = genAll()

%params
L=10;
M=100;
N=10;

%get ground truth
mostCorrSM = getGroundTruthQStruct(N); 

%generate Q structs for all participants
QStructs = cell(9,1);
accs = zeros(9,1);
originalCounts = cell(9,1);
for i=1:9
    
    %get min dist sf
    [QStruct,originalCount] = runFeatureSim(i,L,M,N);
    QStructs{i} = QStruct;
    originalCounts{i} = originalCount;
    
    %compute acc
    metric = compareQStructs(QStruct,mostCorrSM, 2);
    accs(i) = metric;
    
end

save allOriginalCountsM100.mat;