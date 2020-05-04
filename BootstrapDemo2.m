function SupplementaryFigure1b = BootstrapDemo2(Sample)
%% Add predicted ratings

modelforfigure = fitlm(Sample, 'rating ~ 1 + C1 + C2 + C4');
Sample.predrating = modelforfigure.Fitted;

%% Create new variables: correct reject, hit, false alarm, miss

Sample.hit = zeros(height(Sample),1);
Sample.miss = zeros(height(Sample),1);
Sample.correctreject = zeros(height(Sample),1);
Sample.falsealarm = zeros(height(Sample),1);

for i = 1:height(Sample)
    if (Sample.rating(i)>100)&&(Sample.predrating(i)>100)
        Sample.hit(i) = 1;
    end
end
for i = 1:height(Sample)
    if (Sample.rating(i)>100)&&(Sample.predrating(i)<100)
        Sample.miss(i) = 1;
    end
end
for i = 1:height(Sample)
    if (Sample.rating(i)<100)&&(Sample.predrating(i)>100)
        Sample.falsealarm(i) = 1;
    end
end
for i = 1:height(Sample)
    if (Sample.rating(i)<100)&&(Sample.predrating(i)<100)
        Sample.correctreject(i) = 1;
    end
end

%% Predicted values: pain or no pain

Sample.painornopain_predicted = zeros(height(Sample),1);

for i = 1:height(Sample)
    if Sample.predrating(i)>100
        Sample.painornopain_predicted(i) = 1;
    end
end

%% Calculate percentages of each quantity

hit = (sum(Sample.hit))/size(Sample,1)*100;
miss = (sum(Sample.miss))/size(Sample,1)*100;
falsealarm = (sum(Sample.falsealarm))/size(Sample,1)*100;
correctreject = (sum(Sample.correctreject))/size(Sample,1)*100;


%% Calculate sensitivity, specificity as percentages

truepositiverate = sum(Sample.hit)/sum(Sample.painornopain_true)*100; % aka sensitivity, note: hit rate is recall for "in pain"
falsepositiverate = sum(Sample.falsealarm)/(height(Sample)-sum(Sample.painornopain_true))*100;
truenegativerate = sum(Sample.correctreject)/(height(Sample)-sum(Sample.painornopain_true))*100; % aka specificity, note: correct reject rate is recall for "not in pain"
falsenegativerate = sum(Sample.miss)/sum(Sample.painornopain_true)*100;

%% Supplementary figure 1b - tables

SupplementaryFigure1b = figure(7);
subplot(2,1,1)
scatter(-1,-1)
title('Supplementary Figure 1b')
xlim([0,200]), ylim([0,200])
set(gca,'Xticklabel',[])
set(gca,'Yticklabel',[])
set(gca,'Xtick',[])
set(gca,'Ytick',[])
xline(100, 'k')
yline(100, 'k')
hold on
txt1 = num2str(miss);
txt2 = num2str(hit);
txt3 = num2str(falsealarm);
txt4 = num2str(correctreject);
text(30,150,txt1, 'FontSize', 20, 'FontWeight', 'bold')
text(130,150,txt2, 'FontSize', 20, 'FontWeight', 'bold')
text(130,50,txt3, 'FontSize', 20, 'FontWeight', 'bold')
text(30,50,txt4, 'FontSize', 20, 'FontWeight', 'bold')
hold on

subplot(2,1,2)
scatter(-1,-1)
title('Supplementary Figure 1c')
xlim([0,200]), ylim([0,200])
set(gca,'Xticklabel',[])
set(gca,'Yticklabel',[])
set(gca,'Xtick',[])
set(gca,'Ytick',[])
xline(100, 'k')
yline(100, 'k')
hold on
txt1 = num2str(falsenegativerate);
txt2 = num2str(truepositiverate);
txt3 = num2str(falsepositiverate);
txt4 = num2str(truenegativerate);
text(30,150,txt1, 'FontSize', 20, 'FontWeight', 'bold')
text(130,150,txt2, 'FontSize', 20, 'FontWeight', 'bold')
text(130,50,txt3,'FontSize', 20, 'FontWeight', 'bold')
text(30,50,txt4, 'FontSize', 20, 'FontWeight', 'bold')
hold off

end