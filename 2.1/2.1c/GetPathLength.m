function pathLength = GetPathLength(path, cityLocation)

  nbrOfCities = size(cityLocation, 1);
  pathLength = 0;
  
  for i = 1:nbrOfCities-1
    prevNode = path(i);
    nextNode = path(i+1);
    previousCityLocation = cityLocation(prevNode, :);
    nextCityLocation = cityLocation(nextNode, :);
    pathLength = pathLength + norm(nextCityLocation-previousCityLocation);
  end
  firstCityIndex = path(1);
  lastCityIndex = path(nbrOfCities);
  firstCityLocation = cityLocation(firstCityIndex, :);
  lastCityLocation = cityLocation(lastCityIndex, :);
  pathLength = pathLength + norm(lastCityLocation - firstCityLocation);

end

