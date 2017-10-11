function population = InitializePopulation(populationSize, setSizes, minNbrOfInstructions, maxNbrOfInstructions)
%InitializePopulation Generate a population of chromosomes which encode for
%an instruction on the form: register = operator(operand1, operand2)

  nbrOfOperators = setSizes(1);
  nbrOfVariableRegisters = setSizes(2);
  nbrOfOperands = setSizes(2) + setSizes(3);

  population = [];
  for i = 1:populationSize
    nbrOfInstructions = (minNbrOfInstructions + ...
      fix(rand*(maxNbrOfInstructions - minNbrOfInstructions + 1)));
    chromosomeLength = 4*nbrOfInstructions;
    tmpChromosome = zeros(1, chromosomeLength);
    
    for j = 1:4:chromosomeLength
    tmpChromosome(j) = randi(nbrOfOperators);
    tmpChromosome(j+1) = randi(nbrOfVariableRegisters);
    tmpChromosome(j+2) = randi(nbrOfOperands);
    tmpChromosome(j+3) = randi(nbrOfOperands);
    end
      
    tmpIndividual = struct('Chromosome', tmpChromosome);
    population = [population, tmpIndividual];
  end

end

