%% Generating map of terrain

function map2 = MapTerrain( terrainVariability, mapSize)
%%
    xMax = 10;
    xMin = 0;
    marginsOfError = 3;
    
    map = randn(mapSize + 2*marginsOfError);
    map = map * 2*(xMax-xMin)/2.5 + (xMax - xMin)/2;
    map(map>xMax) = xMax + 3 * marginsOfError;
    map(map<xMin) = xMin - 3 * marginsOfError;
    h = fspecial('gaussian');
    map = filter2(h, map, 'same');
    
    for i = 1:10 - min(terrainVariability, 9)
        map = filter2(h, map, 'same');
    end
    map(map>xMax) = xMax;
    map(map<xMin | map <= 0) = max(xMin, 1);
    map(randi([1, mapSize^2], [1, (10 - min(terrainVariability, 9))])) = xMax;
    map2(1:mapSize, 1:mapSize) = map(1+marginsOfError:mapSize+marginsOfError, 1+marginsOfError:mapSize+marginsOfError);
    %{
    figure
    surf(map)
    axis([0 mapSize 0 mapSize -mapSize/2 mapSize/2])
    title('Map of Terrain')
    %}
%%
end