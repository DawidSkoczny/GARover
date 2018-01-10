% selekcja rankingowa nieliniowa

function [population] = crossover(oldSortedPopulation, PopulationSize, q, mapTerrainDifficulty, sampleMatrix, fuel)
%%
    
    newPopulationSize = PopulationSize-20; 
    pWzorcowe=q*(1-q).^[0:PopulationSize-1];

    for i=2:PopulationSize
        pWzorcowe(i)=pWzorcowe(i)+pWzorcowe(i-1); % cos  w rodzaju dystrybuanty
    end

    population{1,newPopulationSize-2}=0;
    
    for licznik = 1:2:newPopulationSize+1

        numOsobnika1=0;
        numOsobnika2=0;

        while(numOsobnika1 == 0)
            P=rand;
            for i=1:PopulationSize
                if P<pWzorcowe(i)
                    numOsobnika1=i;
                    break;
                end
            end
        end

        while(numOsobnika2 == 0)
            P=rand;
            for i=1:PopulationSize
                if P<pWzorcowe(i)
                    numOsobnika2=i;
                    break;
                end
            end
        end

        whereToConnect = randi([1 min(length(oldSortedPopulation{numOsobnika1}) - 2 , length(oldSortedPopulation{numOsobnika2}) - 2)]);

        %warning('whereToConnect = %i', whereToConnect)
        %warning('numOsobnika1 = %i', length(sortedPopulation{numOsobnika1}))
        %warning('numOsobnika2 = %i', length(sortedPopulation{numOsobnika2}))
        
        firstPoint1 = oldSortedPopulation{numOsobnika1}(whereToConnect, 1:2);
        firstPoint2 = oldSortedPopulation{numOsobnika2}(whereToConnect, 1:2);
        secondPoint1 = oldSortedPopulation{numOsobnika2}(whereToConnect + 1, 1:2);
        secondPoint2 = oldSortedPopulation{numOsobnika1}(whereToConnect + 1, 1:2);
        
        connection1 = anotherConnectPoints(firstPoint1, secondPoint1, mapTerrainDifficulty, sampleMatrix);
        connection2 = anotherConnectPoints(firstPoint2, secondPoint2, mapTerrainDifficulty, sampleMatrix);
        
        [connectionLength1, ~] = size(connection1);
        [connectionLength2, ~] = size(connection2);
        
        %
        population{1,licznik}(1:whereToConnect, 1:2) = oldSortedPopulation{numOsobnika1}(1:whereToConnect, 1:2);
        population{1,licznik}(whereToConnect + 1:whereToConnect + connectionLength1, 1:2) = connection1(1:connectionLength1, 1:2);
        population{1,licznik}(whereToConnect + 1 + connectionLength1:length(oldSortedPopulation{numOsobnika2}) + connectionLength1, 1:2) = oldSortedPopulation{numOsobnika2}(whereToConnect + 1:length(oldSortedPopulation{numOsobnika2}), 1:2);

        population{1,licznik + 1}(1:whereToConnect, 1:2) = oldSortedPopulation{numOsobnika2}(1:whereToConnect, 1:2);
        population{1,licznik + 1}(whereToConnect + 1:whereToConnect + connectionLength2, 1:2) = connection2(1:connectionLength2, 1:2);
        population{1,licznik + 1}(whereToConnect + 1 + connectionLength2:length(oldSortedPopulation{numOsobnika1}) + connectionLength2, 1:2) = oldSortedPopulation{numOsobnika1}(whereToConnect + 1:length(oldSortedPopulation{numOsobnika1}), 1:2);
        %}
       
    end
     %% Wrzucenie 20 najlepszych osobnikow ze starej populacji do nowej
     population(1, length(population):length(population)+18)=oldSortedPopulation(1:1+18);
    
    
    %% Wybieranie najlepszych osobnik�w
%{      
    ja to bym sortowal populacje po mutacji
    
    fitnessFunction = zeros(newPopulationSize,1);

    for i=1:newPopulationSize
        fitnessFunction(i) = funkcjaCelu2(population{1,i}, mapTerrainDifficulty, sampleMatrix, fuel);
    end

    sortedPopulation{newPopulationSize} = 0;
    [~, I] = sort(fitnessFunction, 'descend');
    for i=1:newPopulationSize
        sortedPopulation{i}=population{I(i)};
    end
    
    sortedPopulation = sortedPopulation(1:oldPopulationSize);
    %}
    %%
end