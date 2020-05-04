function Figure9 = Sensitivity_plot(modelmetrics, CI, yaxis_lim)
%% Sensitivity

Figure9 = figure(5);
subplot(1,3,2)
h = histfit(modelmetrics.truepositiverate, 12, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

xlabel('Sensitivity (%)', 'FontWeight', 'bold')
xlim([min(modelmetrics.truepositiverate)-3, max(modelmetrics.truepositiverate)+3])
ylim([0,yaxis_lim])
set(gca,'Yticklabel',[])
hold on 


%% Confidence intervals

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
    lowerbound = mean(sensitivity_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = sensitivity_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(sensitivity_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(sensitivity_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = sensitivity_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(sensitivity_ordered(y:x));
end

%% Mean and CI added to hist

meansens = mean(sensitivity_ordered);

xline(meansens, 'k', 'LineWidth', 1);
xline(lowerbound, '--k', 'LineWidth', 1);
xline(upperbound, '--k', 'LineWidth', 1);

%% Improve aesthetics

set(gcf,'color','w');
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
hold off

end