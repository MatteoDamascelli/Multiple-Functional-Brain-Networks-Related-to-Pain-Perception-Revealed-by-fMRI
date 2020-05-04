function Figure9 = Specificity_plot(Figure9, modelmetrics, CI, yaxis_lim)
%% Specificity

subplot(1,3,3)
h = histfit(modelmetrics.truenegativerate, 12, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

xlabel('Specificity (%)', 'FontWeight', 'bold')
xlim([min(modelmetrics.truenegativerate)-3, max(modelmetrics.truenegativerate)+3])
ylim([0,yaxis_lim])
set(gca,'Yticklabel',[])
hold on 


%% Confidence intervals

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
    lowerbound = mean(specificity_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = specificity_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(specificity_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(specificity_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = specificity_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(specificity_ordered(y:x));
end


%% mean and CI added to hist

meanspec = mean(specificity_ordered);

xline(meanspec, 'k', 'LineWidth', 1);
xline(lowerbound, '--k', 'LineWidth', 1);
xline(upperbound, '--k', 'LineWidth', 1);

%% Improve aesthetics

set(gcf,'color','w');
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
hold off

end