function QStructs = genAll()

%generate Q structs for all participants
QStructs = cell(9,1);
for i=1:9
    QStruct = runFeatureSim(i);
    QStructs{i} = QStruct;
end

save allQStructs.mat;