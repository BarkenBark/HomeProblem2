function fitness = EvaluateIndividual(chromosome, cityLocations)
  
  pathLength = GetPathLength(chromosome, cityLocations); 
  fitness = 1/pathLength;

end

