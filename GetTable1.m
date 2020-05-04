function Table1 = GetTable1(DataChangeScores)
%% Fit linear model

model = fitlm(DataChangeScores, 'changeinrating ~ changeinC1 + changeinC2 + changeinC4 + 1');
DataComponents = zscore([ones(31,1) DataChangeScores.changeinC1 DataChangeScores.changeinC2 DataChangeScores.changeinC4],1);
DataRating = zscore(DataChangeScores.changeinrating,1);
b = regress(DataRating,DataComponents);

Table1 = array2table(cat(2, table2array(model.Coefficients),b));
Table1.Properties.VariableNames = {'Estimate' 'SE' 'tStat' 'pValue' 'beta'};
Table1.Properties.RowNames = {'(intercept)' 'changeinC1' 'changeinC2' 'changeinC4'};

end