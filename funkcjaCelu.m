function [ wynik ] = funkcjaCelu( osobnik, macierzKosztow, kosztOdPoczatakowego, paliwo )
%funkcja celu = (zebrane próbki)- (funkcja kary) -->max
%funkcja kary = przekroczone zużycie paliwa +przejechanie przez niemożliwy do przejechania teren 
% + nie zatrzymanie się w punkcie początkowym
    global ileRazyFunkcjaCelu 
    ileRazyFunkcjaCelu=ileRazyFunkcjaCelu+1;
    dlugoscTrasy=0;
    
    for i=1:length(osobnik)
        if osobnik(i) ~= 0
            dlugoscTrasy=dlugoscTrasy+1;
        else
            break;
        end
    end
    
    zdobyteProbki=1;
    zuzyciePaliwa=kosztOdPoczatakowego(osobnik(1)) + kosztOdPoczatakowego(osobnik(dlugoscTrasy));
    
    %na pozniej:
    %zużycie paliwa= (1+b*n)*a*(MacierzKosztow(i,i+1))
        %a - bazowe zużycie paliwa
        %b - współczynnik masy próbki << 1
        %n - ilość zdobytych próbek

    
    for i=1:(dlugoscTrasy-1) 
        zuzyciePaliwa=zuzyciePaliwa+macierzKosztow(osobnik(i), osobnik(i+1));
  
       flaga=1;
       for j=i+1:dlugoscTrasy
           
           if osobnik(i)==osobnik(j)    %sprawdzam czy nie wrócił w to samo miejsce
               flaga=0;
               break;
           end
       end
       if flaga 
           zdobyteProbki=zdobyteProbki+1;
       end
           
    end
    
    zdobyteProbki;       %wyswietlam do testu
    dlugoscTrasy; 
    zuzyciePaliwa;
    kara=0;
    if zuzyciePaliwa>paliwo
        kara= (zuzyciePaliwa-paliwo);
    end
    wynik=zdobyteProbki*10 - kara*2;
end

