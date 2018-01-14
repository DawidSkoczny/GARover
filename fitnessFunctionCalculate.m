function [ fFunc ] = fitnessFunctionCalculate( individual, mapTerrainDifficulty, samplesMap, fuel )

    [roadLength, ~] = size(individual);
    petrolCost=0;
    samplesCollected=0;
    mapTerrainDifficulty(mapTerrainDifficulty == 10) = 200;

    for i=1:roadLength
        petrolCost=petrolCost+mapTerrainDifficulty(individual(i,1), individual(i,2));
        if samplesMap(individual(i,1), individual(i,2))==1
            samplesCollected=samplesCollected+1;
            samplesMap(individual(i,1), individual(i,2))=0; 
        end
    end
    
    if petrolCost < fuel
        penaltyFunction =( petrolCost-fuel)*0.01;
    else
        penaltyFunction = petrolCost-fuel;
    end
    
    fFunc=15*samplesCollected - penaltyFunction;
    %fFunc = 10*(log(samplesCollected)/log(2)+0.2*samplesCollected) - penaltyFunction;
    
end