function SupplementaryFigure1a = BootstrapDemo1(Sample)
%% Supplementary figure 1a - scatterplot of true vs predicted ratings

modelforfigure = fitlm(Sample, 'rating ~ 1 + C1 + C2 + C4');
Sample.predrating = modelforfigure.Fitted;

SupplementaryFigure1a = figure(6);
scatter(Sample.predrating, Sample.rating, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [0.85 0.85 0.85])
title('Supplementary Figure 1a')
xlabel('Predicted ratings (200-point VAS)', 'FontWeight', 'bold'), ylabel('True ratings (200-point VAS)', 'FontWeight', 'bold')
xlim([0,200])
ylim([0,200])
xline(100, '--k')
yline(100, '--k')
set(gcf,'color','white');
set(gca,'color','white');
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)

end