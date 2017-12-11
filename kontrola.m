%œrednio to wysz³o, przy du¿êj iloœci odrzuconych algo siê wysypie
function [ sterowanie1 ] = kontrola( mapa, sterowanie, Xstart, Ystart)
[m,n]=size(sterowanie);
[c,d]=size(mapa)
sterowanie1=sterowanie;
control_numb=0;
for i = 1:m
    x=Xstart;
    y=Ystart;
    for j = 1:n
      a=sterowanie(i, j);
      switch a
          case 1
              y=y-1;
          case 2
              x=x+1;
          case 3
              y=y+1;
          case 4
              x=x-1;
      end 
      if((y<0)|(x<0)|(y>c)|(x>d))
         for j = 1:n;
            sterowanie1(i, : )=0; %zostawiam ¿eby widzieæ ewentualne b³êdy w dzia³aniu
         end
         sterowanie1(i-control_numb, : )=[];
         control_numb=control_numb+1
      end      
   end    
end   
end
