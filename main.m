% kiedy odrzuca zbyt du�� liczbe rozwi�za� to mo�e si� wysypa�
mapa=rand(10);
populacja=start(100,5);
kontrol=kontrola(mapa, populacja, 6, 8); %
populacja1=mutowanie(populacja,1);
kontrol1=kontrola(mapa, populacja1, 6, 8)
populacja2=mutowanie(kontrol1,1);
kontrol2=kontrola(mapa, populacja2, 6, 8)
populacja3=mutowanie(kontrol2,2);
kontrol3=kontrola(mapa, populacja3, 6, 8)