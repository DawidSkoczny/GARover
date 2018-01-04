%% Generating map of biome
    %selection of random coordinates as biome ovule based on biomeNumber
    %terrain diversification based on biomeVariability
    %Biome propagation on nearby coordinates
    
    %biomeVariability - probability of creating new biome
    %numberOfBiomes - starting number of biomes
    
function map2 = MapBiome( biomeVariability, numberOfBiomes, mapSize)
%%
%biomeVariability = 0.8; % 80% for getting new biome
%numberOfBiomes = 6;
%mapSize = 10;
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
    [~,map2] = bwdist(map, 'euclidean');
    map2 = double(map2);
    
    for i = 1:numberOfBiomes
       indexes = map2 == location(i);
       map2(indexes) = biomeNumber(i);
    end
    %%
    %{
    figure
    surf(map2)
    axis([0 mapSize 0 mapSize -mapSize/numberOfBiomes mapSize/numberOfBiomes])
    title('Map of Biomes')
    %}
%%
end