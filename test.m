sum = 0;
for i = 1:populationSize
    sum = sum + length(find(~population{i}));
end
sum