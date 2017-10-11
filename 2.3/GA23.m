%% Main code
clc; clear all
clf; close all

iTrainingSet = 1;
iValidationSet = 2;
iTestSet = 3;

%Controller/Network properties
nbrOfHiddenNeurons = 8;
networkDimensions = [3, nbrOfHiddenNeurons, 2];
weightInterval = [-14, 14];
thresholdInterval = weightInterval;


%% Genetic Algorithm
NUMBER_OF_GENERATIONS = 10;
COPIES_OF_BEST_INDIVIDUAL = 1;
HOLDOUT_THRESHOLD = 100; %No. generations to wait for improvement before termination

populationSize = 10;
[nbrOfWeights, nbrOfThresholds] = GetNbrOfWeightsAndThresholds(networkDimensions);
nbrOfGenes = nbrOfWeights + nbrOfThresholds;

mutationProbability = 4/nbrOfGenes;
creepRate = 0.25;
creepProbability = 0.85;
tournamentSelectionParameter = 0.70;
tournamentSize = 2;
crossoverProbability = 0.3;

population = InitializePopulation(populationSize, networkDimensions);

maximumTrainingFitness = zeros(NUMBER_OF_GENERATIONS, 1);
maximumValidationFitness = zeros(NUMBER_OF_GENERATIONS, 1);
prevMaximumValidationFitness = 0;
maximumValidationFitnessSoFar = 0;
bestValidationIndividual = zeros(1, nbrOfGenes);

t = tic;
holdoutStrikes = 0;
for iGeneration = 1:NUMBER_OF_GENERATIONS

  %Evaluate population
  trainingFitness = zeros(populationSize, 1);
  validationFitness = zeros(populationSize, 1);
  iBestIndividual = 0;
  for iIndividual = 1:populationSize
    chromosome = population(iIndividual,:);
    network = DecodeChromosome(chromosome, networkDimensions, ...
      weightInterval, thresholdInterval);
    trainingFitness(iIndividual) = EvaluateIndividual(network, iTrainingSet);
    if trainingFitness(iIndividual) > maximumTrainingFitness(iGeneration)
      maximumTrainingFitness(iGeneration) = trainingFitness(iIndividual);
      iBestIndividual = iIndividual;
      bestNetwork = network;
    end
  end
  bestIndividual = population(iBestIndividual, :);
  
  maximumValidationFitness(iGeneration) = EvaluateIndividual(bestNetwork, iValidationSet);
  if maximumValidationFitness(iGeneration) > maximumValidationFitnessSoFar
    maximumValidationFitnessSoFar = maximumValidationFitness(iGeneration);
    bestValidationIndividual = bestIndividual;
    holdoutStrikes = 0;
  else
    holdoutStrikes = holdoutStrikes + 1;
    if holdoutStrikes == HOLDOUT_THRESHOLD
      fprintf(strcat('Optimization terminated due to no increase of',  ...
        ' maximum validation fitness in %d generations.\n'), HOLDOUT_THRESHOLD)
      maximumTrainingFitness(iGeneration+1:end) = [];
      maximumValidationFitness(iGeneration+1:end) = [];
      break
    end
  end
      
  clf
  hold on
  plot(maximumTrainingFitness(1:iGeneration))
  plot(maximumValidationFitness(1:iGeneration))
  set(gca, 'FontSize', 14)
  xlabel('Generation')
  ylabel('Fitness')
  legend({'Training', 'Validation'}, 'Location', 'southeast')
  drawnow
  
  if iGeneration == NUMBER_OF_GENERATIONS
    fprintf('All %d generations completed.\n', NUMBER_OF_GENERATIONS);
    break
  end
  
  tempPopulation = population;

  %Selection and crossover
  for i = 1:2:populationSize
    i1 = TournamentSelect(trainingFitness, tournamentSelectionParameter, tournamentSize);
    i2 = TournamentSelect(trainingFitness, tournamentSelectionParameter, tournamentSize);
    chromosome1 = population(i1,:);
    chromosome2 = population(i2,:);
    
    r = rand;
    if (r < crossoverProbability)
      newChromosomePair = Cross(chromosome1, chromosome2);
      tempPopulation(i,:) = newChromosomePair(1,:);
      tempPopulation(i+1,:) = newChromosomePair(2,:);
    else
      tempPopulation(i,:) = chromosome1;
      tempPopulation(i+1,:) = chromosome2;
    end
  end

  %Mutation
  for i = 1:populationSize
    originalChromosome = tempPopulation(i,:);
    mutatedChromosome = Mutate(originalChromosome, mutationProbability, ...
      creepRate, creepProbability);
    tempPopulation(i,:) = mutatedChromosome;
  end

  tempPopulation = InsertBestIndividual(tempPopulation, bestIndividual, ...
    COPIES_OF_BEST_INDIVIDUAL);
  population = tempPopulation;
 
  if mod(iGeneration, NUMBER_OF_GENERATIONS/50)==0
    t = toc(t);
    fprintf('Generation %d/%d complete after %.2f seconds.\n', ...
      iGeneration, NUMBER_OF_GENERATIONS, t)
    t = tic;
  end
 
end








