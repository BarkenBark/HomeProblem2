%% Main code

iTrainingSet = 1;
iValidationSet = 2;
iTestSet = 3;

%Controller properties
nbrOfHiddenNeurons = 7;
networkDimensions = [3, nbrOfHiddenNeurons, 2];
weightInterval = [-2, 2];
thresholdInterval = weightInterval;


%% Genetic Algorithm

NUMBER_OF_GENERATIONS = 500;
COPIES_OF_BEST_INDIVIDUAL = 1;
HOLDOUT_THRESHOLD = -realmax; %HOLDOUT_THRESHOLD iterations without improvement => termination

populationSize = 100; %POPULATION_SIZE?
[nbrOfWeights, nbrOfThresholds] = GetNbrOfWeights(networkDimensions);
nbrOfGenes = nbrOfWeights + nbrOfThresholds;
mutationProbability = 1/nbrOfGenes;
creepRate = 0.10;
creepProbability = 0.9;
tournamentSelectionParameter = 0.8;
tournamentSize = 2;
crossoverProbability = 0.3;

population = InitializePopulation(populationSize, networkDimensions);

maximumTrainingFitness = zeros(NUMBER_OF_GENERATIONS, 1);
maximumValidationFitness = zeros(NUMBER_OF_GENERATIONS, 1);
prevMaximumValidationFitness = 0;
maximumValidationFitnessSoFar = 0;
bestValidationIndividual = zeros(1, nbrOfGenes);

t = tic;
for iGeneration = 1:NUMBER_OF_GENERATIONS
  
  %Evaluate individuals
  trainingFitness = zeros(populationSize, 1);
  validationFitness = zeros(populationSize, 1);
  maximumTrainingFitness(iGeneration) = 0.0;
  maximumValidationFitness(iGeneration) = 0.0;
  bestIndividualIndex = 0; %Based on training set, for GA feedback
  
  for iIndividual = 1:populationSize
    chromosome = population(iIndividual,:);
    network = DecodeChromosome(chromosome, networkDimensions, ...
      weightInterval, thresholdInterval);
    trainingFitness(iIndividual) = EvaluateIndividual(network, iTrainingSet);
    validationFitness(iIndividual) = EvaluateIndividual(network, iValidationSet);
    
    if trainingFitness(iIndividual) > maximumTrainingFitness(iGeneration)
      maximumTrainingFitness(iGeneration) = trainingFitness(iIndividual);
      bestIndividualIndex = iIndividual;
    end
    
    if validationFitness(iIndividual) > maximumValidationFitness(iGeneration)
      maximumValidationFitness(iGeneration) = validationFitness(iIndividual);
      bestValidationIndividualIndex = iIndividual;
    end
  end
  bestIndividual = population(bestIndividualIndex, :);
  
  if iGeneration > 1
  deltaValidationFitness = maximumValidationFitness(iGeneration) - ...
    maximumValidationFitness(iGeneration-1);
  else
    deltaValidationFitness = maximumValidationFitness(iGeneration);
  end
  
%   if deltaValidationFitness < 0
%     holdoutStrikes = holdoutStrikes + 1;
%     if holdOutStrikes == HOLDOUT_THRESHOLD
%       fprintf('hurr')
%       break
%     end
%   end
  
  if maximumValidationFitness(iGeneration) > maximumValidationFitnessSoFar
    maximumValidationFitnessSoFar = maximumValidationFitness(iGeneration);
    bestValidationIndividual = population(bestValidationIndividualIndex,:);
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

  for i = 1:populationSize
    originalChromosome = tempPopulation(i,:);
    mutatedChromosome = Mutate(originalChromosome, mutationProbability, ...
      creepRate, creepProbability);
    tempPopulation(i,:) = mutatedChromosome;
  end

  tempPopulation = InsertBestIndividual(tempPopulation, bestIndividual, ...
    COPIES_OF_BEST_INDIVIDUAL);
  population = tempPopulation;
 
  if mod(iGeneration, NUMBER_OF_GENERATIONS/10)==0
    t = toc(t);
    fprintf('Generation %d/%d complete after %.2f seconds.\n', ...
      iGeneration, NUMBER_OF_GENERATIONS, t)
    t = tic;
  end
 
end










