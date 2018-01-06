function [ mutated ] = mutation2( osobnik, mutationPropability )
    
    global sampleMatrix
    

    if rand<mutationPropability
        mutated=osobnik;
        return
    end
    
    
    len=length(osobnik);
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
        startDistance=distanceFromStart(breakPoint1);
        stopDistance=distanceFromStart(len-breakPoint2+1);
    end
    
    connection=ConnectPoints(startPoint, stopPoint);
    mutated=osobnik(1:startDistance,:);
    lenAfterConnection=startDistance+length(connection)
    mutated(startDistance:lenAfterConnection,:)=connection;
    mutated(lenAfterConnection:lenAfterConnection+len-stopDistance+2,:)=osobnik(stopDistance:len,:)
    
    
end

