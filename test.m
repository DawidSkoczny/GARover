
%% ilosc zerowych elementow
%{
sumZer = 0;
for i = 1:populationSize
    sumZer = sumZer + length(find(~population{i}));
end
sumZer
%}

%% porownanie populacji
%
sumPop = 0;
for i = 1:populationSize
    logicAnswer = population{i} == sortedPopulation{i};
    sumPop = sumPop + length(find(~logicAnswer));
end
sumPop
%}