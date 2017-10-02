%% Main code

%Dataset
iSlope = 1;
iDataset = 1;

%Initial values
brakeTemperature = 500;
speed = 20;
xPosition = 0;
%slopeAngle = GetSlopeAngle(xPosition, iSlope, iDataset);

%Controllables
brakePressure = 0.2;
gear = 7;

%Controller properties
nbrOfHiddenNeurons = 8;
networkDimensions = [3, nbrOfHiddenNeurons, 2];
weightInterval = [-5, 5];
thresholdInterval = weightInterval;


%% Genetic Algorithm

NUMBER_OF_GENERATIONS = 100;
COPIES_OF_BEST_INDIVIDUAL = 1;

populationSize = 100; %POPULATION_SIZE?
[nbrOfWeights, nbrOfThresholds] = GetNbrOfWeights(networkDimensions);
nbrOfGenes = nbrOfWeights + nbrOfThresholds;
mutationProbability = 1/nbrOfGenes;
creepRate = 0.20;
creepProbability = 0.7;
tournamentSelectionParameter = 0.8;
tournamentSize = 2;
crossoverProbability = 0.8;

fitness = zeros(populationSize, 1);
population = InitializePopulation(populationSize, networkDimensions);

t = tic;
for iGeneration = 1:NUMBER_OF_GENERATIONS
  
  %Find best individual of population to preserve it for next generation
  if iGeneration > 1
    prevMaximumFitness = maximumFitness;
  end
  maximumFitness = 0.0;
  bestIndividualIndex = 0;
  for i = 1:populationSize
    chromosome = population(i,:);
    network = DecodeChromosome(chromosome, networkDimensions, ...
      weightInterval, thresholdInterval);
    fitness(i) = EvaluateIndividual(network);
    if (fitness(i) > maximumFitness)
      maximumFitness = fitness(i);
      bestIndividualIndex = i;
    end
  end
  bestIndividual = population(bestIndividualIndex, :);
  
  tempPopulation = population;

  %Selection and crossover
  for i = 1:2:populationSize
    i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
    i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
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

  tempPopulation = InsertBestIndividual(tempPopulation, bestIndividual, COPIES_OF_BEST_INDIVIDUAL);
  population = tempPopulation;

  if mod(iGeneration, NUMBER_OF_GENERATIONS/10)==0
    t = toc(t);
    fprintf('Generation %d/%d complete after %.2f seconds.\n', ...
      iGeneration, NUMBER_OF_GENERATIONS, t)
    t = tic;
  end
 
end










