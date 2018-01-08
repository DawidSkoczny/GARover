function [posortowanaPopulacja] = sortujPoplacje(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo)
  
global ktorePokolenie
global sredniaFunkcjiCelu

[x, ~]=size(populacja);
    posortowanaPopulacja=populacja;
    fCelu=ones(1,x);
    
    for i=1:x    
        fCelu(i)=funkcjaCelu(populacja(i,:), macierzKosztow, kosztOdPktPoczatkowego, paliwo)  ;
    end
    
    [~, I]=sort(fCelu, 'descend');
    sredniaFunkcjiCelu(ktorePokolenie)=mean(fCelu);
    
    for i=1:x
        posortowanaPopulacja(i,:)=populacja(I(i),:);
    end

end