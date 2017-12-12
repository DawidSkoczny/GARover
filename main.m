%   parametry:
paliwo=100;


% kiedy odrzuca zbyt du�� liczbe rozwi�za� to mo�e si� wysypa�
mapa=rand(10);

% zalozmy ze mamy ogarniety algorytm (dijkstry) poszukiwania najlepszej trasy miedzy
% dwoma punktami, wtedy mozemy utworzyc macierz kosztow przejazdu z punktow
% gdzie sa probki. Utworzenie przykladowej macerzy kosztow:
%%
 macierzKosztow=rand(10)*40+5;
    for i=1:length(macierzKosztow)
        macierzKosztow(i,i)=999999999999; %uniemozliwienie zostania w punkcie
        for j=i+1:length(macierzKosztow)
            macierzKosztow(i,j)=macierzKosztow(j,i);
        end
    end
%%

populacja=start(100,5);
kontrol=kontrola(mapa, populacja, 6, 8); %
populacja1=mutowanie(populacja,1, 0.1);
kontrol1=kontrola(mapa, populacja1, 6, 8)
populacja2=mutowanie(kontrol1,1, 0.1);
kontrol2=kontrola(mapa, populacja2, 6, 8)
populacja3=mutowanie(kontrol2,2, 0.1);
kontrol3=kontrola(mapa, populacja3, 6, 8)
