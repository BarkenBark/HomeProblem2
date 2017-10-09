function [ population ] = InitializePopulation( populationSize, nGenes )

population = zeros(populationSize,nGenes);
for i = 1:populationSize
  population(i,1:nGenes)  = randperm(nGenes);
end

end

