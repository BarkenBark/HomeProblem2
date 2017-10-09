function mutatedChromosome = Mutate(chromosome,mutationProbability)
% Function that carries out creep mutation
nGenes = size(chromosome,2);
mutatedChromosome = chromosome;
for j = 1:nGenes
  r = rand;
  if (r < mutationProbability)
    k = rand;
    if k < rand
      mutatedChromosome(j) = chromosome(j) + rand*0.18;
    else
      mutatedChromosome(j) = chromosome(j) - rand*0.18;
    end
    if mutatedChromosome(j) >= 1
      mutatedChromosome(j) = 1;
    end
    if mutatedChromosome(j) <= 0
      mutatedChromosome(j) = 0;
    end
  end
end

end

