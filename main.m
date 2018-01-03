% zalozmy ze mamy ogarniety algorytm (dijkstry) poszukiwania najlepszej trasy miedzy
% dwoma punktami, wtedy mozemy utworzyc macierz kosztow przejazdu z punktow
% gdzie sa probki. Utworzenie przykladowej macerzy kosztow:
%% Przykladowe dane do testowania funkcji

clear variables;
close all;

terrainVariability = 1;
mapSize = 100;
mapSize = abs(floor(mapSize));
terrainVariability = abs(floor(terrainVariability));

iloscProbek = min(50, mapSize);
iloscOsobnikowNaStarcie=150;

mapTerrain = MapTerrain(terrainVariability, mapSize);
sampleMatrix = zeros(mapSize);
samplePositions = zeros(iloscProbek, 2);

j = randi([1 mapSize]);
k = randi([1 mapSize]);

for i = 1:iloscProbek
    while (sampleMatrix(j, k) ~= 0)
        j = randi([1 mapSize]);
        k = randi([1 mapSize]);
    end
    samplePositions(i, :) = [j k];
    sampleMatrix(j, k) = 1;
end
clear sampleMatrix; %Raczej ju� nie b�dzie potrzebna, chyba, �e do
%wy�wietlenie
surf(mapTerrain)
%%
macierzKosztow = CostMatrix(mapSize, mapTerrain, samplePositions);
%%

%macierzKosztow=rand(iloscProbek)*40+5;
%   for i=1:length(macierzKosztow)
%        macierzKosztow(i,i)=10^10; %uniemozliwienie zostania w punkcie
%        for j=i+1:length(macierzKosztow)
%            macierzKosztow(i,j)=macierzKosztow(j,i);
%        end
%    end
 
 kosztOdPktPoczatkowego=rand(1,iloscProbek)*40+5;
 populacjaTestowa=randi([0 iloscProbek], [iloscOsobnikowNaStarcie iloscProbek+2]);
 populacjaTestowa(:,1)=randi([1 iloscProbek], [iloscOsobnikowNaStarcie 1]);
 clear i j
 % zmienne globalne
 global ileRazyFunkcjaCelu;
 global ktorePokolenie
 global sredniaFunkcjiCelu;
 global najlepszeFunkcjeCelu;
 

close all;
ileRazyFunkcjaCelu=0;
ktorePokolenie=1;
sredniaFunkcjiCelu=0;
najlepszeFunkcjeCelu=-inf;


paliwo=50;
q=0.015;
prawdopodobnienstwoMutacji=0.05;
licznoscPopulacji=150;

nowaPopulacja=selekcjaRankingowa(populacjaTestowa, macierzKosztow, kosztOdPktPoczatkowego, paliwo, licznoscPopulacji, q);

clc %   w konsoli wyswietlaja sie najlepsze wyniki w danej iteracji
for i=1:60
    nowaPopulacja=selekcjaRankingowa(nowaPopulacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo, licznoscPopulacji, q);
    nowaPopulacja=mutowanie( nowaPopulacja, 4, prawdopodobnienstwoMutacji);
end
%
close all;
figure(1)
surf(mapTerrain)
figure(2)
subplot(2,1,1)
plot(1:ktorePokolenie-1, sredniaFunkcjiCelu)
grid on

axis([0, 60, -100, 1000]);

title('srednia funkcja celu')
ylabel('srednia funkcji celu')
xlabel('numer pokolenia')

subplot(2,1,2)
plot(1:ktorePokolenie-1, najlepszeFunkcjeCelu)
grid on;
title('najlepsza funcja celu w danym pokoleniu')
ylabel('funkcja celu')
xlabel('numer pokolenia')
axis([0, 60, 350, 500]);


 