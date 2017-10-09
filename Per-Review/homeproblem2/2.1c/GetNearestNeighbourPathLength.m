function [nearestNeighbourPathLength,neighbour, tabuList] = GetNearestNeighbourPathLength( cityLocations )
% Calculate the nearest neighbour path, to compute tau0.
numberOfCities = size(cityLocations,1);
nearestNeighbour = ones(1, numberOfCities)*10e7;
randomStartIndex = randi(numberOfCities);
tabuList = zeros(1, numberOfCities);
tabuList(1) = randomStartIndex;
nearestNeighbour(1) = 0;
for j = 2:numberOfCities
  tempNodeIndex = find(tabuList,1, 'last');
  currentNode = tabuList(tempNodeIndex);
  neighbour = zeros(1, numberOfCities);
  for i =1:numberOfCities
    if ismember(i, tabuList)
      % If it is in tabuList, will set to long distance.
      neighbour(i) = numberOfCities*10e7;
    else
      deltaX = cityLocations(currentNode,1)-cityLocations(i,1);
      deltaY = cityLocations(currentNode,2) - cityLocations(i,2);
      neighbour(i) = sqrt(deltaX^2+deltaY^2);
    end
  end
  nearestNeighbour(j) = min(neighbour);
  [~, index] = min(neighbour);
  tabuList (j) = index;
end
% Distance from last city to start city
deltaX = cityLocations(tabuList(1),1)-cityLocations(tabuList(end),1);
deltaY = cityLocations(tabuList(1),2) - cityLocations(tabuList(end),2);
nearestNeighbour(end) = sqrt(deltaX^2+deltaY^2);
length(nearestNeighbour)
nearestNeighbourPathLength = sum(nearestNeighbour);

