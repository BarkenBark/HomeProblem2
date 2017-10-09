close all
clc
clear all
tic
format long
populationSize = 100;
numberOfCities = 50;
mutationProbabilty = 0.025;
tournamentSelectionParameter = 0.75;
numberOfGenerations = 100;
numberOfBestIndividuals = 1;
fitness = zeros(populationSize,1);

cityLocation = LoadCityLocations;
nCities = size(cityLocation,1);
path = randperm(nCities);
tspFigure = InitializeTspPlot(cityLocation,[0 20 0 20]);
connection = InitializeConnections(cityLocation);
PlotPath(connection,cityLocation,path);

population = InitializePopulation(populationSize, numberOfCities);

for iGeneration = 1:numberOfGenerations
  maximumFitness = 0.0;
  xBestPathLength = zeros(1,2);
  bestIndividualIndex = 0;
  for i = 1:populationSize
    chromosome = population(i,:);
    x = DecodeChromosome(chromosome, cityLocation);
    decodedPopulation(i,:) = x;
    fitness(i) = EvaluateIndividual(x);
    if (fitness(i) > maximumFitness)
      maximumFitness = fitness(i);
      bestIndividualIndex = i;
      xBestPathLength = x;
      path = population(i,:);
      PlotPath(connection,cityLocation,path);
    end
  end
  
  tempPopulation = population;
  
  for i = 1:2:populationSize
    i1 = TournamentSelect(fitness,tournamentSelectionParameter);
    i2 = TournamentSelect(fitness,tournamentSelectionParameter);
    chromosome1 = population(i1,:);
    chromosome2 = population(i2,:);
    
    r = rand;
    tempPopulation(i,:) = chromosome1;
    tempPopulation(i+1,:) = chromosome2;
  end % Loop over population
  
  for i = 1:populationSize
    originalChromosome = tempPopulation(i,:);
    mutatedChromosome = Mutate(originalChromosome,mutationProbabilty);
    tempPopulation(i,:) = mutatedChromosome;
  end
  bestIndividual = population(bestIndividualIndex,:);
  tempPopulation = InsertBestIndividual(tempPopulation, bestIndividual,numberOfBestIndividuals);
  population = tempPopulation;
  
  
end

toc