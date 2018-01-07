% selekcja rankingowa nieliniowa

function [population] = selekcjaRankingowa2(sortedPopulation, populationSize, q)
%%
    x = populationSize; % Czy na pewno?
    pWzorcowe=q*(1-q).^[0:x-1];

    for i=2:x
        pWzorcowe(i)=pWzorcowe(i)+pWzorcowe(i-1); % cos  w rodzaju dystrybuanty
    end

    population{populationSize}=0;
    %nowaPopulacja=zeros(populationSize*2, y);
    
    for licznik = 1:2:populationSize

        numOsobnika1=0;
        numOsobnika2=0;

        while(numOsobnika1 == 0)
            P=rand;
            for i=1:x
                if P<pWzorcowe(i)
                    numOsobnika1=i;
                    break;
                end
            end
        end

        while(numOsobnika2 == 0)
            P=rand;
            for i=1:x
                if P<pWzorcowe(i)
                    numOsobnika2=i;
                    break;
                end
            end
        end

        whereToConnect = randi([1 min(length(sortedPopulation{numOsobnika1}) - 2 , length(sortedPopulation{numOsobnika2}) - 2)]);

        %warning('whereToConnect = %i', whereToConnect)
        %warning('numOsobnika1 = %i', length(sortedPopulation{numOsobnika1}))
        %warning('numOsobnika2 = %i', length(sortedPopulation{numOsobnika2}))
        
        firstPoint1 = sortedPopulation{numOsobnika1}(whereToConnect, 1:2);
        firstPoint2 = sortedPopulation{numOsobnika2}(whereToConnect, 1:2);
        secondPoint1 = sortedPopulation{numOsobnika2}(whereToConnect + 1, 1:2);
        secondPoint2 = sortedPopulation{numOsobnika1}(whereToConnect + 1, 1:2);
        
        connection1 = ConnectPoints(firstPoint1, secondPoint1);
        connection2 = ConnectPoints(firstPoint2, secondPoint2);
        
        [connectionLength1, ~] = size(connection1);
        [connectionLength2, ~] = size(connection2);
        
        %
        population{licznik}(1:whereToConnect, 1:2) = sortedPopulation{numOsobnika1}(1:whereToConnect, 1:2);
        population{licznik}(whereToConnect + 1:whereToConnect + connectionLength1, 1:2) = connection1(1:connectionLength1, 1:2);
        population{licznik}(whereToConnect + 1 + connectionLength1:length(sortedPopulation{numOsobnika2}) + connectionLength1, 1:2) = sortedPopulation{numOsobnika2}(whereToConnect + 1:length(sortedPopulation{numOsobnika2}), 1:2);

        population{licznik + 1}(1:whereToConnect, 1:2) = sortedPopulation{numOsobnika2}(1:whereToConnect, 1:2);
        population{licznik + 1}(whereToConnect + 1:whereToConnect + connectionLength2, 1:2) = connection2(1:connectionLength2, 1:2);
        population{licznik + 1}(whereToConnect + 1 + connectionLength2:length(sortedPopulation{numOsobnika1}) + connectionLength2, 1:2) = sortedPopulation{numOsobnika1}(whereToConnect + 1:length(sortedPopulation{numOsobnika1}), 1:2);
        %}
        %[nowaPopulacja(licznik), nowaPopulacja(licznik+1) ] = TwoPointCrossover2(sortedPopulation{numOsobnika1}, sortedPopulation{numOsobnika2});
    end
    %%
end