function [ wynik ] = funkcjaCelu2( osobnik, terrainMap, samplesMap )

    [iloscRuchow y]=size(osobnik)

    petrolCost=0;
    samplesAchived=0;

    for i=1:iloscRuchow
        petrolCost=petrolCost+terrainMap(osobnik(i,1), osobnik(i,2));
        if samplesMap(osobnik(i,1), osobnik(i,2))==1
            samplesAchived=samplesAchived+1;
        end
    end
    wynik=[ petrolCost, samplesAchived ];
end
%   obliczenie dijkstra odleglosci koncowego punktu i funkcja kary