close all
clear all
clc
clf
tic
populationSize = 200;
minNumberOfGenes = 4*25;
maxNumberOfGenes = 4*70;
crossoverProbability = 0.2;
pTournament = 0.75;
numberOfGenerations = 0;
mutationProbabilty = 0.03;
tournamentSize = 5;
fitness = zeros(populationSize,1);

functionData = LoadFunctionData;
CONSTANTS = [1 3 -1];


population = InitializePopulation(populationSize, minNumberOfGenes,...
  maxNumberOfGenes);

bestFitnessAll = 0.0;
maximumFitness = 0.0;
while (1/maximumFitness) > 0.01
  numberOfGenerations = numberOfGenerations +1;
  maximumFitness = 0.0;
  bestIndividualIndex = 0;
  yHat = zeros(1, length(functionData));
  for i = 1:populationSize
    chromosome = population(i).Chromosome;
    for j = 1:length(functionData)
      register = [functionData(j,1) 0 0];
      yHat(j) = DecodeChromosome(chromosome, register, CONSTANTS);
    end
    fitness(i) = EvaluateIndividual(yHat,functionData);
    if length(chromosome) > 150 %Pentalty for chromosome over length 150
      fitness(i) = fitness(i)*0.8;
    end
    if (fitness(i) > maximumFitness)
      maximumFitness = fitness(i);
      bestIndividualIndex = i;
      bestYhat = yHat;
      xBest = population(i).Chromosome;
      drawnow
    end
    
  end
  
  
  tempPopulation = population;
  
  for i = 1:2:populationSize
    i1 = TournamentSelect(fitness, pTournament, tournamentSize);
    i2 = TournamentSelect(fitness, pTournament, tournamentSize);
    chromosome1 = population(i1).Chromosome;
    chromosome2 = population(i2).Chromosome;
    
    if length(chromosome2) > 4 && length(chromosome1) > 4
      r = rand;
      if (r < crossoverProbability)
        newChromosomePair = Cross(chromosome1, chromosome2);
        tempPopulation(i).Chromosome = newChromosomePair(1).NewChromosome;
        tempPopulation(i+1).Chromosome = newChromosomePair(2).NewChromosome;
      else
        tempPopulation(i).Chromosome = chromosome1;
        tempPopulation(i+1).Chromosome = chromosome2;
      end
    else
      continue
    end
    
  end
  
  for k = 1:populationSize
    originalChromosome = tempPopulation(k).Chromosome;
    mutatedChromosome = Mutate(originalChromosome,mutationProbabilty);
    tempPopulation(k).Chromosome = mutatedChromosome;
  end
  tempPopulation(1).Chromosome = population(bestIndividualIndex).Chromosome;
  
  population = tempPopulation;
  if bestFitnessAll < maximumFitness
    bestFitnessAll = maximumFitness;
    rms = 1/bestFitnessAll;
    hold off
    figure(1)
    plot(functionData(:,1),functionData(:,2), 'ro')
    hold on
    plot(functionData(:,1), bestYhat(1,:), 'bo')
  end
end
functionBest = SymbolicFunctionOfChomosome(xBest);
disp('The polynomial found is')
disp(functionBest)
toc