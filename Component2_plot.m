function Figure8b = Component2_plot(modelmetrics, CI, yaxis_lim)
%% Component 2 coef

Figure8b = figure(4); 
subplot(1,3,2)
h = histfit(modelmetrics.component2coef, 20, 'kernel');

h(1).FaceColor = [0.98 0.98 0.98];
h(1).EdgeColor = [0 0 0];
h(2).Color = [0 0 0];
h(2).LineWidth = 1;
h(1).HandleVisibility = 'off';
h(2).HandleVisibility = 'off';

xlabel('Estimated slope parameter', 'FontWeight', 'bold')
ylim([0,yaxis_lim])
set(gca,'Yticklabel',[])
hold on 


%% Confidence intervals

component2coef_ordered = sort(modelmetrics.component2coef);
% determines percent of CI
lowerboundpercent = 1 - CI - (1 - CI)/2;
upperboundpercent = CI + (1 - CI)/2;
LBtorow_exact = lowerboundpercent*(length(component2coef_ordered));
LBtorow_rounded = round(lowerboundpercent*(length(component2coef_ordered)));
UBtorow_exact = upperboundpercent*(length(component2coef_ordered));
UBtorow_rounded = round(upperboundpercent*(length(component2coef_ordered)));

if LBtorow_rounded < LBtorow_exact
    x = LBtorow_rounded;
    y = LBtorow_rounded + 1;
    lowerbound = mean(component2coef_ordered(x:y));
elseif LBtorow_rounded == LBtorow_exact
    lowerbound = component2coef_ordered(LBtorow_rounded);
else   
    x = LBtorow_rounded;
    y = LBtorow_rounded - 1;
    lowerbound = mean(component2coef_ordered(y:x));
end 

if UBtorow_rounded < UBtorow_exact
    x = UBtorow_rounded;
    y = UBtorow_rounded + 1;
    upperbound = mean(component2coef_ordered(x:y));
elseif UBtorow_rounded == UBtorow_exact
    upperbound = component2coef_ordered(UBtorow_rounded);
else
    x = UBtorow_rounded;
    y = UBtorow_rounded - 1;
    upperbound = mean(component2coef_ordered(y:x));
end

%% Mean and CI added to hist

meancomponent2coef = mean(component2coef_ordered);

xline(meancomponent2coef, 'k', 'LineWidth', 1);
xline(lowerbound, '--k', 'LineWidth', 1);
xline(upperbound, '--k', 'LineWidth', 1);

%% Improve aesthetics

set(gcf,'color','w');
set(findall(gcf,'-property','FontName'),'FontName','Arial')
set(findall(gcf,'-property','FontSize'),'FontSize', 12)
hold off

end