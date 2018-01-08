%% Generating map of biome
    %selection of random coordinates as biome ovule based on biomeNumber
    %terrain diversification based on biomeVariability
    %Biome propagation on nearby coordinates
    
    %biomeVariability - probability of creating new biome
    %numberOfBiomes - starting number of biomes
    
function map = MapBiome( biomeVariability, numberOfBiomes, mapSize)
%%
%{
biomeVariability = 0.8; % 80% for getting new biome
numberOfBiomes = 10;
mapSize = 100;
%}
%%
    map = zeros(mapSize);
    
    location = randi([1, mapSize^2], [1, numberOfBiomes]);
    
    numberOfBiomesAssigned = 1;
    for i = 1:numberOfBiomes
        if(biomeVariability > rand)
            biomeNumber(i) = numberOfBiomesAssigned;
        else
            biomeNumber(i) = randi([1,numberOfBiomesAssigned], 1);
            numberOfBiomesAssigned = numberOfBiomesAssigned - 1;
        end
        numberOfBiomesAssigned = numberOfBiomesAssigned + 1;    
    end
    
    for i = 1:numberOfBiomes
        map(location(i)) = biomeNumber(i);
    end
    
    %%
    [~,map] = bwdist(map, 'euclidean');
    map = double(map);
    
    for i = 1:numberOfBiomes
       indexes = map == location(i);
       map(indexes) = biomeNumber(i);
    end
    %%
    %{
    figure
    surf(map)
    axis([0 mapSize 0 mapSize -mapSize/numberOfBiomes mapSize/numberOfBiomes])
    title('Map of Biomes')
    %}
%%
end