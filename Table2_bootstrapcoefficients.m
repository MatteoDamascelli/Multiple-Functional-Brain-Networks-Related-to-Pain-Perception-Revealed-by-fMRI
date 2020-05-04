function Table2 = Table2_bootstrapcoefficients(modelmetrics, CI)
%% Confidence intervals 

intercept_ordered = sort(modelmetrics.intercept);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(intercept_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(intercept_ordered)));
UBtorow_exact = upperboundpercent*(length(intercept_ordered));
UBtorow_rounded = round(upperboundpercent*(length(intercept_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundi = mean(intercept_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundi = intercept_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundi = mean(intercept_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundi = mean(intercept_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundi = intercept_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundi = mean(intercept_ordered(y:x));
end

%% Confidence intervals 

component1coef_ordered = sort(modelmetrics.component1coef);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(component1coef_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(component1coef_ordered)));
UBtorow_exact = upperboundpercent*(length(component1coef_ordered));
UBtorow_rounded = round(upperboundpercent*(length(component1coef_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundC1 = mean(component1coef_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundC1 = component1coef_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundC1 = mean(component1coef_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundC1 = mean(component1coef_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundC1 = component1coef_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundC1 = mean(component1coef_ordered(y:x));
end

%% Confidence intervals 

component2coef_ordered = sort(modelmetrics.component2coef);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(component2coef_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(component2coef_ordered)));
UBtorow_exact = upperboundpercent*(length(component2coef_ordered));
UBtorow_rounded = round(upperboundpercent*(length(component2coef_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundC2 = mean(component2coef_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundC2 = component2coef_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundC2 = mean(component2coef_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundC2 = mean(component2coef_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundC2 = component2coef_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundC2 = mean(component2coef_ordered(y:x));
end

%% Confidence intervals 

component4coef_ordered = sort(modelmetrics.component4coef);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(component4coef_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(component4coef_ordered)));
UBtorow_exact = upperboundpercent*(length(component4coef_ordered));
UBtorow_rounded = round(upperboundpercent*(length(component4coef_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundC4 = mean(component4coef_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundC4 = component4coef_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundC4 = mean(component4coef_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundC4 = mean(component4coef_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundC4 = component4coef_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundC4 = mean(component4coef_ordered(y:x));
end

%% Confidence intervals for betas 

component1beta_ordered = sort(modelmetrics.component1beta);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(component1beta_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(component1beta_ordered)));
UBtorow_exact = upperboundpercent*(length(component1beta_ordered));
UBtorow_rounded = round(upperboundpercent*(length(component1beta_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundC1beta = mean(component1beta_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundC1beta = component1beta_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundC1beta = mean(component1beta_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundC1beta = mean(component1beta_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundC1beta = component1beta_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundC1beta = mean(component1beta_ordered(y:x));
end

%% Confidence intervals 

component2beta_ordered = sort(modelmetrics.component2beta);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(component2beta_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(component2beta_ordered)));
UBtorow_exact = upperboundpercent*(length(component2beta_ordered));
UBtorow_rounded = round(upperboundpercent*(length(component2beta_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundC2beta = mean(component2beta_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundC2beta = component2beta_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundC2beta = mean(component2beta_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundC2beta = mean(component2beta_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundC2beta = component2beta_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundC2beta = mean(component2beta_ordered(y:x));
end

%% Confidence intervals 

component4beta_ordered = sort(modelmetrics.component4beta);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(component4beta_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(component4beta_ordered)));
UBtorow_exact = upperboundpercent*(length(component4beta_ordered));
UBtorow_rounded = round(upperboundpercent*(length(component4beta_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerboundC4beta = mean(component4beta_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerboundC4beta = component4beta_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerboundC4beta = mean(component4beta_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperboundC4beta = mean(component4beta_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperboundC4beta = component4beta_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperboundC4beta = mean(component4beta_ordered(y:x));
end

%% Create table with Coefficients and CIs

empty = {'Average bootstrap estimate';
         'Bootstrap standard error';
         'Percentile Confidence Interval (95%)'
         'beta estimate';
         'beta SE';
         'beta interval'};
text1 = {'(' num2str(lowerboundi) ',' num2str(upperboundi) ')'};
Constant = {mean(modelmetrics.intercept);
            std(modelmetrics.intercept);
            text1;
            'na';
            'na';
            'na'};
text2 = {'(' num2str(lowerboundC1) ',' num2str(upperboundC1) ')'};
text2beta = {'(' num2str(lowerboundC1beta) ',' num2str(upperboundC1beta) ')'};
Component1 = {mean(modelmetrics.component1coef);
              std(modelmetrics.component1coef);
              text2;
              mean(modelmetrics.component1beta);
              std(modelmetrics.component1beta);
              text2beta};
text3 = {'(' num2str(lowerboundC2) ',' num2str(upperboundC2) ')'};
text3beta = {'(' num2str(lowerboundC2beta) ',' num2str(upperboundC2beta) ')'};
Component2 = {mean(modelmetrics.component2coef);
              std(modelmetrics.component2coef);
              text3;
              mean(modelmetrics.component2beta);
              std(modelmetrics.component2beta);
              text3beta};
text4 = {'(' num2str(lowerboundC4) ',' num2str(upperboundC4) ')'};
text4beta = {'(' num2str(lowerboundC4beta) ',' num2str(upperboundC4beta) ')'};
Component4 = {mean(modelmetrics.component4coef);
              std(modelmetrics.component4coef); 
              text4;
              mean(modelmetrics.component4beta);
              std(modelmetrics.component4beta);
              text4beta};

Table2 = table(empty, Constant, Component1, Component2, Component4);

end