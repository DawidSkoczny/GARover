%% czyszczenie srodowiska
clear variables;
close all;

%% inicjalizacja

terrainVariability = 5;
mapSize = 100;
mapSize = abs(floor(mapSize));
terrainVariability = abs(floor(terrainVariability));
biomeVariability = 0.8;
numberOfBiomes = 6;

iloscProbek = 300;
iloscProbek = min(iloscProbek, floor((mapSize^2)/4));
populationSize = 200;
howManyGenerations = 300;

fuel = 800;
q=0.0075;

mutationProbability = 0.10;

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
punktPoczatkowy=[40 35];


for i=1:populationSize
    
    ileProbekPolaczyc=randi([2, 15]);
    connection=anotherConnectPoints(punktPoczatkowy, samplePositions(randi([1 length(samplePositions)]),:), mapTerrainDifficulty, sampleMatrix);
    road=connection;
    [roadLength, ~] = size(road);
    for j=2:ileProbekPolaczyc
        connection=anotherConnectPoints(road(roadLength,:), samplePositions(randi([1 length(samplePositions)]),:), mapTerrainDifficulty, sampleMatrix);
        [connectionLength, ~]=size(connection);
        road(roadLength:roadLength+connectionLength-1,:)=connection;
        [roadLength, ~] = size(road);
    end
   
    connection=anotherConnectPoints(road(roadLength,:), punktPoczatkowy, mapTerrainDifficulty, sampleMatrix);
    [connectionLength, ~] = size(connection);
    road(roadLength:roadLength+connectionLength-1,:)=connection;
    [roadLength, ~] = size(road);
    
    firstPopulation{i}=road;
end
%}

population = firstPopulation;

%
%% obliczenie funkcji celu

fitnessFunction = zeros(populationSize,1);

for i=1:populationSize
    fitnessFunction(i) = funkcjaCelu2(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
end

%% sortowanie populacji

sortedPopulation{populationSize} = 0;
sortedFitnessFunction(populationSize)=0;
[~, I] = sort(fitnessFunction, 'descend');
for i=1:populationSize
    sortedPopulation{i}=population{I(i)};
    sortedFitnessFunction(i)=fitnessFunction(I(i));
end
%}

%% glowna petla
bestGoalFunc=zeros(1,howManyGenerations);
meanGoalFunc=zeros(1,howManyGenerations);

for j = 1:howManyGenerations

    % mutowanie osobnikow 
    mutationProbability = 0.99 * mutationProbability;
    
    for i = 1:populationSize
        if rand < mutationProbability
            population{i} = mutation2(population{i}, mapTerrainDifficulty, sampleMatrix);
        end
    end
    
    % sortowanie populacji
    fitnessFunction = zeros(populationSize,1);

    for i=1:populationSize
        fitnessFunction(i) = funkcjaCelu2(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
    end
     [~, I] = sort(fitnessFunction, 'descend');
    for i=1:populationSize
        sortedPopulation{i}=population{I(i)};
        sortedFitnessFunction(i)=fitnessFunction(I(i));
    end
    
    % krzy�owanie na podstawie selekcji rankingowej
    population = crossover(sortedPopulation, populationSize, q, mapTerrainDifficulty, sampleMatrix, fuel);
    bestGoalFunc(j)=max(fitnessFunction);
    meanGoalFunc(j)=mean(fitnessFunction);

end

%% tu trzebaby dijkstra optymalizowac trase najlepszego osobnika

%% prezentacja wynikow
%
for i=1:length(population)
    fitnessFunction(i) = funkcjaCelu2(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
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

osobnik=I(1); % najlepszy osobnik
hold on
wysokoscTrasy(length(population{1, osobnik}))=0;
for i=1:length(population{1, osobnik})
    wysokoscTrasy(i)=mapTerrainDifficulty(population{1, osobnik}(i,1),population{1, osobnik}(i,2)); 
end
wysokoscProbek(length(samplePositions))=0;
for i=1:length(samplePositions)
    wysokoscProbek(i)=mapTerrainDifficulty(samplePositions(i,1),samplePositions(i,2)); 
end


plot3(population{1, osobnik}(:, 2), population{1, osobnik}(:,1),wysokoscTrasy+0.2, 'magenta','LineWidth',2)
plot3(samplePositions(:, 2), samplePositions(:, 1), wysokoscProbek+0.2, '.r','MarkerSize',16);
nast=plot3(population{1, osobnik}(1, 2), population{1, osobnik}(1,1), wysokoscTrasy(1)+0.2, 'g.');
nast.MarkerSize=30;
nast.LineWidth=6;

str=sprintf('Najlepszy osobnik nr %i, jego funkcja celu to %d', I(1),floor(fitnessFunction(I(1))))
title(str)

figure
subplot(2,1,1)
plot(bestGoalFunc);
grid on;
title('funckaj celu najlpeszego osobnika w populacji');
subplot(2,1,2)
plot(meanGoalFunc);
title('srednia funkcja celu w danej populacji');
axis([0, length(meanGoalFunc), -300, 100*ceil(max(meanGoalFunc)/100)]);
grid on;