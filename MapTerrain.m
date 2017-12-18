%% Terrain map generation

function map = MapTerrain( terrainVariability, mapSize)
    map2 = randn(mapSize + 4);
    map2 = map2 + 2 * 1.5;
    xMax = 5;
    xMin = 1;
    map2(map2>xMax) = xMax;
    map2(map2<xMin) = xMin;
    
    h = fspecial('gaussian');
    map2 = filter2(h, map2, 'same');
    
    for i = 1:10 - min(terrainVariability, 9)
        map2 = filter2(h, map2, 'same');
    end
    map(1:mapSize, 1:mapSize) = map2(3:mapSize+2, 3:mapSize+2);
end