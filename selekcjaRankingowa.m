function [nowaPopulacja] = selekcjaRankingowa(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo, iloscNowychOsobnikow, q)
    % selekcja rankingowa nieliniowa
    global ktorePokolenie
    global najlepszeFunkcjeCelu
    

    posortowanaPopulacja=sortujPoplacje(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo);
    iloscNowychOsobnikow=floor(iloscNowychOsobnikow/2);
    [x, y]=size(posortowanaPopulacja);
    
    %parametr q - prawdopodobienstwo dla najlepszego osobnika;
    tmp=funkcjaCelu( posortowanaPopulacja(1,:), macierzKosztow, kosztOdPktPoczatkowego, paliwo);
    najlepszeFunkcjeCelu(ktorePokolenie)=tmp;
    
    pWzorcowe=q*(1-q).^[0:x-1];
    
    for i=2:x
        pWzorcowe(i)=pWzorcowe(i)+pWzorcowe(i-1); % cos  w rodzaju dystrybuanty
    end
    
    nowaPopulacja=zeros(iloscNowychOsobnikow*2, y);
    licznik=1;
    
    while (iloscNowychOsobnikow > 0)
        iloscNowychOsobnikow=iloscNowychOsobnikow-1;
        
        numOsobnika1=0;
        numOsobnika2=0;
        
        while(numOsobnika1 == 0)
            P=rand;
            for i=1:x
                if P<pWzorcowe(i)
                    numOsobnika1=i;
                    break;
                end
            end
        end
        
        while(numOsobnika2 == 0)
            P=rand;
            for i=1:x
                if P<pWzorcowe(i)
                    numOsobnika2=i;
                    break;
                end
            end
        end
        
        [nowaPopulacja(licznik, :), nowaPopulacja(licznik+1, :) ]=TwoPointCrossover(posortowanaPopulacja(numOsobnika1,:), posortowanaPopulacja(numOsobnika2,:));
        licznik=licznik+2;
         
    end
    
    ktorePokolenie=ktorePokolenie+1;
end