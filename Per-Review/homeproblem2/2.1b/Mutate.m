function mutatedChromosome = Mutate(chromosome,mutationProbability)
% Function that will swap a genes with a random one
nGenes = size(chromosome,2);
mutatedChromosome = chromosome;
for j = 1:nGenes
  r = rand;
  if (r < mutationProbability)
    randomIndex = randi(nGenes);
    mutatedChromosome([j randomIndex]) = mutatedChromosome([randomIndex j]);
  end
end

end

