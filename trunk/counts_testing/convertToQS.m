function QS = convertToQS(indexStruct)

load Intel218Questions.mat;
Q1 = cell(218,1);
Q2 = cell(218,1);
Q3 = cell(218,1);
Q4 = cell(218,1);
Q5 = cell(218,1);
Q6 = cell(218,1);
for i=1:218
    Q1{i} = Intel218Questions(i);
    resultQs = Intel218Questions(indexStruct(i,:));
    Q2{i} = resultQs{1};
    Q3{i} = resultQs{2};
    Q4{i} = resultQs{3};
    Q5{i} = resultQs{4};
    Q6{i} = resultQs{5};
end
QS = struct('orig',Q1,'Q2',Q2, 'Q3', Q3, 'Q4', Q4, 'Q5', Q5, 'Q6', Q6);
