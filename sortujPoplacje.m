function [posortowanaPopulacja] = sortujPoplacje(populacja, macierzKosztow, kosztOdPktPoczatkowego, paliwo)
  
[x y]=size(populacja);
    posortowanaPopulacja=populacja;
    fCelu=ones(1,x);
    for i=1:x
        
        fCelu(i)=funkcjaCelu(populacja(i,:), macierzKosztow, kosztOdPktPoczatkowego, paliwo)  ;
    end
    [B I]=sort(fCelu, 'descend');
    
    for i=1:x
        posortowanaPopulacja(i,:)=populacja(I(i),:);
    end




end