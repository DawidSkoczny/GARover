% zalozmy ze mamy ogarniety algorytm (dijkstry) poszukiwania najlepszej trasy miedzy
% dwoma punktami, wtedy mozemy utworzyc macierz kosztow przejazdu z punktow
% gdzie sa probki. Utworzenie przykladowej macerzy kosztow:
%% Przykladowe dane do testowania funkcji

clear variables;
close all;

terrainVariability = 5;
mapSize = 10;

iloscProbek = min(10, mapSize);
iloscOsobnikowNaStarcie=150;

mapTerrain = MapTerrain(terrainVariability, mapSize);
mapSamlpes = zeros(mapSize);

j = randi([1 mapSize]);
k = randi([1 mapSize]);
%%
for i = 0:iloscProbek
    while(mapSamlpes(j, k) ~= 0)
        j = randi([1 mapSize]);
        k = randi([1 mapSize]);
    end
    mapSamlpes(j, k) = i;
end
%%
macirzKosztow


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
 %% zmienne globalne
 global ileRazyFunkcjaCelu;
 global ktorePokolenie
 global sredniaFunkcjiCelu;
 global najlepszeFunkcjeCelu
 
%%
close all;
ileRazyFunkcjaCelu=0;
ktorePokolenie=1;
sredniaFunkcjiCelu=0;
najlepszeFunkcjeCelu=-inf;


paliwo=600;
q=0.015;
prawdopodobnienstwoMutacji=0.05;
licznoscPopulacji=150;

nowaPopulacja=selekcjaRankingowa(populacjaTestowa, macierzKosztow, kosztOdPktPoczatkowego, paliwo, licznoscPopulacji, q);

clc %   w konsoli wyswietlaja sie najlepsze wyniki w danej iteracji
for i=1:50
    nowaPopulacja=selekcjaRankingowa(nowaPopulacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo, licznoscPopulacji, q);
    nowaPopulacja=mutowanie( nowaPopulacja, 4, prawdopodobnienstwoMutacji);
end
%%
close all;
figure(1)
subplot(1,2,1)
plot(1:ktorePokolenie-1, sredniaFunkcjiCelu)
grid on

axis([1, 60, -100, 1000]);

title('srednia funkcja celu')
ylabel('srednia funkcji celu')
xlabel('numer pokolenia')

subplot(1,2,2)
plot(1:ktorePokolenie-1, najlepszeFunkcjeCelu)
grid on;
title('najlepsza funcja celu')
ylabel('funkcja celu')
xlabel('numer pokolenia')

 