function [ mutated ] = mutation2( osobnik,mapTerrainDifficulty, sampleMatrix )

    [len, ~] = size(osobnik);
    collectedSamples=0;
    
    for i=1:len
        if sampleMatrix(osobnik(i,1), osobnik(i,2)) == 1
            collectedSamples=collectedSamples+1;
            samples(collectedSamples,:)=[osobnik(i,1), osobnik(i,2)];
            distanceFromStart(collectedSamples)=i;
        end
    end

    if collectedSamples>2
        breakPoint=randi([1 collectedSamples-1]);
        startPoint=samples(breakPoint,:);
        stopPoint=samples(breakPoint+1,:);
        startDistance=distanceFromStart(breakPoint);
        stopDistance=distanceFromStart(breakPoint+1);
    else
        breakPoint1=randi([1 len-floor(len*0.9)]);
        breakPoint2=randi([breakPoint1+1, len-1]);
        startPoint=osobnik(breakPoint1,:);
        stopPoint=osobnik(breakPoint2,:);
        startDistance=breakPoint1;
        stopDistance=breakPoint2;
    end
    
    connection=anotherConnectPoints(startPoint, stopPoint, mapTerrainDifficulty, sampleMatrix);
    
    [connectionSize, ~] = size(connection);
    mutated=osobnik(1:startDistance,1:2);
    lenAfterConnection=startDistance+connectionSize;
    mutated(startDistance:lenAfterConnection-1,1:2)=connection(1:connectionSize,1:2);
    mutated(lenAfterConnection:lenAfterConnection+len-stopDistance-1,1:2)=osobnik(stopDistance+1:len,1:2);

end

