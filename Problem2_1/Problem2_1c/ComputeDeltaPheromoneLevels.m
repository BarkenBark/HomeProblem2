function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection, pathLengthCollection)

  numberOfAnts = length(pathLengthCollection);
  numberOfCities = size(pathCollection, 2);
  deltaPheromoneLevel = zeros(numberOfCities);
  
  for k = 1:numberOfAnts
   tmp = zeros(numberOfCities);
   path = pathCollection(k,:);
   D = pathLengthCollection(k);
   
   for iPath = 1:numberOfCities-1
     j = path(iPath);
     i = path(iPath+1);
     tmp(i,j) = 1/D;
     tmp(j,i) = 1/D;
   end
   j = path(numberOfCities);
   i = path(1);
   tmp(i,j) = 1/D;
   tmp(j,i) = 1/D;
   
   deltaPheromoneLevel = deltaPheromoneLevel + tmp;
  end

end

