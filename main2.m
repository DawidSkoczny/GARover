%%
clear variables;
close all;

%% inicjalizacja

global sampleMatrix;
global samplePositions;

terrainVariability = 5;
mapSize = 100;
mapSize = abs(floor(mapSize));
terrainVariability = abs(floor(terrainVariability));
biomeVariability = 0.8;
numberOfBiomes = 6;

iloscProbek = 100;
iloscProbek = min(iloscProbek, floor((mapSize^2)/4));
populationSize = 50;

fuel = 2000;
q=0.015;

mutationProbability = 0.08;

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

%% inne generowanie populacji startowej - laczenie punktow pomiedzy probkami

firstPopulation{populationSize}=0;
sortedPopulation{populationSize}=0;
punktPoczatkowy=[40 35];


for i=1:populationSize
    
    ileProbekPolaczyc=randi([2, floor(iloscProbek^0.6)]);
    connection=ConnectPoints(punktPoczatkowy, samplePositions(randi([1 length(samplePositions)]),:));
    road=connection;
    %roadLength=length(road);
    [roadLength, ~] = size(road);
    for j=2:ileProbekPolaczyc
        connection=ConnectPoints(road(roadLength,:), samplePositions(randi([1 length(samplePositions)]),:));
        [connectionLength, ~]=size(connection);
        road(roadLength:roadLength+connectionLength-1,:)=connection;
        %roadLength=length(road);
        [roadLength, ~] = size(road);
    end
   
    connection=ConnectPoints(road(roadLength,:), punktPoczatkowy);
    [connectionLength, ~] = size(connection);
    %road(roadLength:roadLength+length(connection)-1,:)=connection;
    road(roadLength:roadLength+connectionLength-1,:)=connection;
    %roadLength=length(road);
    [roadLength, ~] = size(road);
    
    firstPopulation{i}=road;
end
%}

population = firstPopulation;

%% glowna petla

for j = 1:5

    %% obliczenie funkcji celu

    fitnessFunction = zeros(populationSize,1);

    for i=1:populationSize
        fitnessFunction(i) = funkcjaCelu2(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
    end

    %% sortowanie populacji

    sortedPopulation{populationSize} = 0;
    [~, I] = sort(fitnessFunction, 'descend');
    for i=1:populationSize
        sortedPopulation{i}=population{I(i)};
    end

    %% krzy¿owanie na podstawie selekcji rankingowej

    population = selekcjaRankingowa2(sortedPopulation, populationSize, q);

    %% mutowanie osobników 
    % -----------W FUNKCJI NUMERU POKOLENIA--------------

    for i = 1:populationSize
        if false %rand < mutationProbability
            population{i} = mutation2(population{i}, mutationProbability);
        end
    end

end


%% prezentacja wynikow

    %% obliczenie funkcji celu

fitnessFunction = zeros(populationSize,1);

for i=1:populationSize
    fitnessFunction(i) = funkcjaCelu2(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
end

    %% sortowanie populacji

sortedPopulation{populationSize} = 0;
[~, I] = sort(fitnessFunction, 'descend');
for i=1:populationSize
    sortedPopulation{i}=population{i};
end

population = sortedPopulation;

%%
%
figure
surf(mapTerrainDifficulty)
axis([0 mapSize 0 mapSize -mapSize/2 mapSize/2])
title('Map of Difficulty Terrain')

osobnik=randi([1 populationSize]);
hold on
plot3(population{1, osobnik}(:, 2), population{1, osobnik}(:,1), 10*ones(1, length(population{1, osobnik})), 'magenta')
plot3(population{1, osobnik}(1, 2), population{1, osobnik}(1,1), 10, '--*g')
plot3(samplePositions(:, 2), samplePositions(:, 1), 10*ones(iloscProbek, 1), '.r');

osobnik=randi([1 populationSize]);
plot3(population{1, osobnik}(:, 2), population{1, osobnik}(:,1), 10*ones(1, length(population{1, osobnik})), 'white')
%}