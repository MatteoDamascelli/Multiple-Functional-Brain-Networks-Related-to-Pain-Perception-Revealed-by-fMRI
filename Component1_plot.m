function Figure8b = Component1_plot(Figure8b, modelmetrics, CI, yaxis_lim)
%% Component 1 coef

subplot(1,3,1)
h = histfit(modelmetrics.component1coef, 20, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

sgtitle('Figure 8b', 'FontWeight', 'bold')
xlabel('Estimated slope parameter', 'FontWeight', 'bold'), ylabel('Frequency', 'FontWeight', 'bold')
ylim([0,yaxis_lim])
hold on 


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
    lowerbound = mean(component1coef_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = component1coef_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(component1coef_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(component1coef_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = component1coef_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(component1coef_ordered(y:x));
end

%% Mean and CI added to hist

meancomponent1coef = mean(component1coef_ordered);

xline(meancomponent1coef, 'k', 'LineWidth', 1);
xline(lowerbound, '--k', 'LineWidth', 1);
xline(upperbound, '--k', 'LineWidth', 1);

%% Improve aesthetics

set(gcf,'color','w');
legend({'mean','95% C.I. bounds'})
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
set(findall(legend,'-property','FontSize'),'FontSize',9)
hold off

end