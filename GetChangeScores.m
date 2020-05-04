function DataChangeScores = GetChangeScores(Data)
%% new data table for "change" scores

Data = sortrows(Data, 7);
subject = Data.subject(1:31);
L = height(Data)/2;
changeinrating = zeros(L,1);
for i = 1:L
    changeinrating(i,:) = Data.rating(i) - Data.rating(i+L);
end
changeinC1 = zeros(L,1);
for i = 1:L
    changeinC1(i,:) = Data.C1(i) - Data.C1(i+L);
end
changeinC2 = zeros(L,1);
for i = 1:L
    changeinC2(i,:) = Data.C2(i) - Data.C2(i+L);
end
changeinC3 = zeros(L,1);
for i = 1:L
    changeinC3(i,:) = Data.C3(i) - Data.C3(i+L);
end
changeinC4 = zeros(L,1);
for i = 1:L
    changeinC4(i,:) = Data.C4(i) - Data.C4(i+L);
end
clear i

DataChangeScores = array2table([subject changeinrating changeinC1 changeinC2 changeinC3 changeinC4]); 
DataChangeScores.Properties.VariableNames = {'subject' 'changeinrating' 'changeinC1' 'changeinC2' 'changeinC3' 'changeinC4'};

end