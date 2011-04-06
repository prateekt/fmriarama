function metric = compareQStructs(Q_test,Q_gt, metricChoice)

%see if any question in Q_test exists in Q_gt
if(metricChoice==1)
    cnt = 0;
    for i=1:218

        %convert structs to sets
        Q_test_current = {Q_test(i).Q2,Q_test(i).Q3,Q_test(i).Q4,Q_test(i).Q5,Q_test(i).Q6};
        Q_gt_current = {Q_gt(i).Q2,Q_gt(i).Q3,Q_gt(i).Q4,Q_gt(i).Q5,Q_gt(i).Q6};
        Q_test_current
        Q_gt_current

        contains=false;
        for j=1:length(Q_test_current)
            currentQ = Q_test_current(j);
            for k=1:length(Q_gt_current)

                currentQ_gt = Q_gt_current(k);
                if(strcmp(currentQ,currentQ_gt)==1)
                    contains = true;
                    break;
                end
            end
            if(contains)
                break;
            end
        end

        if(contains)
            cnt = cnt + 1;
        end
    end
    metric = cnt / 218;
end

if(metricChoice==2)
    cnt = 0;
    for i=1:218

        %convert structs to sets
        Q_test_current = Q_test(i,:);
        Q_gt_current = Q_gt(i,:);

        contains=false;
        for j=1:length(Q_test_current)
            currentQ = Q_test_current(j);
            for k=1:length(Q_gt_current)

                currentQ_gt = Q_gt_current(k);
                if(currentQ==currentQ_gt)
                    contains = true;
                    break;
                end
            end
            if(contains)
                break;
            end
        end

        if(contains)
            cnt = cnt + 1;
        end
    end
    metric = cnt / 218;
end