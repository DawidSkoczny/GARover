% funkcja mieszajaca losowo cechy populacji
function [ populacja ] = mutowanie( populacja_startowa, ile_cech_mieszac, prawdopodobienstwo_mutacji)
populacja= populacja_startowa;
[m,n] = size(populacja);
for i = 1:m; 
    x=0;
    while x<ile_cech_mieszac  && prawdopodobienstwo_mutacji >= rand
      a=randi([1 n]);
      populacja(i,a)=populacja_startowa(randi([1 m]),a);
      x=x+1;
    end
end
end

