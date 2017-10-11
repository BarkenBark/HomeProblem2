function mutatedChromosome = Mutate(chromosome, mutationProbability, setSizes)

  nbrOfOperators = setSizes(1);
  nbrOfVariableRegisters = setSizes(2);
  nbrOfOperands = setSizes(2) + setSizes(3);
  
  mutationRanges = [nbrOfOperators nbrOfVariableRegisters ...
                    nbrOfOperands nbrOfOperands];

  chromosomeLength = length(chromosome);
  mutatedChromosome = chromosome;

  for i = 1:4:chromosomeLength
    for j = 0:3
      if rand < mutationProbability
        mutatedChromosome(i+j) = randi(mutationRanges(j+1));
      end
    end
  end

end

