function [ fCelu ] = funkcjaCelu2( individual, mapTerrainDifficulty, samplesMap, fuel )

    [roadLength, ~] = size(individual);
    petrolCost=0;
    samplesCollected=0;
    mapTerrainDifficulty(mapTerrainDifficulty == 10) = 1000;

    for i=1:roadLength
        petrolCost=petrolCost+mapTerrainDifficulty(individual(i,1), individual(i,2));
        if samplesMap(individual(i,1), individual(i,2))==1
            samplesCollected=samplesCollected+1;
        end
    end
    %wynik=[ petrolCost, samplesCollected ];
    
    if petrolCost < fuel
        penaltyFunction = -5*petrolCost + 5*fuel;
    else
        penaltyFunction = 0.3*(petrolCost-fuel).^2;
    end
    
    %samplesCollected
    fCelu = 10*(log(samplesCollected)/log(2)+0.2*samplesCollected) - penaltyFunction;
    % Wieksze znaczenie w jakim terenie sie porusza
    
end