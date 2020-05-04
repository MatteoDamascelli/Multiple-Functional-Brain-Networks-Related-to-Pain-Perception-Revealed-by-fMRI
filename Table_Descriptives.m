function SupplementaryTable4 = Table_Descriptives(Data)
%% Descriptive stats


variable = {'rating';
            'Component 1';
            'Component 2';
            'Component 4'};
Data = sortrows(Data, 7);
meanHT = {mean(Data.rating(1:height(Data)/2));
          mean(Data.C1(1:height(Data)/2));
          mean(Data.C2(1:height(Data)/2));
          mean(Data.C4(1:height(Data)/2))};
SEHT = {std(Data.rating(1:height(Data)/2))/sqrt(height(Data)/2);
        std(Data.C1(1:height(Data)/2))/sqrt(height(Data)/2);
        std(Data.C2(1:height(Data)/2))/sqrt(height(Data)/2);
        std(Data.C4(1:height(Data)/2))/sqrt(height(Data)/2)};
meanLT = {mean(Data.rating(((height(Data)/2)+1):height(Data)));
          mean(Data.C1(((height(Data)/2)+1):height(Data)));
          mean(Data.C2(((height(Data)/2)+1):height(Data)));
          mean(Data.C4(((height(Data)/2)+1):height(Data)))};
SELT = {std(Data.rating(((height(Data)/2)+1):height(Data)))/sqrt(height(Data)/2);
        std(Data.C1(((height(Data)/2)+1):height(Data)))/sqrt(height(Data)/2);
        std(Data.C2(((height(Data)/2)+1):height(Data)))/sqrt(height(Data)/2);
        std(Data.C4(((height(Data)/2)+1):height(Data)))/sqrt(height(Data)/2)};

SupplementaryTable4 = table(variable, meanHT, SEHT, meanLT, SELT);

end