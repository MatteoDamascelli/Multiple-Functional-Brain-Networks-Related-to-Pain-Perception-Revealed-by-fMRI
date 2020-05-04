function Figure7a =  RMSE_plot(Figure7a, modelmetrics, CI, yaxis_lim)
%% R2

subplot(1,3,3)
h = histfit(modelmetrics.modelRMSE, 20, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

xlabel('Root Mean Square Error', 'FontWeight', 'bold')%, ylabel('Frequency', 'FontWeight', 'bold')
xlim([(min(modelmetrics.modelRMSE)-(1/50*range(modelmetrics.modelRMSE))), (max(modelmetrics.modelRMSE)+(1/50*range(modelmetrics.modelRMSE)))])
ylim([0,yaxis_lim])
set(gca,'Yticklabel',[])
hold on 

%% Confidence intervals

RMSE_ordered = sort(modelmetrics.modelRMSE);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(RMSE_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(RMSE_ordered)));
UBtorow_exact = upperboundpercent*(length(RMSE_ordered));
UBtorow_rounded = round(upperboundpercent*(length(RMSE_ordered)));


if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerbound = mean(RMSE_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = RMSE_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(RMSE_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(RMSE_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = RMSE_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(RMSE_ordered(y:x));
end


%% Mean and CI added to hist

meanRMSE = mean(RMSE_ordered);

xline(meanRMSE, 'k', 'LineWidth', 1);
xline(lowerbound, '--k', 'LineWidth', 1, 'HandleVisibility', 'off');
xline(upperbound, '--k', 'LineWidth', 1);

%% Improve aesthetics

set(gcf,'color','w');
set(findall(gcf,'-property','FontName'),'FontName','Helvetica')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
hold off

end