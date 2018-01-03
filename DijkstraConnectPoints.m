function [ cost, path ] = polaczPunkty( startPoint, finishPoint )


xdim=abs(startPoint(2)-finishPoint(2))+1;
ydim=abs(startPoint(1)-finishPoint(1))+1;

% A - Adjacency Martix
    lewyGorny=[min(startPoint(1), finishPoint(1)), min(startPoint(2), finishPoint(2))];
    adjacencyMatrix = zeros (xdim*ydim);
    costsMatrix = zeros (xdim*ydim);
    for y = 1:ydim
        
        for x = 1:xdim
          if x>1  
            adjacencyMatrix((y-1)*xdim+x,(y-1)*xdim+x-1)=1;
            costsMatrix((y-1)*xdim+x,(y-1)*xdim+x-1)=mapTerrain(lewyGorny(1)+y-1, lewyGorny(2)+x-2);
          end
          if x<xdim
            adjacencyMatrix((y-1)*xdim+x,(y-1)*xdim+x+1)=1;
            costsMatrix((y-1)*xdim+x,(y-1)*xdim+x+1)=mapTerrain(lewyGorny(1)+y-1, lewyGorny(2)+x);
          end
          if y>1  
            adjacencyMatrix((y-1)*xdim+x,(y-2)*xdim+x)=1;
            costsMatrix((y-1)*xdim+x,(y-2)*xdim+x)=mapTerrain(lewyGorny(1)+y-2, lewyGorny(2)+x-1);
          end
          if y<ydim
            adjacencyMatrix((y-1)*xdim+x,(y)*xdim+x)=1;
            costsMatrix((y-1)*xdim+x,(y)*xdim+x)=mapTerrain(lewyGorny(1)+y, lewyGorny(2)+x-1);
          end     
        end
    end
    
    SID = (startPoint(1)-lewyGorny(1))*xdim + startPoint(2) - lewyGorny(2)+1;
    FID = (finishPoint(1)-lewyGorny(1))*xdim + finishPoint(2) - lewyGorny(2)+1;
    [cost, path] = dijkstra(adjacencyMatrix, costsMatrix, SID, FID)

end

