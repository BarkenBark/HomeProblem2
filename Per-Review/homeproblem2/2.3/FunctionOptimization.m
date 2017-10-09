close all
clear all
clc
tic

populationSize = 100;
NUMBER_OF_NEURONS = 4; % Number of neurons in the hidden layer
NUMBER_OF_GENES = 26; % Determined by number of neurons
crossoverProbability = 0.3;
mutationProbabilty = 0.08;
tournamentSelectionParameter = 0.75;
variableRange = 10.0;
numberOfGenerations = 10;
tournamentSize = 5;
bestFitnessVector = zeros(1, numberOfGenerations);
maximumValidFitness = 0.0;

population = InitializePopulation(populationSize, NUMBER_OF_GENES);
for iGeneration = 1:numberOfGenerations
  maximumFitness = 0.0;
  maxOfAllSlopes = 0.0;
  fitnessAllSlopes = zeros(populationSize,1);
  fitness = zeros(1, 10);
  bestIndividualIndex = 0;
  
  for i = 1:populationSize
    iDataSet = 1;
    if iDataSet == 1
      for iSlope = 1:10
        chromosome = population(i,:);
        [weights1, weights2, bias1, bias2] = DecodeChromosome(chromosome, variableRange);
        fitness(iSlope) = EvaluateIndividual(weights1, weights2, bias1, bias2, iSlope, iDataSet);
      end
      fitnessAllSlopes(i) = sum(fitness)/10;
      if (fitnessAllSlopes(i) > maximumFitness)
        maximumFitness = fitnessAllSlopes(i);
        bestIndividualIndex = i;
      end
    end
  end
  iDataSet = 2;
  for iSlope = 1:5
    chromosome = population(bestIndividualIndex,:);
    [weights1, weights2, bias1, bias2] = DecodeChromosome(chromosome, variableRange);
    fitnessValid(iSlope) = EvaluateIndividual(weights1, weights2, bias1, bias2, iSlope, iDataSet);
  end
  bestValidFitnessVector(iGeneration) = sum(fitnessValid)/5;
  if maximumValidFitness < bestValidFitnessVector(iGeneration)
    allTimeValidBEst = bestValidFitnessVector(iGeneration);
    weights1Best = weights1;
    weight2Best = weights2;
    bias1Best = bias1;
    bias2Best =bias2;
  end
  
  bestFitnessVector(iGeneration) = maximumFitness;
  
  tempPopulation = population;
  
  for i = 1:2:populationSize
    i1 = TournamentSelect(fitnessAllSlopes,tournamentSelectionParameter, tournamentSize);
    i2 = TournamentSelect(fitnessAllSlopes,tournamentSelectionParameter,tournamentSize);
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
  end % Loop over population
  
  for i = 1:populationSize
    originalChromosome = tempPopulation(i,:);
    mutatedChromosome = Mutate(originalChromosome,mutationProbabilty);
    tempPopulation(i,:) = mutatedChromosome;
  end
  tempPopulation(1,:) = population(bestIndividualIndex,:);
  tempPopulation(2,:) = population(bestIndividualIndex,:);
  
  population = tempPopulation;
  disp(iGeneration)
end

plot(1:numberOfGenerations, bestFitnessVector(1,:))
hold on
plot(1:numberOfGenerations, bestValidFitnessVector(1,:))
toc