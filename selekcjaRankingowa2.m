% selekcja rankingowa nieliniowa

function [population] = selekcjaRankingowa2(sortedPopulation, populationSize, q)

    x = populationSize; % Czy na pewno?
    pWzorcowe=q*(1-q).^[0:x-1];

    for i=2:x
        pWzorcowe(i)=pWzorcowe(i)+pWzorcowe(i-1); % cos  w rodzaju dystrybuanty
    end

    population{populationSize}=0;
    %nowaPopulacja=zeros(populationSize*2, y);
    
    for licznik = 1:2:populationSize-2

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

        whereToConnect = randi([1 min(length(sortedPopulation{numOsobnika1}) - 1 , length(sortedPopulation{numOsobnika2}) - 1)]);

        population{licznik}(1:whereToConnect, :) = sortedPopulation{numOsobnika1}(1:whereToConnect, :);
        population{licznik}(whereToConnect + 1:length(sortedPopulation{numOsobnika2}), :) = sortedPopulation{numOsobnika2}(whereToConnect + 1:length(sortedPopulation{numOsobnika2}), :);

        population{licznik + 1}(1:whereToConnect, :) = sortedPopulation{numOsobnika2}(1:whereToConnect, :);
        population{licznik + 1}(whereToConnect + 1:length(sortedPopulation{numOsobnika1}), :) = sortedPopulation{numOsobnika1}(whereToConnect + 1:length(sortedPopulation{numOsobnika1}), :);

        %[nowaPopulacja(licznik), nowaPopulacja(licznik+1) ] = TwoPointCrossover2(sortedPopulation{numOsobnika1}, sortedPopulation{numOsobnika2});
    end
end