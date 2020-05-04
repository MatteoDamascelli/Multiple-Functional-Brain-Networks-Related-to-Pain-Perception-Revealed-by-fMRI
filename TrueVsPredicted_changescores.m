function Figure6 = TrueVsPredicted_changescores(DataChangeScores)
%% Scatterplot - true change vs predicted change in ratings

model = fitlm(DataChangeScores, 'changeinrating ~ changeinC1 + changeinC2 + changeinC4 + 1');
DataChangeScores.predchange = model.Fitted;

Figure6 = figure(1);
scatter(DataChangeScores.predchange, DataChangeScores.changeinrating, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [0.85 0.85 0.85])
title('Figure 6')
xlabel('Predicted change in ratings (200-point VAS)', 'FontWeight', 'bold'), ylabel('True change in ratings (200-point VAS)', 'FontWeight', 'bold')
xlim([(min(DataChangeScores.predchange)-0.1*range(DataChangeScores.predchange)),(max(DataChangeScores.predchange)+0.1*range(DataChangeScores.predchange))])
ylim([(min(DataChangeScores.changeinrating)-0.1*range(DataChangeScores.changeinrating)),(max(DataChangeScores.changeinrating)+0.1*range(DataChangeScores.changeinrating))])
set(gcf,'color','white');
set(gca,'color','white');
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
hold on

h = lsline;
h.Color = 'k';

[R, P] = corrcoef(DataChangeScores.predchange, DataChangeScores.changeinrating);
txt = ['r = ' num2str(R(2,1)) ', p = ' num2str(P(2,1))];
text(min(DataChangeScores.predchange),max(DataChangeScores.changeinrating),txt)
hold off

end