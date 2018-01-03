function [ road ] = ConnectPoints( startPoint, stopPoint )

%   startPoint, stopPoint - vectors 1x2  [y x]


    road=startPoint;
    i=1;

    while road(i,1)~=stopPoint(1,1) || road(i,2)~=stopPoint(1,2)
        
        yDistance=stopPoint(1,1)-road(i,1);
        xDistance=stopPoint(1,2)-road(i,2);
       
        totalDistance=abs(xDistance)+abs(yDistance);
        xMovePropability=xDistance/totalDistance;
        
        
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

