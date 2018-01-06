clear variables;
close all;

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
populationSize=100;

fuel = 2000;
q=0.015;

mutationProbability = 0.8;

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

    %
    figure
    surf(mapTerrainDifficulty)
    axis([0 mapSize 0 mapSize -mapSize/2 mapSize/2])
    title('Map of Difficulty Terrain')
    %}
%   mapTerrain - mapa
%   sampleMatrix - mapa probek
%       1 - jest probka
%       0 - nie ma 


%% populacja startowa
%{
global beginningPoint;
beginningPoint=[30 31]; % [x y]

maksymalnaDlugoscTrasy=max(1000, mapSize^2);
minimalnaDlugosTrasy=200;

population{iloscOsobnikowNaStarcie}=0;

for i=1:iloscOsobnikowNaStarcie
    
    dlugoscOsobnika=randi([minimalnaDlugosTrasy, maksymalnaDlugoscTrasy]);
    road=zeros(dlugoscOsobnika, 2);
    road(1,:)=beginningPoint;
    
    for j=2:dlugoscOsobnika
        flag=1;
        while flag==1
           road(j,:)=road(j-1,:);
            choice=randi([1 4]);
             % 1-prawo 2-lewo 3-gora 4-dol
            switch choice
                case 1  %   prawo
                    road(j,1)=road(j,1)+1;
                case 2  %    lewo
                    road(j,1)=road(j,1)-1;
                case 3  %   gora 
                    road(j,2)=road(j,2)+1;
                case 4  %   dol
                    road(j,2)=road(j,2)-1;
                otherwise 
                    display('error\n\n');
            end
            if(road(j,1)<1 || road(j,2)<1 || road(j,1)>mapSize || road(j,2)>mapSize)
                flag=1;
            else
                flag=0;
            end 
        end 
    end
    population{i}=road;
    
end
%}





%% testing ConnectPoints
%{
close all;
startPoint=[52 145];
stopPoint=[172 31];
road=ConnectPoints(startPoint, stopPoint);
plot(road(:,2), road(:,1), '--o')
hold on
grid on
plot(startPoint(2), startPoint(1), 'g*')
plot(stopPoint(2), stopPoint(1), 'r*')
%}

%% crossover testing
%{
osobnik1=ConnectPoints([15 75], [32 54]);
osobnik2=ConnectPoints([15 75], [7 45]);

close all
figure;
plot(osobnik1(:,2),osobnik1(:,1))
hold on;
plot(osobnik1(length(osobnik1),2),osobnik1(length(osobnik1),1),'--or')
plot(osobnik1(1,2),osobnik1(1,1),'--og')

plot(osobnik2(:,2),osobnik2(:,1))
plot(osobnik2(length(osobnik2),2),osobnik2(length(osobnik2),1),'--or')
plot(osobnik2(1,2),osobnik2(1,1),'--og')

[osobnik1, osobnik2]=crossover2(osobnik1, osobnik2);

plot(osobnik1(:,2),osobnik1(:,1),':*')
plot(osobnik1(length(osobnik1),2),osobnik1(length(osobnik1),1),'--or')
plot(osobnik1(1,2),osobnik1(1,1),'--og')

plot(osobnik2(:,2),osobnik2(:,1),':o')
plot(osobnik2(length(osobnik2),2),osobnik2(length(osobnik2),1),'--or')
plot(osobnik2(1,2),osobnik2(1,1),'--og')
%}

%% inne generowanie populacji startowej - laczenie punktow pomiedzy probkami
%
populacja2{populationSize}=0;
punktPoczatkowy=[40 35];


for i=1:populationSize
    
    ileProbekPolaczyc=randi([2, floor(iloscProbek^0.6)]);
    connection=ConnectPoints(punktPoczatkowy, samplePositions(randi([1 length(samplePositions)]),:));
    road=connection;
    roadLength=length(road);
    for j=2:ileProbekPolaczyc
        connection=ConnectPoints(road(roadLength,:), samplePositions(randi([1 length(samplePositions)]),:));
        [connectionLength, ~]=size(connection);
        road(roadLength:roadLength+connectionLength-1,:)=connection;
        roadLength=length(road);
    end
   
    connection=ConnectPoints(road(roadLength,:), punktPoczatkowy);
    road(roadLength:roadLength+length(connection)-1,:)=connection;
    roadLength=length(road);
    
    populacja2{i}=road;
end
%}

%% testowanie nowej populacji
%{
osobnik=randi([1 100]);
close all
hold on
plot(populacja2{1,osobnik }(:,2),populacja2{1,osobnik }(:,1))
plot(populacja2{1,osobnik }(1,2),populacja2{1,osobnik }(1,1),'--*g')
plot(samplePositions(:,2), samplePositions(:,1),'.r');
%}


%% obliczenie kosztow populacji poczatkowej

fitnessFunction = zeros(populationSize,1);

for i=1:populationSize
    fitnessFunction(i) = funkcjaCelu2(populacja2{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
end

%% sortowanie populacji

sortedPopulation{populationSize} = 0;
[~, I] = sort(fitnessFunction, 'descend');
for i=1:populationSize
    sortedPopulation{i}=populacja2{i};
end

%% krzy¿owanie na podstawie selekcji rankingowej

population2 = selekcjaRankingowa2(sortedPopulation, populationSize, q);

%% mutowanie osobników 
% -----------W FUNKCJI NUMERU POKOLENIA--------------

for i = 1:populationSize
    population2{i} = mutation2(population2{i}, mutationProbability);
end



%{
osobnik=randi([1 100]);
close all
hold on
plot(populacja2{1,osobnik }(:,2),populacja2{1,osobnik }(:,1))
plot(populacja2{1,osobnik }(1,2),populacja2{1,osobnik }(1,1),'--*g')
plot(samplePositions(:,2), samplePositions(:,1),'.r');
%%
osobnik=randi([1 100]);
hold on
plot(populacja2{1,osobnik }(:,2),populacja2{1,osobnik }(:,1))
plot(populacja2{1,osobnik }(1,2),populacja2{1,osobnik }(1,1),':*m')
plot(samplePositions(:,2), samplePositions(:,1),'.b');
%}