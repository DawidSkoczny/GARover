%% Generating map of terrain

function map = MapTerrain( terrainVariability, mapSize)
%%
    xMax = 10;
    xMin = 0;
    marginsOfError = 3;
    
    map2 = randn(mapSize + 2*marginsOfError);
    map2 = map2 * 2*(xMax-xMin)/2.5 + (xMax - xMin)/2;
    map2(map2>xMax) = xMax + 3 * marginsOfError;
    map2(map2<xMin) = xMin - 3 * marginsOfError;
    h = fspecial('gaussian');
    map2 = filter2(h, map2, 'same');
    
    for i = 1:10 - min(terrainVariability, 9)
        map2 = filter2(h, map2, 'same');
    end
    map2(map2>xMax) = xMax;
    map2(map2<xMin | map2 <= 0) = max(xMin, 1);
    map2(randi([1, mapSize^2], [1, (10 - min(terrainVariability, 9))])) = xMax;
    map(1:mapSize, 1:mapSize) = map2(1+marginsOfError:mapSize+marginsOfError, 1+marginsOfError:mapSize+marginsOfError);
    %{
    figure
    surf(map)
    axis([0 mapSize 0 mapSize -mapSize/2 mapSize/2])
    title('Map of Terrain')
    %}
%%
end