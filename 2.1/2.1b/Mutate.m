function mutatedChromosome = Mutate(chromosome, mutationProbability)

  nbrOfGenes = length(chromosome);
  mutatedChromosome = chromosome;
  for i = 1:nbrOfGenes
    r = rand;
    if r < mutationProbability
      swapIndex = randi(nbrOfGenes);
      tmp = mutatedChromosome(i);
      mutatedChromosome(i) = mutatedChromosome(swapIndex);
      mutatedChromosome(swapIndex) = tmp;
    end
  end
  
end

