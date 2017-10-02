function pathLength = GetPathLength(chromosome, cityLocation)

  nbrOfCities = size(cityLocation, 1);
  pathLength = 0;
  
  for i = 1:nbrOfCities-1
    prevNode = chromosome(i);
    nextNode = chromosome(i+1);
    previousCityLocation = cityLocation(prevNode, :);
    nextCityLocation = cityLocation(nextNode, :);
    pathLength = pathLength + norm(nextCityLocation-previousCityLocation);
  end
  firstCityIndex = chromosome(1);
  lastCityIndex = chromosome(nbrOfCities);
  firstCityLocation = cityLocation(firstCityIndex, :);
  lastCityLocation = cityLocation(lastCityIndex, :);
  pathLength = pathLength + norm(lastCityLocation - firstCityLocation);

end

