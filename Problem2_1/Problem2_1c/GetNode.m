function node = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta)

  numberOfCities = size(pheromoneLevel, 1);
  nodes = 1:numberOfCities;
  candidateNodes = setdiff(nodes, tabuList);
  numberOfCandidateNodes = length(candidateNodes);
  
  if numberOfCandidateNodes == 1
    node = candidateNodes;
    return
  end

  nextNodeProbability = GetProbability(tabuList, pheromoneLevel, visibility, alpha, beta); 
  
  r = rand;
  cumulativeProbability = 0;
  for iNode = 1:numberOfCandidateNodes
    cumulativeProbability = cumulativeProbability + nextNodeProbability(iNode);
    if r <= cumulativeProbability
      node = candidateNodes(iNode);
      return
    end
  end
  
end

