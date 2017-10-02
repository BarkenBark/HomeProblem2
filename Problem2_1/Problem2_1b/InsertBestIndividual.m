function newPopulation = InsertBestIndividual(population, bestIndividual, nbrOfBestIndividualCopies)

  newPopulation = population;
  for i = 1:nbrOfBestIndividualCopies
    newPopulation(i,:) = bestIndividual;
  end

end

