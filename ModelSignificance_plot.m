function Figure7b = ModelSignificance_plot(modelmetrics, CI)
%% Model significance

Figure7b = figure(3);
h = histfit(modelmetrics.modelsignificance, 25, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

title('Figure 7b')
xlabel('Significance (p-value)', 'FontWeight', 'bold')
xlim([0, (max(modelmetrics.modelsignificance)+(1/50*range(modelmetrics.modelsignificance)))])
hold on 


%% Confidence intervals

modelsignificance_ordered = sort(modelmetrics.modelsignificance);
% determines percent of CI
boundpercent = CI;
Btorow_exact = boundpercent*(length(modelsignificance_ordered));
Btorow_rounded = round(boundpercent*(length(modelsignificance_ordered)));

if Btorow_rounded < Btorow_exact
    x = Btorow_rounded;
    y = Btorow_rounded + 1;
    bound = mean(modelsignificance_ordered(x:y));
elseif Btorow_rounded == Btorow_exact
    bound = modelsignificance_ordered(Btorow_rounded);
else   
    x = Btorow_rounded;
    y = Btorow_rounded - 1;
    bound = mean(modelsignificance_ordered(y:x));
end 

%% Mean and CI added to hist

mediansig = median(modelsignificance_ordered);

xline(mediansig, 'Color', [0 0.4470 0.7410], 'LineWidth', 1);
xline(bound, '--k', 'LineWidth', 0.7);
xline(0.05, 'Color', [0.6350 0.0780 0.1840], 'LineWidth', 0.7);

%% Percentage below threshold
underthresh = zeros(length(modelsignificance_ordered), 1);
overthresh = zeros(length(modelsignificance_ordered), 1);
for i = 1:length(modelsignificance_ordered)
    if modelsignificance_ordered(i) < 0.05
        underthresh(i,:) = modelsignificance_ordered(i);
    else
        overthresh(i,:) = modelsignificance_ordered(i);
    end
end

% removes rows with zeros
underthresh = nonzeros(underthresh');
underthresh = reshape(underthresh, size(underthresh, 2), size(underthresh, 1))';

overthresh = nonzeros(overthresh');
overthresh = reshape(overthresh, size(overthresh, 2), size(overthresh,1))';
    
percentagebelowthresh_models = length(underthresh)/length(modelsignificance_ordered)*100;

%% Improve aesthetics

set(gcf,'color','w');
legend({'median','95% C.I. bound', 'sig. threshold'})
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
set(findall(legend,'-property','FontSize'),'FontSize',9)
hold off

end