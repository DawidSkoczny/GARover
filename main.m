
% zalozmy ze mamy ogarniety algorytm (dijkstry) poszukiwania najlepszej trasy miedzy
% dwoma punktami, wtedy mozemy utworzyc macierz kosztow przejazdu z punktow
% gdzie sa probki. Utworzenie przykladowej macerzy kosztow:
%% przykładowe dane do testowania funkcji

iloscProbek=40;
iloscOsobnikowNaStarcie=100;


 macierzKosztow=rand(iloscProbek)*40+5;
    for i=1:length(macierzKosztow)
        macierzKosztow(i,i)=10^10; %uniemozliwienie zostania w punkcie
        for j=i+1:length(macierzKosztow)
            macierzKosztow(i,j)=macierzKosztow(j,i);
        end
    end
 kosztOdPktPoczatkowego=rand(1,iloscProbek)*40+5;
 populacjaTestowa=randi([0 iloscProbek], [iloscOsobnikowNaStarcie iloscProbek+2]);
 populacjaTestowa(:,1)=randi([1 iloscProbek], [iloscOsobnikowNaStarcie 1])
 clear i j
%%
paliwo=350;
q=0.024;
prawdopodobnienstwoMutacji=0.05;
licznoscPopulacji=150;

nowaPopulacja=selekcjaRankingowa(populacjaTestowa, macierzKosztow, kosztOdPktPoczatkowego, paliwo, licznoscPopulacji, q);

clc %   w konsoli wyswietlaja sie najlepsze wyniki w danej iteracji
for i=1:100
    nowaPopulacja=selekcjaRankingowa(nowaPopulacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo, licznoscPopulacji, q);
    nowaPopulacja=mutowanie( nowaPopulacja, 2, prawdopodobnienstwoMutacji);
end



%%

%{
% kiedy odrzuca zbyt du�� liczbe rozwi�za� to mo�e si� wysypa�
mapa=Map(10, 12);


populacja=start(100,5);
kontrol=kontrola(mapa, populacja, 6, 8); 
populacja1=mutowanie(populacja,1, 0.1);
kontrol1=kontrola(mapa, populacja1, 6, 8)
populacja2=mutowanie(kontrol1,1, 0.1);
kontrol2=kontrola(mapa, populacja2, 6, 8)
populacja3=mutowanie(kontrol2,2, 0.1);
kontrol3=kontrola(mapa, populacja3, 6, 8)

%% test i zabawa
%test
q=0.1;
clc;
for i=1:100
   p(i)=q*(1-q)^(i-1);
end
p
 sum(p)
 %%
q=0.024;
x=0:149;
p=q*(1-q).^x
sum(p)
 
 %}


 
 
 