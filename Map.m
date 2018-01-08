%% Map properties
function map = Map( terrainVariability, mapSize)

    A = 5 * rand(terrainVariability, terrainVariability) + 1;
    figure(1);
    surf(A);

    X = 1:length(A);
    Y = X;

    ft = 'cubicinterp';
    [xData, yData, zData] = prepareSurfaceData(X, Y, A);
    [fitresult, ~] = fit([xData, yData], zData, ft, 'Normalize', 'on');

    wsp1 = ceil(mapSize / terrainVariability);

    map = zeros(wsp1 * length(A), wsp1 * length(A));
    for i = 1: wsp1 * length(A)
        for j = 1: wsp1 * length(A)
            map(i,j) = fitresult(i / wsp1, j / wsp1);
            if map(i,j) > 5
                map(i,j) = 5; 
            end
        end
    end

    figure(2)
    surf(map)
    colormap(hsv);
end