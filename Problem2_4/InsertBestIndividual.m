function newPopulation = InsertBestIndividual(population, bestIndividual, copiesOfBestIndividual)

  newPopulation = population;
  
  for i = 1:copiesOfBestIndividual
    newPopulation(i).Chromosome = bestIndividual;
  end

end

