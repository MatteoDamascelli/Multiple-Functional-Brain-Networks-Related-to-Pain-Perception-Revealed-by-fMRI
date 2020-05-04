%% import data

Data = importfile("RatingNetworkData_highlowtemp.csv");

%% WITHIN-SUBJECT PAIN
%% run linear regression on change scores

DataChangeScores = GetChangeScores(Data);
Table1 = GetTable1(DataChangeScores);

%% Figure 5 - predicted changes vs true changes

Figure6 = TrueVsPredicted_changescores(DataChangeScores);

%% BETWEEN-SUBJECT PAIN
%% run bootstrapped regression

numberofsamples = str2double('750'); %<--- enter number of bootstrap samples to draw 
modelmetrics = BootstrapRegressionMetrics(Data, numberofsamples);

%% tables

CI = str2double('0.95'); %<--- enter CI interval as decimal
Table2 = Table2_bootstrapcoefficients(modelmetrics, CI);

SupplementaryTable4 = Table_Descriptives(Data);
SupplementaryTable5 = Table_BootstrappedModelSummary(modelmetrics, CI);
SupplementaryTable6 = Table_ClassifierEstimates(modelmetrics, CI);

%% Figure 7 - R2, adjusted R2, RMSE

CI = str2double('0.95'); %<--- enter CI interval as decimal
yaxis_lim = str2double('50'); %<--- enter desired upper y axis limit

Figure7a = adjustedR2_plot(modelmetrics, CI, yaxis_lim);
Figure7a = RMSE_plot(Figure7a, modelmetrics, CI, yaxis_lim);
Figure7a = R2_plot(Figure7a, modelmetrics, CI, yaxis_lim);

%% Figure 7 - model significance

CI = str2double('0.95'); %<--- enter CI interval as decimal

Figure7b = ModelSignificance_plot(modelmetrics, CI);

%% Figure 8b - component coefficients

CI = str2double('0.95'); %<--- enter CI interval as decimal
yaxis_lim = str2double('55'); %<--- enter desired upper y axis limit

Figure8b = Component2_plot(modelmetrics, CI, yaxis_lim);
Figure8b = Component4_plot(Figure8b, modelmetrics, CI, yaxis_lim);
Figure8b = Component1_plot(Figure8b, modelmetrics, CI, yaxis_lim);

%% Figure 9 - accuracy, sensitivity, specificity

CI = str2double('0.95'); %<--- enter CI interval as decimal
yaxis_lim = str2double('75'); %<--- enter desired upper y axis limit

Figure9 = Sensitivity_plot(modelmetrics, CI, yaxis_lim);
Figure9 = Specificity_plot(Figure9, modelmetrics, CI, yaxis_lim);
Figure9 = Accuracy_plot(Figure9, modelmetrics, CI, yaxis_lim);

%% Supplementary figure 1 - classification

Sample = SampleForBootstrapping(Data);
PainPrevalence = sum(Sample.painornopain_true)/height(Sample);

SupplementaryFigure1a = BootstrapDemo1(Sample);
SupplementaryFigure1b = BootstrapDemo2(Sample);
