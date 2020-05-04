function Figure7a = R2_plot(Figure7a, modelmetrics, CI, yaxis_lim)
%% R2

subplot(1,3,1)
h = histfit(modelmetrics.R2, 20, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

sgtitle('Figure 7a', 'FontWeight', 'bold')
xlabel('R-Squared', 'FontWeight', 'bold'), ylabel('Frequency', 'FontWeight', 'bold')
xlim([(min(modelmetrics.R2)-(1/50*range(modelmetrics.R2))), (max(modelmetrics.R2)+(1/50*range(modelmetrics.R2)))])
ylim([0,yaxis_lim])
hold on 

%% Confidence intervals

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
    lowerbound = mean(R2_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = R2_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(R2_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(R2_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = R2_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(R2_ordered(y:x));
end


%% Mean and CI added to hist

meanR2 = mean(R2_ordered);

xline(meanR2, 'k', 'LineWidth', 1);
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