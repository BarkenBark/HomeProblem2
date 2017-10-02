function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)

  numberOfCities = size(pheromoneLevel,1);
  
  startingNode = randi(numberOfCities);
  tabuList(1) = startingNode;
  
  for i = 2:numberOfCities
    nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta);
    tabuList(i) = nextNode;
  end
  
  path = tabuList;

end

