%% Generating map of terrain difficulty

function mapTerrainDifficulty = MapTerrainDifficulty( mapTerrain, mapBiome)
%%
    mapTerrainDifficulty = 4/10 * mapTerrain + 6/10 * mapBiome;
    mapTerrainDifficulty(mapTerrain == 10) = 10; %xMax form MapTerrain
    mapTerrainDifficulty(mapBiome == 10) = 10; %xMax form MapTerrain
%%
end