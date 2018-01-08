% selekcja rankingowa nieliniowa

function [sortedPopulation] = crossover(firstPopulation, oldPopulationSize, q, mapTerrainDifficulty, sampleMatrix, fuel)
%%
    
    newPopulationSize = 2 * oldPopulationSize;
    pWzorcowe=q*(1-q).^[0:oldPopulationSize-1];

    for i=2:oldPopulationSize
        pWzorcowe(i)=pWzorcowe(i)+pWzorcowe(i-1); % cos  w rodzaju dystrybuanty
    end

    population{newPopulationSize}=0;
    
    for licznik = 1:2:newPopulationSize

        numOsobnika1=0;
        numOsobnika2=0;

        while(numOsobnika1 == 0)
            P=rand;
            for i=1:oldPopulationSize
                if P<pWzorcowe(i)
                    numOsobnika1=i;
                    break;
                end
            end
        end

        while(numOsobnika2 == 0)
            P=rand;
            for i=1:oldPopulationSize
                if P<pWzorcowe(i)
                    numOsobnika2=i;
                    break;
                end
            end
        end

        whereToConnect = randi([1 min(length(firstPopulation{numOsobnika1}) - 2 , length(firstPopulation{numOsobnika2}) - 2)]);

        %warning('whereToConnect = %i', whereToConnect)
        %warning('numOsobnika1 = %i', length(sortedPopulation{numOsobnika1}))
        %warning('numOsobnika2 = %i', length(sortedPopulation{numOsobnika2}))
        
        firstPoint1 = firstPopulation{numOsobnika1}(whereToConnect, 1:2);
        firstPoint2 = firstPopulation{numOsobnika2}(whereToConnect, 1:2);
        secondPoint1 = firstPopulation{numOsobnika2}(whereToConnect + 1, 1:2);
        secondPoint2 = firstPopulation{numOsobnika1}(whereToConnect + 1, 1:2);
        
        connection1 = ConnectPoints(firstPoint1, secondPoint1);
        connection2 = ConnectPoints(firstPoint2, secondPoint2);
        
        [connectionLength1, ~] = size(connection1);
        [connectionLength2, ~] = size(connection2);
        
        %
        population{licznik}(1:whereToConnect, 1:2) = firstPopulation{numOsobnika1}(1:whereToConnect, 1:2);
        population{licznik}(whereToConnect + 1:whereToConnect + connectionLength1, 1:2) = connection1(1:connectionLength1, 1:2);
        population{licznik}(whereToConnect + 1 + connectionLength1:length(firstPopulation{numOsobnika2}) + connectionLength1, 1:2) = firstPopulation{numOsobnika2}(whereToConnect + 1:length(firstPopulation{numOsobnika2}), 1:2);

        population{licznik + 1}(1:whereToConnect, 1:2) = firstPopulation{numOsobnika2}(1:whereToConnect, 1:2);
        population{licznik + 1}(whereToConnect + 1:whereToConnect + connectionLength2, 1:2) = connection2(1:connectionLength2, 1:2);
        population{licznik + 1}(whereToConnect + 1 + connectionLength2:length(firstPopulation{numOsobnika1}) + connectionLength2, 1:2) = firstPopulation{numOsobnika1}(whereToConnect + 1:length(firstPopulation{numOsobnika1}), 1:2);
        %}
       
    end
     
    %% Wybieranie najlepszych osobników

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
    
    %%
end