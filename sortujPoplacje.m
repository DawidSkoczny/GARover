function [posortowanaPopulacja B] = sortujPoplacje(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo)
  
[x y]=size(populacja)
    posortowanaPopulacja=populacja;
    fCelu=ones(1,x);
    for i=1:x
        
        fCelu(i)=funkcjaCelu(populacja(i,:), macierzKosztow, kosztOdPktPoczatkowego, paliwo)  ;
    end
    [B I]=sort(fCelu);
    
    for i=1:x
        posortowanaPopulacja(i,:)=populacja(I(i),:);
    end




end