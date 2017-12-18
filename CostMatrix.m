function cost = CostMatrix (mapSize, mapTerrain, samplePositions)

    mapSizeSquared = mapSize * mapSize;
    
%% A - Adjacency Martix
    adjacencyMatrix = zeros (mapSizeSquared);
    for i = 1:mapSize^2;
        if (mod(i, mapSize) ~= 0)
            adjacencyMatrix(i, i + 1) = 1;
        end
        if (i <= mapSize^2 - mapSize)
            adjacencyMatrix(i, i + mapSize) = 1;
        end
    end
    adjacencyMatrix = adjacencyMatrix + transpose(adjacencyMatrix);
    
%% C - Cost Matrix
    costMatrix = zeros (mapSizeSquared);
    j = 1;
    for i = 1:mapSizeSquared;
        k = fix((i - 1) / mapSize) + 1;
        if (k == 1) %pierwsza krata
            if (j == 1)
                costMatrix(i, i + 1) = abs(mapTerrain(k, j) - mapTerrain(k, j + 1));
                costMatrix(i, i + mapSize) = abs(mapTerrain(k, j) - mapTerrain(k + 1, j));
                j = j + 1;
            elseif (j == mapSize)
                costMatrix(i, i - 1) = abs(mapTerrain(k, j) - mapTerrain(k, j - 1));
                costMatrix(i, i + mapSize) = abs(mapTerrain(k, j) - mapTerrain(k + 1, j));
                j = 1;
            else
                costMatrix(i, i - 1) = abs(mapTerrain(k, j) - mapTerrain(k, j - 1));
                costMatrix(i, i + 1) = abs(mapTerrain(k, j) - mapTerrain(k, j + 1));
                costMatrix(i, i + mapSize) = abs(mapTerrain(k, j) - mapTerrain(k + 1, j));
                j = j + 1;
            end
        elseif (k == mapSize) %ostatnia krata
            if (j == 1)
                costMatrix(i, i - mapSize) = abs(mapTerrain(k, j) - mapTerrain(k - 1, j));
                costMatrix(i, i + 1) = abs(mapTerrain(k, j) - mapTerrain(k, j + 1));
                j = j + 1;
            elseif (j == mapSize)
                costMatrix(i, i - mapSize) = abs(mapTerrain(k, j) - mapTerrain(k - 1, j));
                costMatrix(i, i - 1) = abs(mapTerrain(k, j) - mapTerrain(k, j - 1));
                j = 1;
            else
                costMatrix(i, i - mapSize) = abs(mapTerrain(k, j) - mapTerrain(k - 1, j));
                costMatrix(i, i - 1) = abs(mapTerrain(k, j) - mapTerrain(k, j - 1));
                costMatrix(i, i + 1) = abs(mapTerrain(k, j) - mapTerrain(k, j + 1));
                j = j + 1;
            end
        else %pozostale kraty
            if (j == 1)
                costMatrix(i, i - mapSize) = abs(mapTerrain(k, j) - mapTerrain(k - 1, j));
                costMatrix(i, i + 1) = abs(mapTerrain(k, j) - mapTerrain(k, j + 1));
                costMatrix(i, i + mapSize) = abs(mapTerrain(k, j) - mapTerrain(k + 1, j));
                j = j + 1;
            elseif (j == mapSize)
                costMatrix(i, i - mapSize) = abs(mapTerrain(k, j) - mapTerrain(k - 1, j));
                costMatrix(i, i - 1) = abs(mapTerrain(k, j) - mapTerrain(k, j - 1));
                costMatrix(i, i + mapSize) = abs(mapTerrain(k, j) - mapTerrain(k + 1, j));
                j = 1;
            else
                costMatrix(i, i - mapSize) = abs(mapTerrain(k, j) - mapTerrain(k - 1, j));
                costMatrix(i, i - 1) = abs(mapTerrain(k, j) - mapTerrain(k, j - 1));
                costMatrix(i, i + 1) = abs(mapTerrain(k, j) - mapTerrain(k, j + 1));
                costMatrix(i, i + mapSize) = abs(mapTerrain(k, j) - mapTerrain(k + 1, j));
                j = j + 1;
            end
        end
    end
    
    %w gore  = abs(mapTerrain(k, j) - mapTerrain(k - 1, j));
    %w lewo  = abs(mapTerrain(k, j) - mapTerrain(k, j - 1));
    %w prawo = abs(mapTerrain(k, j) - mapTerrain(k, j + 1));
    %w dol   = abs(mapTerrain(k, j) - mapTerrain(k + 1, j));
    
%% SID = FID - Sample Positions

    SID = (samplePositions (:, 1) - 1) * mapSize + samplePositions (:, 2);

    [cost, path] = dijkstra(adjacencyMatrix, costMatrix, SID, SID);

end