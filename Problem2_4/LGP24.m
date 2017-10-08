%% LGP24
clc; clear all;

dataset = LoadFunctionData;

nbrOfVariableRegisters = 3;
constantRegisters = [1 3 -1];
nbrOfConstantRegisters = length(constantRegisters);
encodingSetSizes = [4, nbrOfVariableRegisters, nbrOfConstantRegisters];
minNbrOfInstructions = 5;
maxNbrOfInstructions = 30;

populationSize = 100;
tournamentSelectionParameter = 0.75;
tournamentSize = 5;
mutationProbability = 1.03; %Initial value
crossoverProbability = 0.2;

NUMBER_OF_GENERATIONS = 5000;
COPIES_OF_BEST_INDIVIDUAL = 1;

%% Run GA
fitness = zeros(populationSize, 1);
population = InitializePopulation(populationSize, encodingSetSizes, minNbrOfInstructions, maxNbrOfInstructions);

t = tic;
for iGeneration = 1:NUMBER_OF_GENERATIONS
  
  %Evaluate population
  maximumFitness = 0.0;
  iBestIndividual = 0;
  for i = 1:populationSize
    chromosome = population(i).Chromosome;
    fitness(i) = EvaluateIndividual(chromosome, dataset, ...
      nbrOfVariableRegisters, constantRegisters, maxNbrOfInstructions);
    if (fitness(i) > maximumFitness)
      maximumFitness = fitness(i);
      iBestIndividual = i;
    end
  end
  bestIndividual = population(iBestIndividual).Chromosome;
  
  if maximumFitness == realmax %If perfect solution is found
    break
  end

  tempPopulation = population;

  %Selection and crossover
  for i = 1:2:populationSize
    i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
    i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
    chromosome1 = population(i1).Chromosome;
    chromosome2 = population(i2).Chromosome;

    r = rand;
    if (r < crossoverProbability)
      [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2);
      tempPopulation(i).Chromosome = newChromosome1;
      tempPopulation(i+1).Chromosome = newChromosome2;
    else
      tempPopulation(i).Chromosome = chromosome1;
      tempPopulation(i+1).Chromosome = chromosome2;
    end
  end

  %Mutate offspring
  for i = 1:populationSize
    originalChromosome = tempPopulation(i).Chromosome;
    mutatedChromosome = Mutate(originalChromosome, mutationProbability, ...
      encodingSetSizes);
    tempPopulation(i).Chromosome = mutatedChromosome;
  end
  
  mutationProbability = exp(-iGeneration/100) + 0.03;

  tempPopulation = InsertBestIndividual(tempPopulation, bestIndividual, COPIES_OF_BEST_INDIVIDUAL);
  population = tempPopulation;

  if mod(iGeneration, NUMBER_OF_GENERATIONS/500)==0
    t = toc(t);
    fprintf('Generation %d/%d complete after %.2f seconds.\n', ...
      iGeneration, NUMBER_OF_GENERATIONS, t)
    t = tic;
  end
  
end

%Find best individual of population to evaluate
maximumFitness = 0.0;
iBestIndividual = 0;
for i = 1:populationSize
  chromosome = population(i).Chromosome;
  fitness(i) = EvaluateIndividual(chromosome, dataset, ...
      nbrOfVariableRegisters, constantRegisters, maxNbrOfInstructions);
  if (fitness(i) > maximumFitness)
    maximumFitness = fitness(i);
    iBestIndividual = i;
  end
end

