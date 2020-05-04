function SupplementaryTable5 = Table_BootstrappedModelSummary(modelmetrics, CI)
%% Table (model summary for bootstrapped model
%% Calculate bounds

% R2
R2_ordered = sort(modelmetrics.R2);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(R2_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(R2_ordered)));
UBtorow_exact = upperboundpercent*(length(R2_ordered));
UBtorow_rounded = round(upperboundpercent*(length(R2_ordered)));


if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundR2 = mean(R2_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundR2 = R2_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundR2 = mean(R2_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundR2 = mean(R2_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundR2 = R2_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundR2 = mean(R2_ordered(y:x));
end

% adjusted R2

adjustedR2_ordered = sort(modelmetrics.adjustedR2);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(adjustedR2_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(adjustedR2_ordered)));
UBtorow_exact = upperboundpercent*(length(adjustedR2_ordered));
UBtorow_rounded = round(upperboundpercent*(length(adjustedR2_ordered)));


if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundadjustedR2 = mean(adjustedR2_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundadjustedR2 = adjustedR2_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundadjustedR2 = mean(adjustedR2_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundadjustedR2 = mean(adjustedR2_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundadjustedR2 = adjustedR2_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundadjustedR2 = mean(adjustedR2_ordered(y:x));
end

% RMSE

modelRMSE_ordered = sort(modelmetrics.modelRMSE);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(modelRMSE_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(modelRMSE_ordered)));
UBtorow_exact = upperboundpercent*(length(modelRMSE_ordered));
UBtorow_rounded = round(upperboundpercent*(length(modelRMSE_ordered)));


if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundRMSE = mean(modelRMSE_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundRMSE = modelRMSE_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundRMSE = mean(modelRMSE_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundRMSE = mean(modelRMSE_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundRMSE = modelRMSE_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundRMSE = mean(modelRMSE_ordered(y:x));
end

%% Create table

empty = {'Average bootstrap estimate';
         'CI95%'};
text1 = {'(' num2str(lowerboundR2) ',' num2str(upperboundR2) ')'};
R2 = {mean(modelmetrics.R2);
      text1};
text2 = {'(' num2str(lowerboundadjustedR2) ',' num2str(upperboundadjustedR2) ')'};
AdjustedR2 = {mean(modelmetrics.adjustedR2);
             text2};
text3 = {'(' num2str(lowerboundRMSE) ',' num2str(upperboundRMSE) ')'};
RMSE = {mean(modelmetrics.modelRMSE);
        text3};

SupplementaryTable5 = table(empty, R2, AdjustedR2, RMSE);

end