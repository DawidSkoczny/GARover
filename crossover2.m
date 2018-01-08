function [ road1, road2 ] = crossover2( osobnik1, osobnik2 )
    
%       

    [len1 y]=size(osobnik1);
    [len2 y]=size(osobnik2);
    
    break1=randi([1, len1]);
    break2=randi([1, len2]);
    
    road1=osobnik1(1:break1-1, :);
    connection=ConnectPoints(osobnik1(break1,:), osobnik2(break2+1,:));
    connectionLength=length(connection);
    road1(break1:break1+connectionLength-1,:)=connection;
    road1(break1+connectionLength:break1+connectionLength+len2-break2-1,:)=osobnik2(break2+1:len2,:);
    
    road2=osobnik2(1:break2-1, :);
    connection=ConnectPoints(osobnik2(break2,:), osobnik1(break1+1,:));
    [connectionLength y]=size(connection);
    road2(break2:break2+connectionLength-1,:)=connection(:,:);
    road2(break2+connectionLength:break2+connectionLength+len1-break1-1,:)=osobnik1(break1+1:len1,:);
    
    
    
    
    


end

