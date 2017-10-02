%% NNPathLengthCalculator
clc; clear all

cityLocations = LoadCityLocations;
nbrOfCities = size(cityLocations, 1);

path = zeros(1, nbrOfCities);
nodesToVisit = 1:nbrOfCities;

%Generate nearest neighbor path
[startingNode, index] = datasample(nodesToVisit, 1);
currentNode = startingNode;
path(1) = currentNode;
for iCity = 1:nbrOfCities-1
  currentCityLocation = cityLocations(currentNode,:);
  nodesToVisit(index) = [];
  distances = zeros(nbrOfCities-iCity, 1);
  for i = 1:nbrOfCities-iCity
    nextNode = nodesToVisit(i);
    nextCityLocation = cityLocations(nextNode,:);
    distances(i) = norm(nextCityLocation - currentCityLocation);
  end
  [~,index] = min(distances);
  currentNode = nodesToVisit(index);
  path(iCity+1) = currentNode;
end

%Compute nearest neighbor path length
pathLength = 0;
for i = 1:nbrOfCities-1
  prevI = path(i);
  nextI = path(i+1);
  previousCityLocation = cityLocations(prevI, :);
  nextCityLocation = cityLocations(nextI, :);
  pathLength = pathLength + norm(nextCityLocation - previousCityLocation);
end
firstCityIndex = path(1);
lastCityIndex = path(nbrOfCities);
firstCityLocation = cityLocations(firstCityIndex);
lastCityLocation = cityLocations(lastCityIndex);
pathLength = pathLength + norm(lastCityLocation - firstCityLocation);

fprintf('Starting at node %d, the nearest neighbor path length is %.2f.\n', ...
  startingNode, pathLength)