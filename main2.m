clear variables;
close all;

terrainVariability = 5;
mapSize = 100;
mapSize = abs(floor(mapSize));
terrainVariability = abs(floor(terrainVariability));

iloscProbek = min(50, mapSize);
iloscOsobnikowNaStarcie=100;

mapTerrain = MapTerrain(terrainVariability, mapSize);
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

surf(mapTerrain)
%   mapTerrain - mapa
%   sampleMatrix - mapa probek
%       1 - jest probka
%       0 - nie ma 


%% populacja startowa
global beginningPoint;
beginningPoint=[30 31]; % [x y]

maksymalnaDlugoscTrasy=1000;
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
             % 1-prawo 2-lewo 3-gora -dol
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
            if(road(j,1)<1 | road(j,2)<1 | road(j,1)>mapSize | road(j,2)>mapSize)
                flag=1;
                
            else
                flag= 0;
            end 
                
        end 
                
    end
    population{i}=road;
    
end
        
%% obliczenie kosztow populacji poczatkowej

macierzKosztow(100,2)=99;

for i=1:iloscOsobnikowNaStarcie
    macierzKosztow(i,:)=funkcjaCelu2(population{1,i}, mapTerrain, sampleMatrix);
    
end











