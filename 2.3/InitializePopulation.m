function population = InitializePopulation(populationSize, networkDimensions)

  [nbrOfWeights, nbrOfThresholds] = GetNbrOfWeightsAndThresholds(networkDimensions);
  nbrOfGenes = nbrOfWeights+nbrOfThresholds;
  population = zeros(populationSize, nbrOfGenes);

  for i = 1:populationSize
    chromosome = zeros(1, nbrOfGenes);
    for j = 1:nbrOfGenes
      chromosome(j) = rand;
    end
    population(i,:) = chromosome;
  end

end

