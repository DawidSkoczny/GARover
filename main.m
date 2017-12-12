<<<<<<< HEAD
%   parametry:
paliwo=100;


% kiedy odrzuca zbyt duï¿½ï¿½ liczbe rozwiï¿½zaï¿½ to moï¿½e siï¿½ wysypaï¿½
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

=======
% kiedy odrzuca zbyt du¿¹ liczbe rozwi¹zañ to mo¿e siê wysypaæ
mapa=Map(10, 12);
>>>>>>> 93cb3395944677c40ebd3873a1914838a211534a
populacja=start(100,5);
kontrol=kontrola(mapa, populacja, 6, 8); %
populacja1=mutowanie(populacja,1, 0.1);
kontrol1=kontrola(mapa, populacja1, 6, 8)
populacja2=mutowanie(kontrol1,1, 0.1);
kontrol2=kontrola(mapa, populacja2, 6, 8)
populacja3=mutowanie(kontrol2,2, 0.1);
kontrol3=kontrola(mapa, populacja3, 6, 8)
