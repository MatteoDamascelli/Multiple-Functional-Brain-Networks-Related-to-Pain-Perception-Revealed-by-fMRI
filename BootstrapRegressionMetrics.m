function modelmetrics = BootstrapRegressionMetrics(Data, numberofsamples)
%% Sort table in ascending order by subject
Data = sortrows(Data, 1);

%% Bootstrapping

modelmetrics = zeros(numberofsamples,40);

for j = 1:numberofsamples
    %% Create sample
    
    % pick random row of data from each participant (i.e. each participant
    % contributes high or low temp values to each bootstrap sample, picked
    % at random)
    sample_1 = zeros(62,7);
    for i = 1:62
        if rem(i,2) == 0
            tempsample = [(i-1) Data.subject(i-1)   Data.rating(i-1)   Data.C1(i-1)   Data.C2(i-1)   Data.C3(i-1)   Data.C4(i-1);
                i     Data.subject(i)     Data.rating(i)     Data.C1(i)     Data.C2(i)     Data.C3(i)     Data.C4(i)];
            
            y = datasample(tempsample(:,1),1);
            if rem(y,2) == 0
                sample_1(i,:) = tempsample((i-(i-2)),:);
            else
                sample_1(i,:) = tempsample((i-(i-1)),:);
            end
        else
            sample_1(i,:) = sample_1(i,:);
        end
    end
    
    % removes rows with zeros
    sample_2 = nonzeros(sample_1');
    sample_2 = reshape(sample_2,7,31)';
    
    % adds "pain vs no pain" categorical variable
    sample_3 = zeros(31,8);
    for i = 1:31
        if sample_2(i,3) > 100 % if the pain rating in row i of sample_2 is greater than 100...
            sample_vector = [sample_2(i,:) 1]; % add a 1 to the end of that row vector (1 means pain)
        else % otherwise...
            sample_vector = [sample_2(i,:) 0]; % add a 0 to the end of that row vector (0 means no pain)
        end
        sample_3(i,:) = sample_vector; % add the current row vector to to row i of sample_3
    end
    
    % changes first column to "high vs low" categorical variable
    sample_4 = zeros(31,8);
    for i = 1:31
        if rem(sample_3(i,1),2) == 0 % if the value in column one, row i of sample_3 is even...
            sample_vector = [0 sample_3(i,2:end)]; % add a 0 (meaning low temp) to the start of that row vector
        else % otherwise...
            sample_vector = [1 sample_3(i,2:end)]; % add a 1 (meaning high temp) to the start of that row vector
        end
        sample_4(i,:) = sample_vector; % replace row i of sample_4 with that new row vector
    end
    
    % convert to table
    Sample = array2table(sample_4, 'VariableNames', {'temp' 'subject' 'rating' 'C1' 'C2' 'C3' 'C4' 'painornopain_true'});
    
    % delete unneeded variables
    clear i tempsample y sample_vector sample_1 sample_2 sample_3 sample_4
    
    %% Fit model
    
    model = fitlm(Sample, 'rating ~ C1 + C2 + C4');
    
    [yhat, yci] = predict(model);
    Sample.predrating = yhat;
    
    %% Keep track of F tests for model significance
    
    anovatable = anova(model, 'summary');
    modelsignificance = anovatable.pValue(2);
    
    %% Keep track of R2 values
    
    R2 = model.Rsquared.Ordinary;
    adjustedR2 = model.Rsquared.Adjusted;
    
    %% Keep track of model coefficients
    
    intercept = model.Coefficients.Estimate(1);
    component1coef = model.Coefficients.Estimate(2);
    component2coef = model.Coefficients.Estimate(3);
    component4coef = model.Coefficients.Estimate(4);
    
    intercept_SE = model.Coefficients.SE(1);
    component1coef_SE = model.Coefficients.SE(2);
    component2coef_SE = model.Coefficients.SE(3);
    component4coef_SE = model.Coefficients.SE(4);
    
    intercept_tvalue = model.Coefficients.tStat(1);
    component1coef_tvalue = model.Coefficients.tStat(2);
    component2coef_tvalue = model.Coefficients.tStat(3);
    component4coef_tvalue = model.Coefficients.tStat(4);
    
    intercept_pvalue = model.Coefficients.pValue(1);
    component1coef_pvalue = model.Coefficients.pValue(2);
    component2coef_pvalue = model.Coefficients.pValue(3);
    component4coef_pvalue = model.Coefficients.pValue(4);
    
    %% Calculate betas
    
    Samplebeta = Sample{:,{'rating','C1','C2','C4'}};
    Samplebetaresponse = zscore(Samplebeta(:,1));
    Samplebetapredictors = zscore(Samplebeta(:,2:4));
    
    C = (Samplebetapredictors'*Samplebetapredictors)\(Samplebetapredictors'*Samplebetaresponse);
    
    component1beta = C(1,:);
    component2beta = C(2,:);
    component4beta = C(3,:);
    
    %% Keep track of RMSE
    
    modelRMSE = model.RMSE;
    
    %% Create new variables: correct reject, hit, false alarm, miss
    
    Sample.hit = zeros(height(Sample),1);
    Sample.miss = zeros(height(Sample),1);
    Sample.correctreject = zeros(height(Sample),1);
    Sample.falsealarm = zeros(height(Sample),1);
    
    for i = 1:height(Sample)
        if (Sample.rating(i)>100)&&(Sample.predrating(i)>100)
            Sample.hit(i) = 1;
        end
    end
    for i = 1:height(Sample)
        if (Sample.rating(i)>100)&&(Sample.predrating(i)<100)
            Sample.miss(i) = 1;
        end
    end
    for i = 1:height(Sample)
        if (Sample.rating(i)<100)&&(Sample.predrating(i)>100)
            Sample.falsealarm(i) = 1;
        end
    end
    for i = 1:height(Sample)
        if (Sample.rating(i)<100)&&(Sample.predrating(i)<100)
            Sample.correctreject(i) = 1;
        end
    end
    
    %% pain or no pain predicted
    
    Sample.painornopain_predicted = zeros(height(Sample),1);
    
    for i = 1:height(Sample)
        if Sample.predrating(i)>100
            Sample.painornopain_predicted(i) = 1;
        end
    end
    
    %% calculate percentages of each
    
    hit = sum(Sample.hit)/size(Sample,1);
    miss = sum(Sample.miss)/size(Sample,1);
    falsealarm = sum(Sample.falsealarm)/size(Sample,1);
    correctreject = sum(Sample.correctreject)/size(Sample,1);
    
    painprevalence = sum(Sample.painornopain_true)/size(Sample,1);
    predictedpainprevalence = sum(Sample.painornopain_predicted)/size(Sample,1);
    accuracy = (hit + correctreject)*100; % accuracy
    precentageincorrect = (miss + falsealarm)*100;
    
    %% calculate precision and recall
    
    truepositiverate = sum(Sample.hit)/sum(Sample.painornopain_true)*100; % aka sensitivity, note: hit rate is recall for "in pain"
    falsepositiverate = sum(Sample.falsealarm)/(height(Sample)-sum(Sample.painornopain_true))*100;
    truenegativerate = sum(Sample.correctreject)/(height(Sample)-sum(Sample.painornopain_true))*100; % aka specificity, note: correct reject rate is recall for "not in pain"
    falsenegativerate = sum(Sample.miss)/sum(Sample.painornopain_true)*100;
    
    positivepredictivevalue = sum(Sample.hit)/sum(Sample.painornopain_predicted)*100; % aka precision for "in pain"
    falsediscoveryrate = sum(Sample.falsealarm)/sum(Sample.painornopain_predicted)*100;
    negativepredictivevalue = sum(Sample.correctreject)/(height(Sample)-sum(Sample.painornopain_predicted))*100; % aka precision for "not in pain"
    falseomissionrate = sum(Sample.miss)/(height(Sample)-sum(Sample.painornopain_predicted))*100;
    
    %% F1 score
    
    F1score = 2*(positivepredictivevalue*truepositiverate)/(positivepredictivevalue+truepositiverate);
    
    %% generating row of performance metrics
    
    modelmetrics(j,:) = [hit miss falsealarm correctreject painprevalence predictedpainprevalence accuracy precentageincorrect truepositiverate falsepositiverate truenegativerate falsenegativerate positivepredictivevalue falsediscoveryrate negativepredictivevalue falseomissionrate F1score modelsignificance R2 adjustedR2 modelRMSE intercept intercept_SE intercept_tvalue intercept_pvalue component1coef component1coef_SE component1beta component1coef_tvalue component1coef_pvalue component2coef component2coef_SE component2beta component2coef_tvalue component2coef_pvalue component4coef component4coef_SE component4beta component4coef_tvalue component4coef_pvalue];
    
end

clearvars -except modelmetrics Data
modelmetrics = array2table(modelmetrics, 'VariableNames', {'hit' 'miss' 'falsealarm' 'correctreject' 'painprevalence' 'predictedpainprevalence' 'accuracy' 'precentageincorrect' 'truepositiverate' 'falsepositiverate' 'truenegativerate' 'falsenegativerate' 'positivepredictivevalue' 'falsediscoveryrate' 'negativepredictivevalue' 'falseomissionrate' 'F1score' 'modelsignificance' 'R2' 'adjustedR2' 'modelRMSE' 'intercept' 'interceptSE' 'interceptTvalue' 'interceptPvalue' 'component1coef' 'component1coefSE' 'component1beta' 'component1coefTvalue' 'component1coefPvalue' 'component2coef' 'component2coefSE' 'component2beta' 'component2coefTvalue' 'component2coefPvalue' 'component4coef' 'component4coefSE' 'component4beta' 'component4coefTvalue' 'component4coefPvalue'});

modelmetrics(modelmetrics.painprevalence < 0.45 | modelmetrics.painprevalence > 0.55, :) = [];

end