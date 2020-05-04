function Figure9 = Accuracy_plot(Figure9, modelmetrics, CI, yaxis_lim)
%% Accuracy
 
subplot(1,3,1)
h = histfit(modelmetrics.accuracy, 12, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

sgtitle('Figure 9', 'FontWeight', 'bold')
xlabel('Accuracy (%)', 'FontWeight', 'bold'), ylabel('Frequency', 'FontWeight', 'bold')
xlim([min(modelmetrics.accuracy)-3, max(modelmetrics.accuracy)+3])
ylim([0,yaxis_lim])
hold on 

%% Confidence intervals

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
    lowerbound = mean(accuracy_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = accuracy_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(accuracy_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(accuracy_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = accuracy_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(accuracy_ordered(y:x));
end


%% Mean and CI added to hist

meanacc = mean(accuracy_ordered);

xline(meanacc, 'k', 'LineWidth', 1);
xline(lowerbound, '--k', 'LineWidth', 1, 'HandleVisibility', 'off');
xline(upperbound, '--k', 'LineWidth', 1);

%% Improve aesthetics

set(gcf,'color','w');
legend({'mean','95% C.I. bounds'})
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
set(findall(legend,'-property','FontSize'),'FontSize',9)
hold off

end