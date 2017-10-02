%% LGP24
clc; clear all;

dataset = LoadFunctionData;

nbrOfVariableRegisters = 3; %As many as you like
constantRegisters = [1 3 -1]; %As many as you like
nbrOfConstantRegisters = length(constantRegisters);
encodingSetSizes = [4, nbrOfVariableRegisters, nbrOfConstantRegisters];

populationSize = 100;
tournamentSelectionParameter = 0.75;
tournamentSize = 5;
mutationProbability = 1; %Initial value only
crossoverProbability = 0.2;
minNbrOfInstructions = 5;
maxNbrOfInstructions = 30;

NUMBER_OF_GENERATIONS = 5000;
COPIES_OF_BEST_INDIVIDUAL = 1;

%% Run GA

fitness = zeros(populationSize, 1);
population = InitializePopulation(populationSize, encodingSetSizes, minNbrOfInstructions, maxNbrOfInstructions);

for iGeneration = 1:NUMBER_OF_GENERATIONS
  t = tic;
  
  %Find best individual of population to preserve it for next generation
  maximumFitness = 0.0;
  bestIndividualIndex = 0;
  for i = 1:populationSize
    chromosome = population(i).Chromosome;
    fitness(i) = EvaluateIndividual(chromosome, dataset, ...
      nbrOfVariableRegisters, constantRegisters, maxNbrOfInstructions);
    if (fitness(i) > maximumFitness)
      maximumFitness = fitness(i);
      bestIndividualIndex = i;
    end
  end
  bestIndividual = population(bestIndividualIndex).Chromosome;

  tempPopulation = population;

  %Carry out selection and crossover
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

  t = toc(t);
  fprintf('Generation %d completed after %.2f seconds.\n', iGeneration, t);
  
end

%Find best individual of population to evaluate
maximumFitness = 0.0;
bestIndividualIndex = 0;
for i = 1:populationSize
  chromosome = population(i).Chromosome;
  fitness(i) = EvaluateIndividual(chromosome, dataset, ...
      nbrOfVariableRegisters, constantRegisters, maxNbrOfInstructions);
  if (fitness(i) > maximumFitness)
    maximumFitness = fitness(i);
    bestIndividualIndex = i;
  end
end

load handel
sound(y,Fs)

