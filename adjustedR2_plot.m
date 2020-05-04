function Figure7a = adjustedR2_plot(modelmetrics, CI, yaxis_lim)
%% R2
Figure7a = figure(2);
subplot(1,3,2)
h = histfit(modelmetrics.adjustedR2, 20, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

xlabel('Adjusted R-Squared', 'FontWeight', 'bold')%, ylabel('Frequency', 'FontWeight', 'bold')
xlim([(min(modelmetrics.adjustedR2)-(1/50*range(modelmetrics.adjustedR2))), (max(modelmetrics.adjustedR2)+(1/50*range(modelmetrics.adjustedR2)))])
ylim([0,yaxis_lim])
set(gca,'Yticklabel',[])
hold on 


%% Confidence intervals

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
    lowerbound = mean(adjustedR2_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = adjustedR2_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(adjustedR2_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(adjustedR2_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = adjustedR2_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(adjustedR2_ordered(y:x));
end


%% Mean and CI added to hist

meanadjustedR2 = mean(adjustedR2_ordered);

xline(meanadjustedR2, 'k', 'LineWidth', 1);
xline(lowerbound, '--k', 'LineWidth', 1, 'HandleVisibility', 'off');
xline(upperbound, '--k', 'LineWidth', 1);

%% Improve aesthetics

set(gcf,'color','w');
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
hold off

end