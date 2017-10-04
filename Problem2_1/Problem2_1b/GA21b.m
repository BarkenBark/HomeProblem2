%clear all; clc;
%close all

cityLocations = LoadCityLocations;
nbrOfCities = length(cityLocations);
tspFigure = InitializeTspPlot(cityLocations, [0 20 0 20]); 
connection = InitializeConnections(cityLocations); 

NUMBER_OF_GENERATIONS = 10000;
NUMBER_OF_GENES = nbrOfCities;
COPIES_OF_BEST_INDIVIDUAL = 1;

populationSize = 200;
mutationProbability = 0.04;
tournamentSelectionParameter = 0.8;
tournamentSize = 2;

%% Start genetic algorithm

fitness = zeros(populationSize,1);
population = InitializePopulation(populationSize, NUMBER_OF_GENES);

t = tic;
prevMaximumFitness = 0;
for iGeneration = 1:NUMBER_OF_GENERATIONS

  %Find best individual of population to preserve it for next generation
  if iGeneration > 1
    prevMaximumFitness = maximumFitness;
  end
  maximumFitness = 0.0;
  bestIndividualIndex = 0;
  for i = 1:populationSize
    chromosome = population(i,:);
    fitness(i) = EvaluateIndividual(chromosome, cityLocations);
    if (fitness(i) > maximumFitness)
      maximumFitness = fitness(i);
      bestIndividualIndex = i;
    end
  end
  bestIndividual = population(bestIndividualIndex, :);
  
  if maximumFitness > prevMaximumFitness
    PlotPath(connection, cityLocations, bestIndividual);
  end
  
  tempPopulation = population;

  for i = 1:2:populationSize
    i1 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
    i2 = TournamentSelect(fitness, tournamentSelectionParameter, tournamentSize);
    chromosome1 = population(i1,:);
    chromosome2 = population(i2,:);
    tempPopulation(i,:) = chromosome1;
    tempPopulation(i+1,:) = chromosome2;
  end

  for i = 1:populationSize
    originalChromosome = tempPopulation(i,:);
    mutatedChromosome = Mutate(originalChromosome, mutationProbability);
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

%Find best individual of population to evaluate
maximumFitness = 0.0;
bestIndividualIndex = 0;
for i = 1:populationSize
  chromosome = population(i,:);
  fitness(i) = EvaluateIndividual(chromosome, cityLocations);
  if (fitness(i) > maximumFitness)
    maximumFitness = fitness(i);
    bestIndividualIndex = i;
  end
end
bestIndividual = population(bestIndividualIndex, :);
PlotPath(connection, cityLocations, bestIndividual);

bestPathLength = GetPathLength(bestIndividual, cityLocations);
disp(' ')
fprintf('Path length of best path found: %.2f.\n', bestPathLength)



