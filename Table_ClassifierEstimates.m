function SupplementaryTable6 = Table_ClassifierEstimates(modelmetrics, CI)
%% Table (bootstrapped accuracy, sensitivity, specificity)
%% Calculate bounds

% accuracy
accuracy_ordered = sort(modelmetrics.accuracy);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(accuracy_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(accuracy_ordered)));
UBtorow_exact = upperboundpercent*(length(accuracy_ordered));
UBtorow_rounded = round(upperboundpercent*(length(accuracy_ordered)));


if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundacc = mean(accuracy_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundacc = accuracy_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundacc = mean(accuracy_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundacc = mean(accuracy_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundacc = accuracy_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundacc = mean(accuracy_ordered(y:x));
end

% sensitivity
sensitivity_ordered = sort(modelmetrics.truepositiverate);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(sensitivity_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(sensitivity_ordered)));
UBtorow_exact = upperboundpercent*(length(sensitivity_ordered));
UBtorow_rounded = round(upperboundpercent*(length(sensitivity_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundsens = mean(sensitivity_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundsens = sensitivity_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundsens = mean(sensitivity_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundsens = mean(sensitivity_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundsens = sensitivity_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundsens = mean(sensitivity_ordered(y:x));
end

% specificity
specificity_ordered = sort(modelmetrics.truenegativerate);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(specificity_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(specificity_ordered)));
UBtorow_exact = upperboundpercent*(length(specificity_ordered));
UBtorow_rounded = round(upperboundpercent*(length(specificity_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundspec = mean(specificity_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundspec = specificity_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundspec = mean(specificity_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundspec = mean(specificity_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundspec = specificity_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundspec = mean(specificity_ordered(y:x));
end


%% Create table

empty = {'Average bootstrap estimate';
         'CI95%'};
text1 = {'(' num2str(lowerboundacc) ',' num2str(upperboundacc) ')'};
Accuracy = {mean(modelmetrics.accuracy);
            text1};
text2 = {'(' num2str(lowerboundsens) ',' num2str(upperboundsens) ')'};
Sensitivity = {mean(modelmetrics.truepositiverate);
               text2};
text3 = {'(' num2str(lowerboundspec) ',' num2str(upperboundspec) ')'};
Specificity = {mean(modelmetrics.truenegativerate);
               text3};

SupplementaryTable6 = table(empty, Accuracy, Sensitivity, Specificity);

end