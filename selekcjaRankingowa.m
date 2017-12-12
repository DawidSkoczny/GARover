function [] = selekcjaRankingowa(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo, iloscNowychOsobnikow)
    posortowanaPopulacja=sortujPoplacje(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo);
    iloscNowychOsobnikow=floor(iloscNowychOsobnikow/2);
    [x y]=size(posortowanaPopulacja);
    %sprobuje puzniej dokonczyc. a to byc selekcja rankingowa dlatego
    %wczesniej segregujemy rozwiazania od najlepszego do najgorszego, potem
    %jakis rozklad prawdopodobienstwa i w zasadzie mozemy skladac algorytm
    %w calosc







end