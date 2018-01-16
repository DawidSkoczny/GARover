%% czyszczenie srodowiska
clear variables;
close all;

%% parametry symulacji

terrainVariability = 2;
mapSize = 500;
numberOfBiomes = 6;
biomeVariability = 0.8;
iloscProbek = 999;
fuel = 4000;

howManyGenerations = 300;
populationSize = 200;
q=0.0075;
mutationProbability = 0.10;

%% inicjalizacja 
mapSize = abs(floor(mapSize));
terrainVariability = abs(floor(terrainVariability));
iloscProbek = min(iloscProbek, floor((mapSize^2)/4));

mapTerrain = MapTerrain(terrainVariability, mapSize);
mapBiome = MapBiome( biomeVariability, numberOfBiomes, mapSize);
mapTerrainDifficulty = MapTerrainDifficulty( mapTerrain, mapBiome);
sampleMatrix = zeros(mapSize);
samplePositions = zeros(iloscProbek, 2);

j = randi([1 mapSize]);
k = randi([1 mapSize]);

for i = 1:iloscProbek
    while (sampleMatrix(j, k) ~= 0)
        j = randi([1 mapSize]);
        k = randi([1 mapSize]);
    end
    samplePositions(i, :) = [j k];
    sampleMatrix(j, k) = 1;
end

%% Generowanie populacji startowej - laczenie punktow pomiedzy probkami

firstPopulation{populationSize}=0;
sortedPopulation{populationSize}=0;
startingPoint=[40 35];


for i=1:populationSize
    
    howManySamplesToConnect=randi([2, 15]);
    connection=connectPoints(startingPoint, samplePositions(randi([1 length(samplePositions)]),:), mapTerrainDifficulty, sampleMatrix);
    road=connection;
    [roadLength, ~] = size(road);
    for j=2:howManySamplesToConnect
        connection=connectPoints(road(roadLength,:), samplePositions(randi([1 length(samplePositions)]),:), mapTerrainDifficulty, sampleMatrix);
        [connectionLength, ~]=size(connection);
        road(roadLength:roadLength+connectionLength-1,:)=connection;
        [roadLength, ~] = size(road);
    end
   
    connection=connectPoints(road(roadLength,:), startingPoint, mapTerrainDifficulty, sampleMatrix);
    [connectionLength, ~] = size(connection);
    road(roadLength:roadLength+connectionLength-1,:)=connection;
    [roadLength, ~] = size(road);
    
    firstPopulation{i}=road;
end
%}

population = firstPopulation;

%% obliczenie funkcji celu

fitnessFunction = zeros(populationSize,1);

for i=1:populationSize
    fitnessFunction(i) = fitnessFunctionCalculate(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
end

%% sortowanie populacji

sortedPopulation{populationSize} = 0;
sortedFitnessFunction(populationSize)=0;
[~, I] = sort(fitnessFunction, 'descend');
for i=1:populationSize
    sortedPopulation{i}=population{I(i)};
    sortedFitnessFunction(i)=fitnessFunction(I(i));
end

%% glowna petla
bestGoalFunc=zeros(1,30);
meanGoalFunc=zeros(1,30);

for j = 1:howManyGenerations

    % mutowanie osobnikow 
    mutationProbability = 0.99 * mutationProbability;
    
    for i = 1:populationSize
        if rand < mutationProbability
            population{i} = mutation(population{i}, mapTerrainDifficulty, sampleMatrix);
        end
    end
    
    % sortowanie populacji
    fitnessFunction = zeros(populationSize,1);

    for i=1:populationSize
        fitnessFunction(i) = fitnessFunctionCalculate(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
    end
    
    [~, I] = sort(fitnessFunction, 'descend');
    for i=1:populationSize
        sortedPopulation{i}=population{I(i)};
        sortedFitnessFunction(i)=fitnessFunction(I(i));
    end
    
    % krzyzowanie na podstawie selekcji rankingowej
    population = crossover(sortedPopulation, populationSize, q, mapTerrainDifficulty, sampleMatrix, fuel);
    bestGoalFunc(j)=max(fitnessFunction);
    meanGoalFunc(j)=mean(fitnessFunction);
    
    if j > 40 && abs(bestGoalFunc(j)-mean(bestGoalFunc(j-40:j))) < 0.005*bestGoalFunc(j)
        break
    end
    
end

%bestGoalFunc(j+1: howManyGenerations) = [];
%meanGoalFunc(j+1: howManyGenerations) = [];

%% prezentacja wynikow
%
for i=1:length(population)
    fitnessFunction(i) = fitnessFunctionCalculate(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
end
[~, I] = sort(fitnessFunction, 'descend');
    for i=1:populationSize
        sortedPopulation{i}=population{I(i)};
        sortedFitnessFunction(i)=fitnessFunction(I(i));
    end

figure
surf(mapTerrainDifficulty)
axis([0 mapSize 0 mapSize -mapSize/2 mapSize/2])
title('Map of Difficulty Terrain')

bestIndividual=I(1); % najlepszy osobnik
hold on
roadAltitude(length(population{1, bestIndividual}))=0;
for i=1:length(population{1, bestIndividual})
    roadAltitude(i)=mapTerrainDifficulty(population{1, bestIndividual}(i,1),population{1, bestIndividual}(i,2)); 
end
sampleAltitude(length(samplePositions))=0;
for i=1:length(samplePositions)
    sampleAltitude(i)=mapTerrainDifficulty(samplePositions(i,1),samplePositions(i,2)); 
end


plot3(population{1, bestIndividual}(:, 2), population{1, bestIndividual}(:,1),roadAltitude+0.2, 'magenta','LineWidth',2)
plot3(samplePositions(:, 2), samplePositions(:, 1), sampleAltitude+0.2, '.r','MarkerSize',16);
nast=plot3(population{1, bestIndividual}(1, 2), population{1, bestIndividual}(1,1), roadAltitude(1)+0.2, 'g.');
nast.MarkerSize=30;
nast.LineWidth=6;

str = sprintf('Najlepszy osobnik o numerze %i w populacji, kt�rego funkcja celu to %d', I(1),floor(fitnessFunction(I(1))))
title(str)

figure
subplot(2,1,1)
plot(bestGoalFunc);
grid on;
title('Funkcja celu najlpeszego osobnika w danej populacji');
axis([0, length(meanGoalFunc), 0, 100*ceil(max(bestGoalFunc)/100)]);
xlabel('Numer populacji');
ylabel('Warto�� funkcji celu');
subplot(2,1,2)
plot(meanGoalFunc);
title('�rednia funkcja celu osobnik�w w danej populacji');
axis([0, length(meanGoalFunc), -300, 100*ceil(max(meanGoalFunc)/100)]);
xlabel('Numer populacji');
ylabel('Warto�� funkcji celu');
grid on;