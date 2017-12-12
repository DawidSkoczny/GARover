function [nowaPopulacja] = selekcjaRankingowa(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo, iloscNowychOsobnikow, q)

    % selekcja rankingowa nieliniowa

    posortowanaPopulacja=sortujPoplacje(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo);
    iloscNowychOsobnikow=floor(iloscNowychOsobnikow/2);
    [x y]=size(posortowanaPopulacja);
    
    %parametr q - prawdopodobienstwo dla najlepszego osobnika;
    funkcjaCelu( posortowanaPopulacja(1,:), macierzKosztow, kosztOdPktPoczatkowego, paliwo)
    pWzorcowe=q*(1-q).^[0:x-1];
    for i=2:x
        pWzorcowe(i)=pWzorcowe(i)+pWzorcowe(i-1); % cos  w rodzaju dystrybuanty
    end
    
    nowaPopulacja=zeros(iloscNowychOsobnikow*2, y);
    licznik=1;
    numOsobnika1=1;
    numOsobnika2=2;
    while (iloscNowychOsobnikow > 0)
        iloscNowychOsobnikow=iloscNowychOsobnikow-1;
        P=rand;
        for i=1:x
            if P<pWzorcowe(i)
                numOsobnika1=i;
                break;
            end
        end
    
        P=rand;
        for i=1:x
            if P<pWzorcowe(i)
                numOsobnika2=i;
                break;
            end
        end
        
        [nowaPopulacja(licznik, :), nowaPopulacja(licznik+1, :) ]=TwoPointCrossover(posortowanaPopulacja(numOsobnika1,:), posortowanaPopulacja(numOsobnika2,:));
        licznik=licznik+2;
    end
    
    
    
    %sprobuje puzniej dokonczyc. a to byc selekcja rankingowa dlatego
    %wczesniej segregujemy rozwiazania od najlepszego do najgorszego, potem
    %jakis rozklad prawdopodobienstwa i w zasadzie mozemy skladac algorytm
    %w calosc







end