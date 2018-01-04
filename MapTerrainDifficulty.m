%% Generating map of terrain difficulty

function mapTerrainDifficulty = MapTerrainDifficulty( mapTerrain, mapBiome)
%%
    mapTerrainDifficulty = 6/10 * mapTerrain + 4/10 * mapBiome;
    mapTerrainDifficulty(mapTerrain == 10) = 10; %xMax form MapTerrain
%%
end