function population = InitializePopulation(populationSize, nbrOfGenes)

  population = zeros(populationSize, nbrOfGenes);

  for i = 1:populationSize
    population(i,:) = randperm(nbrOfGenes);
  end
  
end

