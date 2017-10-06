clc
clear all
tic
NUMBER_OF_GENERATIONS = 10000;
NUMBER_OF_ELITISM_COPIES = 1;
POPULATION_SIZE = 300;
TOURNAMENT_SELECTION_PARAMETER = 0.6;
TOURNAMENT_SIZE = 2;
NUMBER_OF_HIDDEN_NEURONS = 8;
crossoverProbability = 0.5;

nbrOfInputs = 3;
nbrOfOutputs = 2;

population = InitializePopulation(POPULATION_SIZE, NUMBER_OF_HIDDEN_NEURONS,...
    nbrOfInputs,nbrOfOutputs);

numberOfGenes = size(population,2);
mutationProbability = 3/numberOfGenes;

fitnessValues = zeros(POPULATION_SIZE,1);
maximumTrainingFitness = zeros(1,NUMBER_OF_GENERATIONS);
validationFitness = zeros(1,NUMBER_OF_GENERATIONS);

bestValidationFitness = 0.0;
dataset1 = 1;
dataset2 = 2;
dataset3 = 3;

for iGeneration = 1:NUMBER_OF_GENERATIONS
    
    for i = 1:POPULATION_SIZE
        chromosome = population(i,:);
        network = DecodeChromosome(chromosome,NUMBER_OF_HIDDEN_NEURONS,...
            nbrOfInputs,nbrOfOutputs);
        
        fitnessValues(i) = EvaluateIndividual(network,dataset1);
        
        if(fitnessValues(i) > maximumTrainingFitness(iGeneration))
            maximumTrainingFitness(iGeneration) = fitnessValues(i);
            bestIndividualIndex = i;
            %PlotPath(connection,cityLocation,chromosome);
        end
    end
    %maximumFitnessValues(iGeneration) = maximumFitness;
    tempPopulation = population;
    
    for i = 1:2:POPULATION_SIZE
        winner1 = TournamentSelect(fitnessValues,...
            TOURNAMENT_SELECTION_PARAMETER,TOURNAMENT_SIZE);
        
        winner2 = TournamentSelect(fitnessValues,...
            TOURNAMENT_SELECTION_PARAMETER,TOURNAMENT_SIZE);
        
        chromosome1 = population(winner1,:);
        chromosome2 = population(winner2,:);
        
        [ newChromosome1, newChromosome2] = Cross( chromosome1, chromosome2,...
            crossoverProbability);
        tempPopulation(i,:) = newChromosome1;
        tempPopulation(i+1,:) = newChromosome2;
    end
    
    for i = 1:POPULATION_SIZE
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate( originalChromosome, mutationProbability,...
            NUMBER_OF_HIDDEN_NEURONS,nbrOfInputs,nbrOfOutputs);
        tempPopulation(i,:) = mutatedChromosome;
    end
    
    bestIndividual = population(bestIndividualIndex,:);
    tempPopulation = InsertBestIndividual( tempPopulation, bestIndividual,...
        NUMBER_OF_ELITISM_COPIES );
    bestIndividualIndex = 1;
    
    bestNetwork = DecodeChromosome(bestIndividual,NUMBER_OF_HIDDEN_NEURONS,...
        nbrOfInputs,nbrOfOutputs);
    validationFitness(iGeneration) = EvaluateIndividual(bestNetwork,dataset2);
    
    if(validationFitness(iGeneration) > bestValidationFitness)
        bestValidationFitness = validationFitness(iGeneration);
        bestValidationNetwork = bestNetwork;
    end
    
    population = tempPopulation;
    
end

testFitness = EvaluateIndividual(bestValidationNetwork,dataset3)
toc



