function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)

numberOfAnts = size(pathCollection,1);
numberOfCities = size(pathCollection,2);
deltaPheromoneLevel = zeros(numberOfCities, numberOfCities);
for i = 1:numberOfAnts
  for j = 1:(numberOfCities-1)
    indexI = pathCollection(i,j); % from node I
    indexJ = pathCollection(i,j+1); % to node J
    deltaPheromoneLevel(indexI, indexJ) = deltaPheromoneLevel(indexI, indexJ) + 1/pathLengthCollection(i,1);
  end
  % Pheromones from last city to start city
  startCityIndex = pathCollection(i,1);
  lastCityIndex = pathCollection(i,end);
  deltaPheromoneLevel(startCityIndex, lastCityIndex) = ...
    deltaPheromoneLevel(startCityIndex,lastCityIndex) + 1/pathLengthCollection(i,1);
end

end

