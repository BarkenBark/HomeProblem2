function pathLength = GetNearestNeighbourPathLength(cityLocation)

  nbrOfCities = size(cityLocation, 1);

  path = zeros(1, nbrOfCities);
  nodesToVisit = 1:nbrOfCities;

  %Generate NN path
  [currentNode, index] = datasample(nodesToVisit, 1);
  path(1) = currentNode;
  for iCity = 1:nbrOfCities-1
    currentCityLocation = cityLocation(currentNode,:);
    nodesToVisit(index) = [];
    distances = zeros(nbrOfCities-iCity, 1);
    for i = 1:nbrOfCities-iCity
      nextNode = nodesToVisit(i);
      nextCityLocation = cityLocation(nextNode,:);
      distances(i) = norm(nextCityLocation - currentCityLocation);
    end
    [~,index] = min(distances);
    currentNode = nodesToVisit(index);
    path(iCity+1) = currentNode;
  end

  %Compute path length
  pathLength = 0;
  for i = 1:nbrOfCities-1
    prevI = path(i);
    nextI = path(i+1);
    previousCityLocation = cityLocation(prevI, :);
    nextCityLocation = cityLocation(nextI, :);
    pathLength = pathLength + norm(nextCityLocation - previousCityLocation);
  end
  firstCityIndex = path(1);
  lastCityIndex = path(nbrOfCities);
  firstCityLocation = cityLocation(firstCityIndex);
  lastCityLocation = cityLocation(lastCityIndex);
  pathLength = pathLength + norm(lastCityLocation - firstCityLocation);

end

