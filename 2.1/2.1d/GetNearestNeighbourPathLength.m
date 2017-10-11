function pathLength = GetNearestNeighbourPathLength(cityLocation)

  nbrOfCities = size(cityLocation, 1);

  path = zeros(1, nbrOfCities);
  nodesToVisit = 1:nbrOfCities;

  %Generate NN path
  [currentNode, iCurrentNode] = datasample(nodesToVisit, 1);
  path(1) = currentNode;
  for iCity = 1:nbrOfCities-1
    currentCityLocation = cityLocation(currentNode,:);
    nodesToVisit(iCurrentNode) = [];
    distances = zeros(nbrOfCities-iCity, 1);
    for i = 1:nbrOfCities-iCity
      nextNode = nodesToVisit(i);
      nextCityLocation = cityLocation(nextNode,:);
      distances(i) = norm(nextCityLocation - currentCityLocation);
    end
    [~,iCurrentNode] = min(distances);
    currentNode = nodesToVisit(iCurrentNode);
    path(iCity+1) = currentNode;
  end

  pathLength = GetPathLength(path, cityLocation);

end

