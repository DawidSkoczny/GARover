function [ wynik ] = funkcjaCelu( osobnik, macierzKosztow, paliwo )
%funkcja celu = (zebrane próbki)- (funkcja kary) -->max
%funkcja kary = przekroczone zużycie paliwa +przejechanie przez niemożliwy do przejechania teren 
% + nie zatrzymanie się w punkcie początkowym
    
    zdobyteProbki=1;
    zuzyciePaliwa=0
    for i=1:(length(osobnik)-1) 
       zuzyciePaliwa=zuzyciePaliwa+macierzKosztow(osobnik(i), osobnik(i+1));
       zdobyteProbki=zdobyteProbki+1;
       for j=i+1:length(osobnik)
           if osobnik(i)==osobnik(j)    %sprawdzam czy nie wrócił w to samo miejsce
               zdobyteProbki=zdobyteProbki-1;
               break;
           end
       end
    end
    zdobyteProbki
    kara=0;
    if zuzyciePaliwa>paliwo
        kara= (zuzyciePaliwa-paliwo)
    end
    wynik=zdobyteProbki*100 - kara*1000;
    %   do zuzycia paliwa trzeba jeszcze dodac paliwo od pkt poczataowego
    %   do pierwszej probki i od ostatniej do pkt. koncowego.
end

