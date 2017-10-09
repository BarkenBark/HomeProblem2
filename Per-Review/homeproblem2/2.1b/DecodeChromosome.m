function x = DecodeChromosome(chromosome, cityLocation)

nGenes = size(chromosome,2);
distance = 0;
for i=1:(nGenes-1)
  deltaX = (cityLocation(chromosome(i),1)-cityLocation(chromosome(i+1),1));
  deltaY = (cityLocation(chromosome(i),2)-cityLocation(chromosome(i+1),2));
  distance = distance + sqrt(deltaX^2+deltaY^2);
  
end
% Get back to start point
deltaXLast = cityLocation(chromosome(1),1)-cityLocation(chromosome(end),1);
deltaYLast = cityLocation(chromosome(1),2) - cityLocation(chromosome(end),2);
distance = distance + sqrt(deltaXLast^2+deltaYLast^2);
x = distance;

end

