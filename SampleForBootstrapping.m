function Sample = SampleForBootstrapping(Data)
%% sort table in ascending order by subject
Data = sortrows(Data, 1); 

%% create sample

sample_1 = zeros(62,7);
for i = 1:62
    if rem(i,2) == 0 
        tempsample = [(i-1) Data.subject(i-1)   Data.rating(i-1)   Data.C1(i-1)   Data.C2(i-1)   Data.C3(i-1)   Data.C4(i-1);
                      i     Data.subject(i)     Data.rating(i)     Data.C1(i)     Data.C2(i)     Data.C3(i)     Data.C4(i)];
                  
                  y = datasample(tempsample(:,1),1); 
                  if rem(y,2) == 0 
                      sample_1(i,:) = tempsample((i-(i-2)),:); 
                  else 
                      sample_1(i,:) = tempsample((i-(i-1)),:);
                  end                  
    else 
        sample_1(i,:) = sample_1(i,:);
    end
end

% removes rows with zeros
sample_2 = nonzeros(sample_1');
sample_2 = reshape(sample_2,7,31)';

% adds "pain vs no pain" categorical variable
sample_3 = zeros(31,8);
for i = 1:31
    if sample_2(i,3) > 100 
        sample_vector = [sample_2(i,:) 1]; 
    else 
        sample_vector = [sample_2(i,:) 0]; 
    end
    sample_3(i,:) = sample_vector; 
end

% changes first column to "high vs low" categorical variable
sample_4 = zeros(31,8);
for i = 1:31
    if rem(sample_3(i,1),2) == 0 
        sample_vector = [0 sample_3(i,2:end)]; 
    else 
        sample_vector = [1 sample_3(i,2:end)]; 
    end
    sample_4(i,:) = sample_vector; 
end

% convert to table
PrelimSample = array2table(sample_4, 'VariableNames', {'temp' 'subject' 'rating' 'C1' 'C2' 'C3' 'C4' 'painornopain_true'});

%% Ensure pain prevalence is roughly balanced

PainPrevalence = sum(PrelimSample.painornopain_true)/height(PrelimSample);

if PainPrevalence < 0.45 || PainPrevalence > 0.55
    Sample = SampleForBootstrapping(Data);
else
    Sample = PrelimSample;
end
    
end