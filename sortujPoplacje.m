function [posortowanaPopulacja B] = sortujPoplacje(populacja, macierzKosztow, kosztOdPoczatakowego, paliwo)
%jeszcze nie skonczone    
[x y]=size(populacja)
    posortowanaPopulacja=populacja;
    %fCelu=ones(x,1);
    for i=1:x
        fCelu(i)=funkcjaCelu(populacja(x,:), macierzKosztow, kosztOdPoczatakowego, paliwo)
    end
    [B I]=sort(fCelu);
    I
    fCelu
    B
    for i=1:x
        posortowanaPopulacja(i,:)=populacja(I(i),:);
    end




end