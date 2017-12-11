% inicjacja pierwszej populacji
function [ populacja_startowa ] = start( ile_osobnikow, ile_cech)
populacja_startowa = randi([1, 4], [ile_osobnikow,ile_cech]);
% cechy przydzielone od 1 do 4, bo mo¿liwe poruszanie w 4 strony (1 - góra, 2 - prawo, 3- dó³, 4 - lewo )
end
