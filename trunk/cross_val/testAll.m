function accs = testAll()

%struct
accs = zeros(9,1);
Result_exp_all = cell(9,1);

%do l2cv for each participant
for i=1:9
    
    %load participant params
    [X,F, pRankedVoxels] = loadNewData(i);
    
    %test
    [acc,Result_exp_all_p] = l2cv_new(X,F,pRankedVoxels, 2, 1);
    
    %store
    accs(i) = acc;
    Result_exp_all{i} = Result_exp_all_p;
    
end

save allCVData.mat;