function [QStructs,accs] = genAll()

%params
N=5;

%get ground truth
mostCorrSM = getGroundTruthQStruct(N); 

%generate Q structs for all participants
QStructs = cell(9,1);
accs = zeros(9,1);
for i=1:9
    
    %get min dist sf
    QStruct = runFeatureSim(i);
    QStructs{i} = QStruct;
    
    
    
end

save allQStructs.mat;