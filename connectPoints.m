function [ road ] = connectPoints( startPoint, stopPoint, mapTerrainDifficulty, sampleMatrix )

    [len, ~]=size(mapTerrainDifficulty);

    road=startPoint;
    i=1;

    while road(i,1)~=stopPoint(1,1) || road(i,2)~=stopPoint(1,2)
        
        kosztRuchuWX=-1;
        kosztRuchuWY=-1;
        
        yDistance=stopPoint(1,1)-road(i,1);
        xDistance=stopPoint(1,2)-road(i,2);
        
        totalDistance=abs(xDistance)+abs(yDistance);
        xMovePropability=xDistance/totalDistance;
        
      % ogranieczenie zeby przy czytaniu wartosci z mapTerrain czy sampleMatrix
      % nie wychodzic poza indeksy, pare ifow i powinno stykac;
      
        if xDistance>0
                % w prawo, x++
                if road(i,2)+1<=len
                kosztRuchuWX=mapTerrainDifficulty(road(i,1), road(i,2)+1);
                % jesli w poblizu jest probka to zmieniamy xMovePropability
                    if sampleMatrix(road(i,1), road(i,2)+1)==1  
                        xMovePropability=xMovePropability^0.2;
                    else if road(i,2)+2<=len & sampleMatrix(road(i,1), road(i,2)+2)==1 
                        xMovePropability=xMovePropability^0.3;
                    end
                    end
                end
        else
                if road(i,2)-1>=1
                kosztRuchuWX=mapTerrainDifficulty(road(i,1), road(i,2)-1);
                    if sampleMatrix(road(i,1), road(i,2)-1)==1
                        xMovePropability=xMovePropability^0.2;
                    else if road(i,2)-2>=1 & sampleMatrix(road(i,1), road(i,2)-2)==1
                            xMovePropability=xMovePropability^0.3;
                        end
                    end
                end 
        end
        if yDistance>0
                % w dol, y++
               
                if road(i,1)+1<=len
                    kosztRuchuWY=mapTerrainDifficulty(road(i,1)+1, road(i,2));
                    if sampleMatrix(road(i,1)+1, road(i,2))==1
                        xMovePropability=xMovePropability^(1/0.2);
                    else if road(i,1)+2<=len & sampleMatrix(road(i,1)+2, road(i,2))==1
                        xMovePropability=xMovePropability^(1/0.3);
                    end
                    end
                end
        else
               
            
            if road(i,1)-1>=1
                kosztRuchuWY=mapTerrainDifficulty(road(i,1)-1, road(i,2));
                if sampleMatrix(road(i,1)-1, road(i,2))==1
                    xMovePropability=xMovePropability^(1/0.2);
                else if road(i,1)-2>=1 & sampleMatrix(road(i,1)-2, road(i,2))==1
                        xMovePropability=xMovePropability^(1/0.3);
                    end
                end
            end
        end  
       
        
      
        %   jesli koszt ruchu x<y to zwiekszamy prawdopodoienswo wyboru x
        if kosztRuchuWX>0 & kosztRuchuWY>0
            xMovePropability=xMovePropability/(kosztRuchuWX/kosztRuchuWY);
        end
        
        
        if(rand<=abs(xMovePropability))
            road(i+1,1)=road(i,1);
            if xDistance>0
                road(i+1,2)=road(i,2)+1;
            else
                road(i+1,2)=road(i,2)-1;
            end
        else
            road(i+1,2)=road(i,2);
            if yDistance>0
                road(i+1,1)=road(i,1)+1;
            else
                road(i+1,1)=road(i,1)-1;
            end  
        end
        
        i=i+1;
        %   xDist>0 - w prawo
        %   xDist<0 - w lewo
        %   yDist>0 - w dol
        %   yDist<0 - w gore
        %
    end
    
   


end

