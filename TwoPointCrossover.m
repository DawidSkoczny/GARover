function [ nowyOsobnik1, nowyOsobnik2 ] = TwoPointCrossover( osobnik1, osobnik2 )
%   operator pseudogenetyczny PMX
%   Partial-Mapped Crossover
%   krzyżowanie dwuch osobnikow

    [x1 y1]=size(osobnik1);
    [x2 y2]=size(osobnik2);
    if (x1 ~= x2 ) | (y1 ~= y2) | (x1 ~= 1)
        error('Error \n  osobniki nie mają tych samych wymiarów')
        
    end 
    nowyOsobnik1=osobnik1;
    nowyOsobnik2=osobnik2;
    
    ileZamienic=randi([1 y1-1]);
    gdzieZamienic=randi([1, y1-ileZamienic]);
    
    doZamiany=gdzieZamienic:(gdzieZamienic+ileZamienic)
    
    zamiana1=osobnik1(1, doZamiany)
    zamiana2=osobnik2(1, doZamiany)
    nowyOsobnik1(1, doZamiany)=zamiana2;
    nowyOsobnik2(1, doZamiany)=zamiana1;
        



end

