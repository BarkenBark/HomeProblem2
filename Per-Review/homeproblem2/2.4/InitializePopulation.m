function [ population ] = InitializePopulation( populationSize, minNumberOfGenes, maxNumberOfGenes )

population = [];
for k =1:populationSize
  nGenes = randi([minNumberOfGenes/4 maxNumberOfGenes/4])*4;
  tmpChromosome = zeros(1,length(nGenes));
  for i = 1:4:(nGenes-3)
    tmpChromosome(i) = randi(4);
    tmpChromosome(i+1) = randi(3);
    tmpChromosome(i+2) = randi(6);
    tmpChromosome(i+3) = randi(6);
  end
  tmpIndividual = struct('Chromosome',tmpChromosome);
  population = [population tmpIndividual];
end

end

