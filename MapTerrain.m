%% Terrain map generation

function map = MapTerrain( terrainVariability, mapSize);
    map = randn(mapSize);
    map = map + 2 * 1.5;
    xMax = 5;
    xMin = 1;
    map(map>xMax) = xMax;
    map(map<xMin) = xMin;
    
    h = fspecial('gaussian');
    y = filter2(h, map);
    
    for i = 1:10 + max(-terrainVariability, -9)
        y = filter2(h, y);
    end
end