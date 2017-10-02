function probability = GetProbability(tabuList, pheromoneLevel, visibility, alpha, beta)

  numberOfCities = size(pheromoneLevel, 1);
  nodes = 1:numberOfCities;
  candidateNodes = setdiff(nodes, tabuList);
  numberOfCandidateNodes = length(candidateNodes);
  
  probability = zeros(1, numberOfCandidateNodes);
  
  j = tabuList(end);
  normalizingDenominator = 0;
  
  for l = candidateNodes
    tmp = pheromoneLevel(l,j)^alpha * visibility(l,j)^beta;
    normalizingDenominator = normalizingDenominator + tmp;
  end
  if normalizingDenominator == 0 %If pheromone levels are too low to be numerically processed, uniformly chose next node
    probability = rand(1, numberOfCandidateNodes);
    probability = probability/sum(probability);
    disp('Pheromone levels on some edges have dropped very low.')
    disp('Ants follow locally optimal path almost definitively.')
    disp('Restart of optimization is with other parameters is recommended.')
    disp(' ')
    return
  end
  
  iProb = 0;
  for i = candidateNodes
    tmp = pheromoneLevel(i,j)^alpha * visibility(i,j)^beta;
    iProb = iProb + 1;
    probability(iProb) = tmp/normalizingDenominator;
  end

end

